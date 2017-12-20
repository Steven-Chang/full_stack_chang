app.controller('GamblingClubController', ['$filter', '$scope', '$timeout', 'Restangular', 'users', function($filter, $scope, $timeout, Restangular, users){

  // PRIVATE
  var getDaysSinceDate = function( startingDate ){
  	var startingDate = new Date( startingDate );
  	return Math.ceil( ( new Date() - startingDate ) / ( 24 * 60 * 60 * 1000 ) )
  };

  var setLastUpdatedDate = function(){
    if ( $scope.entries.length ){
      $scope.lastUpdatedDate = $scope.entries[0].updated_at
    } else {
      $scope.lastUpdatedDate = new Date();
    };
  };

  // PUBLIC
  $timeout(function(){
    $('#date-picker').datepicker({
      format: "dd/mm/yyyy"
    });
  }, 100);

  $scope.entries;
  $scope.entry = {
  	amount: 0,
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
  	user_id: users[0].id,
  	type: "win"
  };
  $scope.lastUpdatedDate;
  $scope.numberOfDaysInOperation;
  $scope.users = users;

  $scope.createEntry = function(){
  };

  $scope.getEntries = function(){
    Restangular.all('gambling_club_entries').getList()
      .then(function( entries ){
        $scope.entries = entries;
        console.log( $scope.entries );
      });
  };

  $scope.init = function(){
  	$scope.numberOfDaysInOperation = getDaysSinceDate( "14 December 2017" );
    $scope.getEntries();
    // setLastUpdatedDate();
  };

}])