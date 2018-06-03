app.controller('ClientsController', ['$filter', '$rootScope', '$scope', '$timeout', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $rootScope, $scope, $timeout, Auth, DatetimeService, DisplayService, Restangular ){

  // Private

  //// PUBLIC ////

  $scope.init = function(){
    alert( "Everybody loves an underdog!!" );
  };


}]);