app.controller('TranxactionsController', ['$filter', '$ngConfirm', '$scope', '$state', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, Auth, DatetimeService, DisplayService, Restangular ){

  // Private

  var getClients = function(){
    Restangular.all("clients")
      .getList()
      .then(function( response ){
        $scope.clients = response;
      }, function( errors ){
        console.log( errors );
      });
  };

  var getProperties = function(){
    Restangular.all("properties")
      .getList()
      .then(function( response ){
        $scope.properties = response;
        $scope.selectedProperty = response[0];
      }, function( errors ){
        console.log( errors );
      });
  };

  var getTenancyAgreements = function( propertyId ){
    Restangular.one("properties", propertyId)
      .getList( "tenancy_agreements" )
      .then(function( response ){
        $scope.tenancyAgreements = response;
        $scope.selectedTenancyAgreement = response[0];
      }, function( errors ){
        console.log( errors );
      });
  };

  var getTranxactions = function(){
    Restangular.all("tranxactions")
      .getList()
      .then(function( response ){
        $scope.tranxactions = response;
      }, function( errors ){
        console.log( errors );
      });
  };

  var getTranxactionTypes = function(){
    Restangular.all("tranxaction_types")
      .getList()
      .then(function( response ){
        $scope.tranxactionTypes = response;
        $scope.selectedTranxactionType = response[0];
      }, function( errors ){
        console.log( errors );
      });
  };

  //// PUBLIC ////
  $scope.creatingTranxaction = false;
  $scope.deletingTranxaction = false;
  $scope.tenancyAgreements;
  $scope.gamblingPlusMinus = 0;
  $scope.currentPerDayAim = 0;
  $scope.currentPlusMinus = 0;
  $scope.currentDailyPlusMinus = 0;
  $scope.properties = [];
  $scope.selectedProperty;
  $scope.selectedTenancyAgreement;
  $scope.selectedTranxactionType;
  $scope.tranxactions = [];
  $scope.tranxactionTypes = [];

  $scope.newTranxaction = {
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: "",
    amount: 0,
    odds: undefined,
    tax: false
  };

  $scope.newTranxactionType = {
    description: ""
  };

  $scope.$watch("selectedProperty", function( newValue, oldValue ){
    if ( newValue && newValue.id ){
      getTenancyAgreements( newValue.id );
    };
  });

  $scope.createNewTranxaction = function(){
    if ( !$scope.creatingTranxaction ){
      $scope.creatingTranxaction = true;
      Restangular.all("tranxactions")
        .post( $scope.newTranxactions )
        .then(function( response ){
          $scope.tranxactions.unshfit( response );
          $scope.newTranxaction.amount = 0;
          $scope.newTranxaction.description = undefined;
          $scope.creatingTranxaction = false;
        }, function( errors ){
          console.log( errors );
        })
    };
  };

  $scope.createTranxactionType = function(){
    Restangular.all( "tranxaction_types" )
      .post( $scope.newTranxactionType )
      .then(function( response ){
        $scope.tranxactionTypes.push( response );
        $scope.newTranxactionType.description = "";
      }, function( errors ){
        console.log( errors );
      });
  };

  $scope.deleteTranxaction = function( $index ){
    if ( !$scope.deletingTranxactionTranxaction ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingTranxactionTranxaction = true;
              $scope.TranxactionTranxactions[$index].remove()
                .then(function(){
                  $scope.TranxactionTranxactions.splice( $index, 1  );
                  calculatePlusMinus();
                  calculateCurrentPerDayAim();
                  $scope.deletingTranxactionTranxaction = false;
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
          getTranxactions();
          getTranxactionTypes();
          getProperties();
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
    $scope.TranxactionPlusMinus = 0;
    $scope.gamblingPlusMinus = 0;
    for( var i = 0; i < $scope.TranxactionTranxactions.length; i++ ) {
      $scope.currentPlusMinus += parseInt($scope.TranxactionTranxactions[i].amount);
      if ( $scope.TranxactionTranxactions[i].Tranxaction ){
        $scope.TranxactionPlusMinus += parseInt($scope.TranxactionTranxactions[i].amount);
      } else {
        $scope.gamblingPlusMinus += parseInt($scope.TranxactionTranxactions[i].amount);
      };
    };
  };

  var calculateDailyPlusMinus = function(){
    $scope.currentDailyPlusMinus = $scope.currentPlusMinus / numberOfDaysSinceTheStart();
  };




  $scope.aim = 1500000;
  $scope.creatingTranxactionTranxaction = false;
  $scope.deletingTranxactionTranxaction = false;
  $scope.TranxactionPlusMinus = 0;
  $scope.gamblingPlusMinus = 0;
  $scope.TranxactionTranxactions;
  $scope.currentPerDayAim = 0;
  $scope.currentPlusMinus = 0;
  $scope.currentDailyPlusMinus = 0;
  $scope.newTranxactionTranxaction = {
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: "",
    amount: 0,
    odds: "",
    Tranxaction: true
  };

  $scope.deleteTranxaction = function( $index ){
    if ( !$scope.deletingTranxactionTranxaction ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingTranxactionTranxaction = true;
              $scope.TranxactionTranxactions[$index].remove()
                .then(function(){
                  $scope.TranxactionTranxactions.splice( $index, 1  );
                  calculatePlusMinus();
                  calculateCurrentPerDayAim();
                  $scope.deletingTranxactionTranxaction = false;
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
          Restangular.all('Tranxaction_tranxactions')
            .getList()
            .then(function( response ){
              $scope.TranxactionTranxactions = response;
              calculatePlusMinus();
              calculateAim();
              calculateCurrentPerDayAim();
              DatetimeService.initiateDatePicker('#date-picker');
              calculateDailyPlusMinus();
            }, function( error ){
              console.log( "Couldn't get them tranxactions from the back end" );
            });
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createTranxactionTranxaction = function(){
    if ( !$scope.creatingTranxactionTranxaction ){
      $scope.creatingRentTranxaction = true;
      Restangular.all('Tranxaction_tranxactions')
        .post( $scope.newTranxactionTranxaction )
        .then(function( response ){
          $scope.TranxactionTranxactions.unshift( response );
          calculatePlusMinus();
          calculateCurrentPerDayAim();
          $scope.newTranxactionTranxaction.amount = 0;
          $scope.newTranxactionTranxaction.description = undefined;
          $scope.newTranxactionTranxaction.odds = undefined;
          $scope.creatingTranxactionTranxaction = false;
        });
    };
  };

  $scope.slideToggleContainer = function( element ){
    DisplayService.slideToggleContainer( element, "fast" );
  };
  */

}]);