app.controller('RentController', ['$scope', function( $scope ){
  // PRIVATE

  // PUBLIC
  $scope.cheyennePassword = "ants777"
  $scope.danPassword = "frogs777"
  $scope.sidPassword = "birds777"
  $scope.password;
  $scope.selectedTenant;
  $scope.transactions = [
    {
      date: "31 FEB 2018",
      description: "rent",
      amount: -99
    }
  ];

  $scope.getTenantDetails = function( name ){
    $scope.selectedTenant = name;
  };
}])