app.controller('TranxactionsController', ['$filter', '$ngConfirm', '$scope', '$state', 'Auth', 'BackEndService', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, Auth, BackEndService, DatetimeService, DisplayService, Restangular ){

  // Private

  var getClients = function(){
    BackEndService.getClients()
      .then(function( response ){
        $scope.clients = response;
        $scope.selectedClient = response[0];
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

  var setAmount = function(){
    if ( $scope.revenueOrExpense === 'revenue' ){
      if ( $scope.newTranxaction.amaount < 0 ) {
        $scope.newTranxaction.amount = $scope.newTranxaction.amount * -1;
      };
    } else {
      if ( $scope.newTranxaction.amount > 0 ) {
        $scope.newTranxaction.amount = $scope.newTranxaction.amount * -1;
      };
    };
  };

  var setTranxactables = function(){
    $scope.newTranxaction.tranxactables = [];
    $scope.newTranxaction.tranxactables.push({ resource_type: "TranxactionType", resource_id: $scope.selectedTranxactionType.id });
    if ( $scope.selectedTranxactionType.description === 'property' ){
      $scope.newTranxaction.tranxactables.push( { resource_type: "Property", resource_id: $scope.selectedProperty.id } );
    } else if ( $scope.selectedTranxactionType.descriptin === 'rent' ) {
      $scope.newTranxaction.tranxactables.push( { resource_type: "Property", resource_id: $scope.selectedProperty.id } );
      $scope.newTranxaction.tranxactables.push( { resource_type: "TenancyAgreement", resource_id: $scope.selectedTenancyAgreement.user_id } );
      $scope.newTranxaction.tranxactables.push( { resource_type: "User", resource_id: $scope.selectedTenancyAgreement.id } );
    } else if ( $scope.selectedTranxactionType.description === 'work' ){
      $scope.newTranxaction.tranxactables.push( { resource_type: "Client", resource_id: $scope.selectedClient.id } );
    };
  };

  //// PUBLIC ////
  $scope.creatingTranxaction = false;
  $scope.creatingTranxactionType = false;
  $scope.deletingTranxaction = false;
  $scope.gettingTranxactions = false;
  $scope.tenancyAgreements;
  $scope.gamblingPlusMinus = 0;
  $scope.currentPerDayAim = 0;
  $scope.currentPlusMinus = 0;
  $scope.currentDailyPlusMinus = 0;
  $scope.properties = [];
  $scope.revenueOrExpense = 'revenue';
  $scope.selectedProperty;
  $scope.selectedTenancyAgreement;
  $scope.selectedTranxactionType;
  $scope.tranxactions = [];
  $scope.tranxactionTypes = [];

  $scope.newTranxaction = {
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: "",
    amount: 0,
    tax: false,
    tranxactables: []
  };

  $scope.newTranxactionType = {
    description: ""
  };

  $scope.searchParams = {
    tranxactionType: undefined,
    tranxaction_type_id: undefined
  };

  $scope.$watch("selectedProperty", function( newValue, oldValue ){
    if ( newValue && newValue.id ){
      getTenancyAgreements( newValue.id );
    };
  });

  $scope.$watch("searchParams", function( newValue, oldValue ){
    console.log("New Value", newValue);
    console.log("Old Value", oldValue);
  }, true);

  $scope.createTranxaction = function(){
    if ( !$scope.creatingTranxaction ){
      $scope.creatingTranxaction = true;
      setTranxactables();
      setAmount();
      BackEndService.createTranxaction( $scope.newTranxaction )
        .then(function( response ){
          $scope.tranxactions.unshift( response );
          $scope.newTranxaction.amount = 0;
          $scope.newTranxaction.description = undefined;
        }, function( errors ){
          console.log( errors );
        })
        .finally(function(){
          $scope.creatingTranxaction = false;
        });
    };
  };

  $scope.createTranxactionType = function(){
    if( !$scope.creatingTranxactionType ){
      $scope.creatingTranxactionType = true;
      BackEndService.createTranxactionType( $scope.newTranxactionType )
        .then(function( response ){
          $scope.tranxactionTypes.unshift( response );
          $scope.newTranxactionType.description = "";
        }, function( errors ){
          console.log( errors );
        })
        .finally(function(){
          $scope.creatingTranxactionType = false;
        });
    };
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

  $scope.getTranxactions = function(  ){
    if ( !$scope.gettingTranxactions ){
      $scope.gettingTranxactions = true;
      BackEndService.getTranxactions( $scope.searchParams )
        .then(function( response ){
          $scope.tranxactions = response;
        }, function( errors ){
          console.log( errors );
        })
        .finally(function(){
          $scope.gettingTranxactions = false;
        });
    };
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          DatetimeService.initiateDatePicker('#date-picker');
          getClients();
          $scope.getTranxactions();
          getTranxactionTypes();
          getProperties();
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

}]);