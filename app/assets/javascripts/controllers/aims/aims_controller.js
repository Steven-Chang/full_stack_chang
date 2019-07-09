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
  $scope.addingDays = false;
  $scope.aims;
  $scope.dates = [];
  $scope.entriesGroupedByDate = {};
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

  $scope.addDay = function(){
    if(!$scope.addingDays){
      $scope.addingDays = true;
      params = {
        date: new Date(Date.parse($scope.dates[0])),
        number_of_days_back: 0
      }
      params.date.setDate(params.date.getDate() + 1);
    };

    BackEndService.getEntries(params)
      .then(function(response){
        Object.assign($scope.entriesGroupedByDate, response.data);
        $scope.dates = Object.keys(response.data).concat($scope.dates);
      }, function(errors){
        AlertService.processErrors(errors);
      })
      .finally(function(){
        $scope.addingDays = false;
      });
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if (user.admin){
          getAims();
          $scope.getEntries();
        } else {
          $state.go('home');
        };
      }, function(errors){
        AlertService.processErrors(errors);
        $state.go('home');
      });
  };

  $scope.getEntries = function(){
    if(!$scope.gettingEntries){
      var params = {
        number_of_days_back: 10
      };
      if($scope.dates.length){
        params.date = new Date(Date.parse($scope.dates[$scope.dates.length - 1]));
        params.date.setDate(params.date.getDate() - 1);
      };

      $scope.gettingEntries = true;
      BackEndService.getEntries(params)
        .then(function(response){
          Object.assign($scope.entriesGroupedByDate, response.data);
          $scope.dates = $scope.dates.concat(Object.keys(response.data));
        }, function(errors){
          AlertService.processErrors(errors);
        })
        .finally(function(){
          $scope.gettingEntries = false;
        });
    };
  };

  $scope.changeAchieveedStatusOfEntry = function(entry){
    var copiedEntry = BackEndService.restangularizeObject(entry, 'entries');
    copiedEntry.achieved = !copiedEntry.achieved;
    copiedEntry.put()
      .then(function(response){
        entry.achieved = response.achieved;
      }, function(errors){
        AlertService.processErrors(errors);
      });
  };

}]);