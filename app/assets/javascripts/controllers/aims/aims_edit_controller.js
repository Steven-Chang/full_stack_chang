app.controller('AimsEditController', ['$scope', '$state', '$stateParams', 'AlertService', 'Auth', 'BackEndService', 'FSCModalService', function( $scope, $state, $stateParams, AlertService, Auth, BackEndService, FSCModalService ){

  // Private

  //// PUBLIC ////
  $scope.aim;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          BackEndService.getOne( "aims", $stateParams.id )
            .then(function( response ){
              console.log( response );
              $scope.aim = response;
            }, function( errors ){
              AlertService.processErrors( errors );
            });
        } else {
          $state.go("home");
        };
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  $scope.updateAim = function( form ){
    if ( !form.$valid ) {
      $("#edit-aim-form").addClass("was-validated");
      return;
    };

    FSCModalService.showLoading();
    $scope.aim.put()
      .then(function( response ){
        FSCModalService.loading = false;
        $state.go("aims");
      }, function( errors ){
        FSCModalService.loading = false;
        AlertService.processErrors( errors );
      });
  };

}]);