app.controller('EntriesController', ['$filter', '$http', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'ElisyamService', 'FSCModalService', 'Restangular', function( $filter, $http, $scope, $state, AlertService, Auth, BackEndService, DatetimeService, ElisyamService, FSCModalService, Restangular ){

  // Private

  var getAims = function(){
    FSCModalService.showLoading();
    BackEndService.getAims()
      .then(function( response ){
        $scope.aims = response;
        $scope.selectedAim = response[0];
      }, function( errors ){
        AlertService.processErrors( errors );
      })
      .finally(function(){
        FSCModalService.loading = false;
      });
  };

  //// PUBLIC ////
  $scope.aims = [];
  $scope.selectedAim;

  $scope.newEntry = {
    aim_id: undefined,
    minutes: 0,
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy')
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          // DatetimeService.initiateDatePicker('#date-picker');
          getAims();
          $scope.getEntries();
        } else {
          $state.go( 'home' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createEntry = function( form ){
    if ( !form.$valid ) {
      $("#new-entry-form").addClass("was-validated");
      return;
    };

    FSCModalService.showLoading();
    $scope.newEntry.aim_id = $scope.selectedAim.id;
    BackEndService.create( 'entries', $scope.newEntry )
      .then(function( response ){
        $scope.entries.unshift( response );
      }, function( errors ){
        AlertService.processErrors( errors );
      })
      .finally(function(){
        FSCModalService.loading = false;
        $scope.newEntry.minutes = 0;
      });
  };

  $scope.getEntries = function(  ){
    FSCModalService.showLoading();
    BackEndService.get( "entries" )
      .then(function( response ){
        $scope.entries = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      })
      .finally(function(){
        FSCModalService.loading = false;
      });
  };

}]);