app.controller('JobsController', ['$filter', '$http', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'ElisyamService', 'FSCModalService', function( $filter, $http, $scope, $state, AlertService, Auth, BackEndService, ElisyamService, FSCModalService ){

  // Private
  var searchParams = {
    client_id: undefined
  };

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
    if ( $scope.searchParams.client && $scope.searchParams.client.id ){
      searchParams.client_id = $scope.searchParams.client.id;
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
    client: undefined
  };

  $scope.createJob = function( form ){
    if ( !form.$valid ) {
      $("#new-job-form").addClass("was-validated");
      return;
    };

    if ( !$scope.creatingJob ){
      FSCModalService.showLoading();
      $scope.creatingJob = true;
      $scope.newJob.client_id = $scope.selectedClient.id;
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

  $scope.deleteJob = function( $index ){
    if ( !$scope.deletingJob ){
      FSCModalService.confirmDelete()
        .then(function( modal ){
          modal.close
            .then(function( confirmed ){
              if ( confirmed ){
                FSCModalService.showLoading();
                $scope.deletingJob = true;
                $scope.jobs[$index].remove()
                  .then(function( response ){
                    $scope.jobs.splice( $index, 1  );
                    AlertService.success("Job deleted");
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

  $scope.getJobs = function(){
    if ( !$scope.gettingsJobs ){
      $scope.gettingJobs = true;
      setSearchParams();
      BackEndService.getJobs( searchParams )
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