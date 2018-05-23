app.controller('FarmingController', ['$filter', '$scope', '$state', 'Auth', 'Restangular', function( $filter, $scope, $state, Auth, Restangular ){

  // Private
  var numberOfDaysUntilNewYear = function(){
    var today = new Date();
    var newYearsDay = new Date("01/01/2019");
    var timeDiff = Math.abs( newYearsDay.getTime() - today.getTime() );
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
    return diffDays
  };

  var calculateCurrentPerDayAim = function(){
    if ( $scope.currentPlusMinus >= $scope.aim ){
      $scope.currentPerDayAim = 0;
    } else {
      $scope.currentPerDayAim = ( $scope.aim - $scope.currentPlusMinus ) / numberOfDaysUntilNewYear()
    };
  };

  var calculatePlusMinus = function(){
    $scope.currentPlusMinus = 0;
    $scope.farmingPlusMinus = 0;
    $scope.gamblingPlusMinus = 0;
    for( var i = 0; i < $scope.farmingTransactions.length; i++ ) {
      $scope.currentPlusMinus += parseInt($scope.farmingTransactions[i].amount);
      if ( $scope.farmingTransactions[i].farming ){
        $scope.farmingPlusMinus += parseInt($scope.farmingTransactions[i].amount);
      } else {
        $scope.gamblingPlusMinus += parseInt($scope.farmingTransactions[i].amount);
      };
    };
  };

  //// PUBLIC ////
  $scope.aim = 25000;
  $scope.creatingFarmingTransaction = false;
  $scope.farmingPlusMinus = 0;
  $scope.gamblingPlusMinus = 0;
  $scope.farmingTransactions;
  $scope.currentPerDayAim = 0;
  $scope.currentPlusMinus = 0;
  $scope.newFarmingTransaction = {
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: "",
    amount: 0,
    odds: "",
    farming: true
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          Restangular.all('farming_transactions')
            .getList()
            .then(function( response ){
              $scope.farmingTransactions = response;
              calculatePlusMinus();
              calculateCurrentPerDayAim();
            }, function( error ){
              console.log( "Couldn't get them transactions from the back end" );
            });
        } else {
          $state.go( 'home' )
        };
      }, function( error ){
        $state.go( 'home' )
      });
  };

  $scope.createFarmingTransaction = function(){
    if ( !$scope.creatingFarmingTransaction ){
      $scope.creatingRentTransaction = true;
      Restangular.all('farming_transactions')
        .post( $scope.newFarmingTransaction )
        .then(function( response ){
          $scope.farmingTransactions.unshift( response );
          calculatePlusMinus();
          calculateCurrentPerDayAim();
          $scope.newFarmingTransaction.amount = 0;
          $scope.newTransnewFarmingTransactionaction.description = "";
          $scope.newTransnewFarmingTransactionaction.odds = "";
          $scope.creatingFarmingTransaction = false;
        });
    };
  };

}]);