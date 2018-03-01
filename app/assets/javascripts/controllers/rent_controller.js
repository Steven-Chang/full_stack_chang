app.controller('RentController', ['$filter', '$scope', '$timeout', 'Auth', 'Restangular', function( $filter, $scope, $timeout, Auth, Restangular ){

  // PRIVATE
  var updateUsersBalance = function( tenant_id ){
    Restangular
      .one("users", tenant_id)
      .customGET('balance')
      .then(function( response ){
        $scope.balance = response.balance;
      });
  };

  var updateUsersBond = function( tenant_id ){
    Restangular
      .one("users", tenant_id)
      .customGET('bond')
      .then(function( response ){
        $scope.bond = response.bond;
      });
  };

  // PUBLIC
  $scope.balance;
  $scope.bond;
  $scope.currentUser;
  $scope.newTransaction = {
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    user_id: undefined
  };
  $scope.password;
  $scope.selectedTenant;
  $scope.tenants;
  $scope.transactions;

  $timeout(function(){
    $('#date-picker').datepicker({
      format: 'D dd MM yyyy'
    });
  }, 100);

  $scope.createRentTransaction = function(){
    Restangular.all('rent_transactions')
      .post( $scope.newTransaction )
      .then(function( response ){
        $scope.transactions.unshift( response );
        updateUsersBalance( $scope.newTransaction.user_id );
        updateUsersBond( $scope.newTransaction.user_id )
      });
  };

  $scope.getTransactions = function( tenant ){
    $scope.selectedTenant = tenant;
    $scope.transactions = undefined;
    $scope.password = undefined;
    Restangular
      .all('rent_transactions')
      .getList({ user_id: tenant.id })
      .then(function( transactions ){
        $scope.transactions = transactions;
      });

    updateUsersBond( tenant.id );
    updateUsersBalance( tenant.id );
  };

  $scope.init = function(){
    Restangular
      .all('tenants')
      .getList()
      .then(function( tenants ){
        $scope.tenants = tenants;
        $scope.newTransaction.user_id = tenants[0].id
      });

    Auth
      .currentUser()
      .then(function( user ){
        $scope.currentUser = user;
      });
  };
}]);