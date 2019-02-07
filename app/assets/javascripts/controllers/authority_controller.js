app.controller('AuthController', ['$scope', '$rootScope', 'Auth', '$state', 'AlertService', 'FSCModalService', function($scope, $rootScope, Auth, $state, AlertService, FSCModalService){
    var config = {headers: {'X-HTTP-Method-Override': 'POST'}}

    $scope.formSubmitted = false;

    $scope.user = {
      email: "",
      password: "",
      remember_me: true
    }

    $scope.register = function(){
      Auth.register($scope.user, config)
        .then(function(user){
          $rootScope.user = user;
          if($rootScope.previousState && $rootScope.previousState.length){
            $state.go($rootScope.previousState);
          } else {
            $state.go('home');
          };
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
        if($rootScope.previousState && $rootScope.previousState.length){
          $state.go($rootScope.previousState);
        } else {
          $state.go('home');
        };
      }, function(response){
        FSCModalService.loading = false;
        AlertService.processErrors( response );
      });
    }

  }])