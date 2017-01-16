app.controller('TetrisController', ['$scope', 'highScoresAndAssociations', function($scope, highScoresAndAssociations){

	// --------------------
	// Private
	// --------------------


	// --------------------
	// Public
	// --------------------
  $scope.test = highScoresAndAssociations;

}])