app.controller('RentController', ['$filter', '$rootScope', '$scope', '$timeout', 'Auth', 'DisplayService', 'Restangular', function( $filter, $rootScope, $scope, $timeout, Auth, DisplayService, Restangular ){

  // PRIVATE
  var config = {headers: {'X-HTTP-Method-Override': 'POST'}}

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
  $scope.addRentFormVisible = true;
  $scope.addTenantFormVisible = false;
  $scope.balance;
  $scope.creatingRentTransaction = false;
  $scope.bond;
  $scope.currentUser = $rootScope.user;

  $scope.newTenant = {
    email: "",
    username: "",
    remember_me: false,
    tenant: true
  };

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

  $scope.$watch('$root.user', function(){
    $scope.currentUser = $rootScope.user;
  });

  $scope.createRentTransaction = function(){
    if ( !$scope.creatingRentTransaction ){
      $scope.creatingRentTransaction = true;
      Restangular.all('rent_transactions')
        .post( $scope.newTransaction )
        .then(function( response ){
          if( $scope.selectedTenant.id === response.user_id ){
            $scope.transactions.unshift( response );
            updateUsersBalance( $scope.newTransaction.user_id );
            updateUsersBond( $scope.newTransaction.user_id );
          };
          $scope.newTransaction.amount = 0;
          $scope.newTransaction.description = "";
          $scope.creatingRentTransaction = false;
        });
    };
  };

  $scope.createTenant = function(){
    Auth.register($scope.newTenant, config)
    .then(function( tenant ){
      $scope.newTenant.email = "";
      $scope.newTenant.username = "";
      $scope.tenants.push( tenant );
    }, function(response){
      console.log("Error");
    });
  };

  $scope.deleteRentTransaction = function( $index ) {
    $scope.transactions[$index].remove()
      .then(function(){
        $scope.transactions.splice( $index, 1  );
        updateUsersBalance( $scope.selectedTenant.id );
        updateUsersBond( $scope.selectedTenant.id );
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
  };

  $scope.slideToggleContainer = function( id ){
    DisplayService.slideToggleContainer( id );
  };
}]);