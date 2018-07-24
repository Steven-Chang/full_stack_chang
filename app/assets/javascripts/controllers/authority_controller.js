app.controller('AuthController', ['$scope', '$rootScope', 'Auth', '$state', '$window', 'AlertService', 'FSCModalService', function($scope, $rootScope, Auth, $state, $window, AlertService, FSCModalService){
    var config = {headers: {'X-HTTP-Method-Override': 'POST'}}

    $scope.formSubmitted = false;

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

    $scope.login = function( form ){
      $scope.formSubmitted = true;
      if ( !form.$valid ){
        return;
      };

      FSCModalService.showLoading();
      Auth.login($scope.user, config).then(function(user){
        $rootScope.user = user;
        FSCModalService.loading = false;
        $window.history.back();
      }, function(response){
        FSCModalService.loading = false;
        AlertService.processErrors( response );
      });
    }

  }])