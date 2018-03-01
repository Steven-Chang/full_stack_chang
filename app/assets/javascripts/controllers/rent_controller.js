app.controller('RentController', ['$scope', 'Auth', 'Restangular', function( $scope, Auth, Restangular ){
  // PRIVATE

  // PUBLIC
  $scope.balance;
  $scope.bond;
  $scope.currentUser;
  $scope.cheyennePassword = "ants777";
  $scope.danPassword = "frogs777";
  $scope.sidPassword = "birds777";
  $scope.password;
  $scope.selectedTenant;
  $scope.tenants;
  $scope.transactions;

  $scope.getTransactions = function( tenant ){
    $scope.selectedTenant = tenant;
    $scope.transactions = undefined;
    Restangular
      .all('rent_transactions')
      .getList({ user_id: tenant.id })
      .then(function( transactions ){
        $scope.transactions = transactions;
      });

    Restangular
      .one("users", tenant.id)
      .customGET('bond')
      .then(function( response ){
        $scope.bond = response.bond;
      });

    Restangular
      .one("users", tenant.id)
      .customGET('balance')
      .then(function( response ){
        $scope.balance = response.balance;
      });
  };

  $scope.init = function(){
    Restangular
      .all('tenants')
      .getList()
      .then(function( tenants ){
        $scope.tenants = tenants;
      });

    Auth
      .currentUser()
      .then(function( user ){
        $scope.currentUser = user;
      });
  };
}]);