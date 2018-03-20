app.controller('CleaningController', ['$filter', '$rootScope', '$scope', '$timeout', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $rootScope, $scope, $timeout, Auth, DatetimeService, DisplayService, Restangular ){

  //// PRIVATE ////

  //// PUBLIC ////
  $scope.tenants;

  $scope.init = function(){
  	Restangular
  		.all('tenants')
  		.getList()
  		.then(function( tenants ){
  			$scope.tenants = tenants;
  		})
  };

}]);