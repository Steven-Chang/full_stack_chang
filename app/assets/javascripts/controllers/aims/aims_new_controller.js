app.controller('AimsNewController', ['$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'FSCModalService', function( $scope, $state, AlertService, Auth, BackEndService, FSCModalService ){

  // Private

  //// PUBLIC ////
  $scope.newAim = {
    description: ""
  }

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){

        } else {
          $state.go("home");
        };
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  $scope.createAim = function( form ){
    if ( !form.$valid ) {
      $("#new-aim-form").addClass("was-validated");
      return;
    };

    FSCModalService.showLoading();
    BackEndService.create( "aims", $scope.newAim )
      .then(function( response ){
        FSCModalService.loading = false;
        $state.go("aims");
      }, function( errors ){
        FSCModalService.loading = false;
        AlertService.processErrors( errors );
      });
  };

}]);