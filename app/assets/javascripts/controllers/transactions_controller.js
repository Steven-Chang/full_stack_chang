app.controller('TransactionsController', ['$filter', '$ngConfirm', '$scope', '$state', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, Auth, DatetimeService, DisplayService, Restangular ){

  // Private

  var getTransactions = function(){
    Restangular.all("transactions")
      .getList()
      .then(function( response ){
        $scope.transactions = response;
      }, function( errors ){
        console.log( errors );
      });
  };

  var getTransactionTypes = function(){
    Restangular.all("transaction_types")
      .getList()
      .then(function( response ){
        $scope.transactionTypes = response;
        $scope.selectedTransactionType = response[0];
      }, function( errors ){
        console.log( errors );
      });
  };

  //// PUBLIC ////
  $scope.aim = 1500000;
  $scope.creatingTransaction = false;
  $scope.deletingTransaction = false;
  $scope.TransactionPlusMinus = 0;
  $scope.gamblingPlusMinus = 0;
  $scope.transactions;
  $scope.currentPerDayAim = 0;
  $scope.currentPlusMinus = 0;
  $scope.currentDailyPlusMinus = 0;
  $scope.selectedTransactionType;
  $scope.transactions = [];
  $scope.transactionTypes = [];

  $scope.newTransaction = {
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: "",
    amount: 0,
    odds: undefined,
    transaction_type_id: undefined
  };

  $scope.newTransactionType = {
    description: ""
  };

  $scope.createNewTransaction = function(){
    if ( !$scope.creatingTransaction ){
      $scope.creatingTransaction = true;
      Restangular.all("transactions")
        .post( $scope.newTransactions )
        .then(function( response ){
          $scope.transactions.unshfit( response );
          $scope.newTransaction.amount = 0;
          $scope.newTransaction.description = undefined;
          $scope.creatingTransaction = false;
        }, function( errors ){
          console.log( errors );
        })
    };
  };

  $scope.createTransactionType = function(){
    Restangular.all( "transaction_types" )
      .post( $scope.newTransactionType )
      .then(function( response ){
        $scope.transactionTypes.push( response );
        $scope.newTransactionType.description = "";
      }, function( errors ){
        console.log( errors );
      });
  };

  $scope.deleteTransaction = function( $index ){
    if ( !$scope.deletingTransactionTransaction ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingTransactionTransaction = true;
              $scope.TransactionTransactions[$index].remove()
                .then(function(){
                  $scope.TransactionTransactions.splice( $index, 1  );
                  calculatePlusMinus();
                  calculateCurrentPerDayAim();
                  $scope.deletingTransactionTransaction = false;
                });
            }
          },
          close: function(scope, button){
            text: 'Cancel'
          }
        }
      });
    };
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          DatetimeService.initiateDatePicker('#date-picker');
          getTransactions();
          getTransactionTypes();
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.slideToggleContainer = function( element ){
    DisplayService.slideToggleContainer( element, "fast" );
  };

  /*

  var calculateAim = function(){
    $scope.aim -= $scope.currentPlusMinus;
  };

  var numberOfDaysUntilNewYear = function(){
    var today = new Date();
    var newYearsDay = new Date("01/01/2026");
    var timeDiff = Math.abs( newYearsDay.getTime() - today.getTime() );
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
    return diffDays
  };

  var numberOfDaysSinceTheStart = function(){
    var today = new Date();
    var startingDay = new Date("05/23/2018");
    var timeDiff = Math.abs( today.getTime() - startingDay.getTime() );
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
    return diffDays
  };

  var calculateCurrentPerDayAim = function(){
    if ( $scope.currentPlusMinus >= $scope.aim ){
      $scope.currentPerDayAim = 0;
    } else {
      $scope.currentPerDayAim = ( $scope.aim - $scope.currentPlusMinus ) / numberOfDaysUntilNewYear()
    };
  };

  var calculatePlusMinus = function(){
    $scope.currentPlusMinus = 0;
    $scope.TransactionPlusMinus = 0;
    $scope.gamblingPlusMinus = 0;
    for( var i = 0; i < $scope.TransactionTransactions.length; i++ ) {
      $scope.currentPlusMinus += parseInt($scope.TransactionTransactions[i].amount);
      if ( $scope.TransactionTransactions[i].Transaction ){
        $scope.TransactionPlusMinus += parseInt($scope.TransactionTransactions[i].amount);
      } else {
        $scope.gamblingPlusMinus += parseInt($scope.TransactionTransactions[i].amount);
      };
    };
  };

  var calculateDailyPlusMinus = function(){
    $scope.currentDailyPlusMinus = $scope.currentPlusMinus / numberOfDaysSinceTheStart();
  };




  $scope.aim = 1500000;
  $scope.creatingTransactionTransaction = false;
  $scope.deletingTransactionTransaction = false;
  $scope.TransactionPlusMinus = 0;
  $scope.gamblingPlusMinus = 0;
  $scope.TransactionTransactions;
  $scope.currentPerDayAim = 0;
  $scope.currentPlusMinus = 0;
  $scope.currentDailyPlusMinus = 0;
  $scope.newTransactionTransaction = {
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: "",
    amount: 0,
    odds: "",
    Transaction: true
  };

  $scope.deleteTransaction = function( $index ){
    if ( !$scope.deletingTransactionTransaction ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingTransactionTransaction = true;
              $scope.TransactionTransactions[$index].remove()
                .then(function(){
                  $scope.TransactionTransactions.splice( $index, 1  );
                  calculatePlusMinus();
                  calculateCurrentPerDayAim();
                  $scope.deletingTransactionTransaction = false;
                });
            }
          },
          close: function(scope, button){
            text: 'Cancel'
          }
        }
      });
    };
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          Restangular.all('Transaction_transactions')
            .getList()
            .then(function( response ){
              $scope.TransactionTransactions = response;
              calculatePlusMinus();
              calculateAim();
              calculateCurrentPerDayAim();
              DatetimeService.initiateDatePicker('#date-picker');
              calculateDailyPlusMinus();
            }, function( error ){
              console.log( "Couldn't get them transactions from the back end" );
            });
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createTransactionTransaction = function(){
    if ( !$scope.creatingTransactionTransaction ){
      $scope.creatingRentTransaction = true;
      Restangular.all('Transaction_transactions')
        .post( $scope.newTransactionTransaction )
        .then(function( response ){
          $scope.TransactionTransactions.unshift( response );
          calculatePlusMinus();
          calculateCurrentPerDayAim();
          $scope.newTransactionTransaction.amount = 0;
          $scope.newTransactionTransaction.description = undefined;
          $scope.newTransactionTransaction.odds = undefined;
          $scope.creatingTransactionTransaction = false;
        });
    };
  };

  $scope.slideToggleContainer = function( element ){
    DisplayService.slideToggleContainer( element, "fast" );
  };
  */

}]);