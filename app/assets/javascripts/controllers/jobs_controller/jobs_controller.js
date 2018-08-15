app.controller('JobsController', ['$filter', '$http', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'ElisyamService', 'FSCModalService', 'Restangular', function( $filter, $http, $scope, $state, AlertService, Auth, BackEndService, ElisyamService, FSCModalService, Restangular ){

  // Private
  var getClients = function(){
    BackEndService.getClients()
      .then(function( response ){
        $scope.clients = response;
        $scope.selectedClient = response[0];
      }, function( errors ){
        AlertService.processErrors( errors );
      });
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

    // This is last bit is to cover all the randon tranxaction types that might pop up in the future... 
    if ( $scope.searchParams.tranxactionType ){
      searchParamsToSendUp.resource_type = "TranxactionType";
      searchParamsToSendUp.resource_id = $scope.searchParams.tranxactionType.id;
    } else {
      searchParamsToSendUp.resource_type = undefined;
      searchParamsToSendUp.resource_id = undefined;
    };
  };

  //// PUBLIC ////
  $scope.creatingJob = false;
  $scope.deletingJob = false;
  $scope.gettingJobs = false;
  $scope.tenancyAgreements;
  $scope.jobs = [];

  $scope.newTranxaction = {
    amount: 0,
    attachments: [],
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    description: "",
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

  $scope.createJob = function( form ){
    if ( !form.$valid ) {
      $("#new-job-form").addClass("was-validated");
      return;
    };

    if ( !$scope.creatingJob ){
      FSCModalService.showLoading();
      $scope.creatingJob = true;
      BackEndService.createJob( $scope.newJob )
        .then(function( response ){
          $scope.jobs.unshift( response );
        }, function( errors ){
          AlertService.processErrors( errors );
        })
        .finally(function(){
          FSCModalService.loading = false;
          $scope.creatingJob = false;
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
          AlertService.processErrors( errors );
        })
        .finally(function(){
          $scope.creatingTranxactionType = false;
        });
    };
  };

  $scope.deleteTranxaction = function( $index ){
    if ( !$scope.deletingJob ){
      FSCModalService.confirmDelete()
        .then(function( modal ){
          modal.close
            .then(function( confirmed ){
              if ( confirmed ){
                FSCModalService.showLoading();
                $scope.deletingJob = true;
                $scope.tranxactions[$index].remove()
                  .then(function( response ){
                    $scope.tranxactions.splice( $index, 1  );
                    AlertService.success("Tranxaction deleted");
                  }, function( errors ){
                    AlertService.processErrors( errors );
                  })
                  .finally(function(){
                    $scope.deletingJob = false;
                    FSCModalService.loading = false;
                  });
              };
            });
        });
    };
  };

  $scope.getJobs = function(  ){
    if ( !$scope.gettingsJobs ){
      $scope.gettingJobs = true;
      setSearchParams();
      BackEndService.getJobs( searchParamsToSendUp )
        .then(function( response ){
          $scope.jobs = response;
        }, function( errors ){
          AlertService.processErrors( errors );
        })
        .finally(function(){
          $scope.gettingJobs = false;
        });
    };
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getClients();
          $scope.getJobs();
        } else {
          $state.go( 'home' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

}]);