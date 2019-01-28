app.controller('AimsController', ['$filter', '$http', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'ElisyamService', 'FSCModalService', function( $filter, $http, $scope, $state, AlertService, Auth, BackEndService, ElisyamService, FSCModalService ){

  // Private

  var getAims = function(){
    BackEndService.getAims()
      .then(function( response ){
        $scope.aims = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  //// PUBLIC ////
  $scope.aims;
  $scope.dates;
  $scope.entriesGroupedByDate;
  $scope.gettingEntries = false;

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
          $scope.getEntries();
        } else {
          $state.go("home");
        };
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  $scope.getEntries = function(){
    if(!$scope.gettingEntries){
      $scope.gettingEntries = true;
      BackEndService.getEntries()
        .then(function(response){
          $scope.entriesGroupedByDate = response.data;
          $scope.dates = Object.keys(response.data);
        }, function(errors){
          AlertService.processErrors(errors);
        })
        .finally(function(){
          $scope.gettingEntries = false;
        });
    };
  };

}]);