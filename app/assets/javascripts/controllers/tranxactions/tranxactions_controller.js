app.controller('TranxactionsController', ['$filter', '$ngConfirm', '$scope', '$state', 'Auth', 'BackEndService', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, Auth, BackEndService, DatetimeService, DisplayService, Restangular ){

  // Private

  // This is to send to the back end
  var searchParamsToSendUp = {
    resource_type: undefined,
    resource_id: undefined
  };

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

  var setSearchParams = function(){
    $scope.searchParams.tranxaction_type_id = undefined;
    $scope.searchParams.property_id = undefined;
    $scope.searchParams.tenancy_agreement_id = undefined;
    $scope.searchParams.client_id = undefined;

    if ( $scope.searchParams.client ){
      searchParamsToSendUp.resource_type = "Client";
      searchParamsToSendUp.resource_id = $scope.searchParams.client.id;
      return
    };

    if ( $scope.searchParams.tenancyAgreement ){
      searchParamsToSendUp.resource_type = "TenancyAgreement";
      searchParamsToSendUp.resource_id = $scope.searchParams.tenancyAgreement.id;
      return
    };

    if ( $scope.searchParams.property && $scope.searchParams.tranxactionType.description === "property" ){
      searchParamsToSendUp.resource_type = "Property";
      searchParamsToSendUp.resource_id = $scope.searchParams.property.id;
      return
    };

    if ( $scope.searchParams.tranxactionType ){
      searchParamsToSendUp.resource_type = "TranxactionType";
      searchParamsToSendUp.resource_id = $scope.searchParams.tranxactionType.id;
    } else {
      searchParamsToSendUp.resource_type = undefined;
      searchParamsToSendUp.resource_id = undefined;
    };
  };

  var setTranxactables = function(){
    $scope.newTranxaction.tranxactables = [];
    $scope.newTranxaction.tranxactables.push({ resource_type: "TranxactionType", resource_id: $scope.selectedTranxactionType.id });
    if ( $scope.selectedTranxactionType.description === 'property' ){
      $scope.newTranxaction.tranxactables.push( { resource_type: "Property", resource_id: $scope.selectedProperty.id } );
    } else if ( $scope.selectedTranxactionType.descriptin === 'rent' ) {
      $scope.newTranxaction.tranxactables.push( { resource_type: "Property", resource_id: $scope.selectedProperty.id } );
      $scope.newTranxaction.tranxactables.push( { resource_type: "TenancyAgreement", resource_id: $scope.selectedTenancyAgreement.id } );
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

  // This is for display and processing purposes
  $scope.searchParams = {
    tranxactionType: undefined,
    tranxaction_type_id: undefined,
    property: undefined,
    property_id: undefined,
    tenancyAgreement: undefined,
    tenancy_agreement_id: undefined,
    client: undefined,
    client_id: undefined,
  };

  $scope.$watch("selectedProperty", function( newValue, oldValue ){
    if ( newValue && newValue.id ){
      getTenancyAgreements( newValue.id );
    };
  });

  $scope.$watch("searchParams.tranxactionType", function( newValue, oldValue ){
    if ( !(newValue === oldValue) ){
      $scope.searchParams.tranxaction_type_id = undefined;
      $scope.searchParams.property = undefined;
      $scope.searchParams.property_id = undefined;
      $scope.searchParams.tenancyAgreement = undefined;
      $scope.searchParams.tenancy_agreement_id = undefined;
      $scope.searchParams.client = undefined;
      $scope.searchParams.client_id = undefined;
    };
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
      setSearchParams();
      BackEndService.getTranxactions( searchParamsToSendUp )
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