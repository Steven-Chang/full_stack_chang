app.controller('PaymentSummariesNewController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$stateParams', '$timeout', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', function( $filter, $ngConfirm, $rootScope, $scope, $state, $stateParams, $timeout, AlertService, Auth, BackEndService, DatetimeService ){

  //// PRIVATE

  //// PUBLIC ////
  $scope.clients;
  $scope.newPaymentSummary = {
    gross_payment: 0,
    total_tax_withheld: 0,
    year_ending: 2018,
    total_allowance: 0,
    client_id: undefined
  };
  $scope.selectedClient;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          BackEndService.getClients()
            .then(function( response ){
              $scope.clients = response;
              $scope.selectedClient = response[0];
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

  $scope.uploadFileThenCreatePaymentSummary = function(){
    var params = {
      resource_type: "Client",
      resource_id: $stateParams.id
    };

    BackEndService.getTranxactions( params )
      .then(function( response ){
        $scope.tranxactions = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

}]);