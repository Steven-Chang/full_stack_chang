app.controller('NavCtrl', ['$scope', 'Auth', '$rootScope', '$state', '$location', function($scope, Auth, $rootScope, $state, $location){
  
  $scope.signedIn = Auth.isAuthenticated;

  // This needs to be here for rememberable to work...
  // The user doesn't need to be set
  // but the currentUser() function needs to be called
  Auth.currentUser().then(function (user){
    $rootScope.user = user
  });


  $scope.logout = function(){
    Auth.logout().then(function(oldUser){
      $state.reload();
      $rootScope.user = undefined
    }, function(error){
    });
  };

}])