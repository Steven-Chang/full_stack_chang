app.controller('GamblingClubController', ['$scope', function($scope){

  // PRIVATE
  var getDaysSinceDate = function( startingDate ){
  	var startingDate = new Date( startingDate );
  	return Math.ceil( ( new Date() - startingDate ) / ( 24 * 60 * 60 * 1000 ) )
  };

  // PUBLIC

  $scope.entry = {
  	amount: 0,
  	member_id: "1",
  	type: "win"
  };
  $scope.numberOfDaysInOperation;

  $scope.init = function(){
  	$scope.numberOfDaysInOperation = getDaysSinceDate( "14 December 2017" );
  };

}])