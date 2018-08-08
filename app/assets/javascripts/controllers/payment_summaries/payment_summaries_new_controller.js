app.controller('PaymentSummariesNewController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$stateParams', '$timeout', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', function( $filter, $ngConfirm, $rootScope, $scope, $state, $stateParams, $timeout, AlertService, Auth, BackEndService, DatetimeService, FSCModalService ){

  //// PRIVATE
  var createPaymentSummary = function(){
    BackEndService.createPaymentSummary( $scope.newPaymentSummary )
      .then(function( response ){

      }, function( errors ){

      });
  };

  var setClientId = function(){
    $scope.newPaymentSummary.client_id = $scope.selectedClient.id;
  };

  //// PUBLIC ////
  $scope.clients;
  $scope.creatingSummary;

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

  $scope.uploadFileThenCreatePaymentSummary = function( form ){
    if ( !form.$valid ) {
      $("#new-payment-summary-form").addClass("was-validated");
      return;
    };


    if ( !$scope.creatingSummary ){
      FSCModalService.showLoading();
      $scope.creatingSummary = true;
      setClientId();

      if ( $scope.file ){
        BackEndService.getPresignedUrl( { filename: $scope.file.name, type: $scope.file.type } )
          .then(function( response ){

            var publicUrl = response.public_url;
            var awsKey = response.aws_key;
            BackEndService.uploadFileToAWS( response.presigned_url, $scope.file, $scope.file.type )
              .then(function( response ){
                createPaymentSummary();
              }, function(errors){
                AlertService.processErrors( errors );
              });

          }, function( errors ){
            AlertService.processErrors( errors );
          });
      } else {
        createPaymentSummary();
      };
    };
  };

}]);