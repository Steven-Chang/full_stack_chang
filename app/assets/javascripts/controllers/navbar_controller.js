app.controller('NavCtrl', ['$scope', 'Auth', '$rootScope', '$state', '$location', function($scope, Auth, $rootScope, $state, $location){
  $scope.signedIn = Auth.isAuthenticated;

  Auth.currentUser().then(function (user){
    $rootScope.user = user
  });


  $scope.logout = function(){
    Auth.logout().then(function(oldUser){
      // This should happen automatically and it does
      // but if I don't have this code here, then for some reason
      // If I do a browser refresh, the browser thinks i'm still logged in.
      console.log( "Logged Out" );
      $state.go( $location.$$url.split("/")[1] );
      $rootScope.user = undefined
    }, function(error){
      console.log( "Error" );
    });
  };

}])