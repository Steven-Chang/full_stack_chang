app.controller('AimsController', ['$filter', '$http', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'ElisyamService', 'FSCModalService', function( $filter, $http, $scope, $state, AlertService, Auth, BackEndService, ElisyamService, FSCModalService ){

  // Private

  $scope.labels = ["January", "February", "March", "April", "May", "June", "July"];
  $scope.data = [
    [65, 59, 80, 81, 56, 55, 40]
  ];
  $scope.onClick = function (points, evt) {
    console.log(points, evt);
  };
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