app.controller('FarmingController', ['$scope', '$state', 'Auth', 'Restangular', function( $scope, $state, Auth, Restangular ){

  // Private
  var calculateCurrentPlusMinus = function(){
    if ( $scope.currentPlusMinus >= 0 ){
      $scope.currentPerDayAim = "Achieved!";
    } else {
      $scope.currentPerDayAim = ( $scope.currentPlusMinus * -1 ) / new Date()
    };
  };

  var calculateCurrentPlusMinus = function(){
    for( var i = 0; i < $scope.farming_transactions.length; i++ ) {
      $scope.currentPlusMinus += $scope.farming_transactions.amount;
    };
  };

  //// PUBLIC ////
  $scope.farming_transactions;
  $scope.currentPerDayAim;
  $scope.currentPlusMinus = 0;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          Restangular.all('farming_transactions')
            .getList()
            .then(function( response ){
              $scope.farming_transactions = response;
              calculateCurrentPlusMinus;
              calculateCurrentPerDayAim;
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

}]);