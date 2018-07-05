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
    odds: "",
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
        console.log( response );
        $scope.transactionTypes.push( response );
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

}]);