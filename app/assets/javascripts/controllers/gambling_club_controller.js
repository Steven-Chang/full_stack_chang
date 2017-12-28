app.controller('GamblingClubController', ['$filter', '$scope', '$timeout', 'Restangular', 'users', function($filter, $scope, $timeout, Restangular, users){

  // PRIVATE
  var getDaysSinceDate = function( startingDate ){
  	var startingDate = new Date( startingDate );
  	return Math.ceil( ( new Date() - startingDate ) / ( 24 * 60 * 60 * 1000 ) )
  };

  var getBalance = function(){
    Restangular.oneUrl('balance').get()
      .then(function(response){
        $scope.balance = response.balance;
      });
  };

  var resetEntry = function(){
    $scope.entry.amount = 0;
    $scope.entry.description = undefined;
    $scope.entry.guarantee = undefined;
    $scope.entry.odds = undefined;
    $scope.entry.wager = undefined;
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

  $scope.creatingEntry = false;
  $scope.balance;
  $scope.entries;
  $scope.entry = {
  	amount: 0,
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: undefined,
    gambling: undefined,
    guarantee: undefined,
  odds: undefined,
    type: "win",
  	user_id: users[0].id,
    wager: undefined
  };
  $scope.lastUpdatedDate;
  $scope.numberOfDaysInOperation;
  $scope.users = users;

  var setEntryParamsDependingOnEntryType = function(){
    if ( $scope.entry.type === "win" || $scope.entry.type === "loss" ){
      $scope.entry.gambling = true;
    } else {
      $scope.entry.gambling = false;
    };

    if ($scope.entry.type === "loss" ){
      $scope.entry.amount = $scope.entry.wager * -1;
    };

    if ( $scope.entry.type === "withdrawal" ){
      $scope.entry.amount *= -1;
      $scope.entry.description = "Withdrawal";
    };

    if ( $scope.entry.type === "deposit" ){
      $scope.entry.description = "Deposit";
    };
  };

  $scope.createEntry = function(){
    if( !$scope.creatingEntry ){
      $scope.creatingEntry = true;
      setEntryParamsDependingOnEntryType();
      $scope.entries.post( $scope.entry ).then(function( newPost ){
        $scope.entries.unshift( newPost );
        resetEntry();
      }, function(error){
        console.log( error );
      })
      .finally(function(){
        $scope.creatingEntry = false;
      });
    };
  };

  $scope.getEntries = function(){
    Restangular.all('gambling_club_entries').getList()
      .then(function( entries ){
        $scope.entries = entries;
        setLastUpdatedDate();
      });
  };

  $scope.init = function(){
  	$scope.numberOfDaysInOperation = getDaysSinceDate( "14 December 2017" );
    $scope.getEntries();
    getBalance();
  };

  $scope.returnUsernameById = function( userId ){
    for( var i = 0; i < $scope.users.length; i++ ){
      var user = $scope.users[i];
      if ( user.id === userId ){
        return user.username
      };
    };
  };

}])