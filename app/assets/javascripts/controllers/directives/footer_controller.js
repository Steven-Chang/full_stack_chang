app.controller('FooterController', ['_', '$scope', '$state', 'Auth', 'ElisyamService', 'Restangular', function( _, $scope, $state, Auth, ElisyamService, Restangular ){

  // --------------------
  // Private
  // --------------------

  // --------------------
  // Public
  // --------------------

	$scope.init = function(){
		ElisyamService.goTop();
	};


}]);