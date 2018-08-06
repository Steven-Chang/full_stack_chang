app.controller('ClientsShowController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$stateParams', '$timeout', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', function( $filter, $ngConfirm, $rootScope, $scope, $state, $stateParams, $timeout, AlertService, Auth, BackEndService, DatetimeService ){

  //// PRIVATE

  //// PUBLIC ////
  $scope.client

  $scope.newJob = {
    client_id: undefined,
    cost: 0,
    user_id: undefined,
    start_time: undefined,
    end_time: undefined,
    taxable: true
  };

  $scope.newPayment = {
    client_id: undefined,
    amount: 0,
    date: undefined
  };

  $scope.payments;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          BackEndService.getClient( $stateParams.id )
            .then(function( response ){
              $scope.client = response;
            }, function( errors ){
              AlertService.processErrors( errors );
            });
        } else {
          $state.go( 'home' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createClient = function(){
    if ( !$scope.creatingClient ){
      $scope.creatingClient = true;
      Restangular.all('clients')
        .post( $scope.newClient )
        .then(function( response ){
          $scope.clients.unshift( response );
          $scope.newClient.email = "";
          $scope.newClient.name = "";
          $scope.creatingClient = false;
        });
    };
  };

  $scope.createJob = function(){
    if ( !$scope.creatingJob ){
      $scope.creatingJob = true;
      Restangular.all('jobs')
        .post( $scope.newJob )
        .then(function( response ){
          $scope.jobs.unshift( response );
          $scope.newJob.start_time = undefined;
          $scope.newJob.end_time = undefined;
          $scope.newJob.cost = 0;
          $scope.newJob.description = "";
          $scope.creatingJob = false;
          setClients();
        });
    };
  };

  $scope.createPayment = function(){
    if ( !$scope.creatingPayment ){
      $scope.creatingPayment = true;
      Restangular.all('client_payments')
        .post( $scope.newPayment )
        .then(function( response ){
          $scope.payments.unshift( response );
          $scope.newPayment.amount = 0;
          $scope.creatingPayment = false;
          setClients();
        });
    };
  };

  $scope.deleteClient = function( $index ){
    if ( !$scope.deletingClient ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingClient = true;
              $scope.clients[$index].remove()
                .then(function(){
                  $scope.clients.splice( $index, 1  );
                  $scope.deletingClient = false;
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

  $scope.deleteJob = function( $index ){
    if ( !$scope.deletingClient ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingJob = true;
              $scope.jobs[$index].remove()
                .then(function(){
                  $scope.jobs.splice( $index, 1  );
                  $scope.deletingJob = false;
                  setClients();
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

  $scope.deletePayment = function( $index ){
    if ( !$scope.deletingPayment ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingPayment = true;
              $scope.payments[$index].remove()
                .then(function(){
                  $scope.payments.splice( $index, 1  );
                  $scope.deletingPayment = false;
                  setClients();
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


}]);