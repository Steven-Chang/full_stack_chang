app.controller('ClientsShowController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$stateParams', '$timeout', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', function( $filter, $ngConfirm, $rootScope, $scope, $state, $stateParams, $timeout, AlertService, Auth, BackEndService, DatetimeService ){

  //// PRIVATE

  //// PUBLIC ////
  $scope.client;
  $scope.tranxactions;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          $scope.getTranxactions();
          BackEndService.getClient( $stateParams.id )
            .then(function( response ){
              $scope.client = response;
            }, function( errors ){
              AlertService.processErrors( errors );
            });
        } else {
          $state.go( 'home' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.getTranxactions = function(){
    var params = {
      resource_type: "Client",
      resource_id: $stateParams.id
    };

    BackEndService.getTranxactions( params )
      .then(function( response ){
        $scope.tranxactions = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

}]);