app.controller('AimsController', ['$filter', '$http', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'ElisyamService', 'FSCModalService', function( $filter, $http, $scope, $state, AlertService, Auth, BackEndService, ElisyamService, FSCModalService ){

  // Private

  var getAims = function(){
    BackEndService.getAims()
      .then(function( response ){
        console.log(response);
        $scope.aims = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  //// PUBLIC ////

  $scope.aims;

  $scope.options = {
    scales: {
      yAxes: [
        {
          id: 'y-axis-1',
          type: 'linear',
          display: true,
          position: 'left'
        }
      ]
    }
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getAims();
        } else {
          $state.go("home");
        };
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

}]);