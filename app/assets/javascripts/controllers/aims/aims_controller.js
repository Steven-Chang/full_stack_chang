app.controller('AimsController', ['$filter', '$http', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'ElisyamService', 'FSCModalService', function( $filter, $http, $scope, $state, AlertService, Auth, BackEndService, ElisyamService, FSCModalService ){

  // Private

  //// PUBLIC ////

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

}]);