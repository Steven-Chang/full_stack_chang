app.controller('AuthController', ['$scope', '$rootScope', 'Auth', '$state', '$window', function($scope, $rootScope, Auth, $state, $window){
    var config = {headers: {'X-HTTP-Method-Override': 'POST'}}

    $scope.user = {
      email: "",
      password: "",
      remember_me: true
    }

    $scope.register = function(){
      Auth.register($scope.user, config).then(function(user){
        $rootScope.user = user
        $window.history.back();
      }, function(response){
        console.log("Error");
      });
    };

    $scope.login = function(){
      Auth.login($scope.user, config).then(function(user){
        $rootScope.user = user
        $window.history.back();
      }, function(response){
        console.log("Error");
      });
    }

  }])