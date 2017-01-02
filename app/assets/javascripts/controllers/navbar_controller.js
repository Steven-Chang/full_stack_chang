app.controller('NavCtrl', ['$scope', 'Auth', '$rootScope', '$state', function($scope, Auth, $rootScope, $state){
  $scope.signedIn = Auth.isAuthenticated;
  $scope.logout = function(){
    Auth.logout().then(function(oldUser){
      // This should happen automatically and it does
      // but if I don't have this code here, then for some reason
      // If I do a browser refresh, the browser thinks i'm still logged in.
      console.log( "Logged Out" );
    }, function(error){
      console.log( "Error" );
    });
  };

  Auth.currentUser().then(function (user){
    $rootScope.user = user
  });

  $scope.$on('devise:new-registration', function (e, user){
    $rootScope.user = user
  });

  $scope.$on('devise:login', function (e, user){
    $rootScope.user = user
  });

  // This is broadcast supposedly
  $scope.$on('devise:logout', function (e, user){
    $rootScope.user = undefined
  });
}])