app.controller('PaymentSummariesEditController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$stateParams', '$timeout', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', function( $filter, $ngConfirm, $rootScope, $scope, $state, $stateParams, $timeout, AlertService, Auth, BackEndService, DatetimeService, FSCModalService ){

  //// PRIVATE
  var setClient = function(){
    for (var i = 0; i < $scope.clients.length; i++){
      if ( $scope.clients[i].id == parseInt( $scope.paymentSummary.client_id ) ){
        $scope.selectedClient = $scope.clients[i];
        break
      };
    };
  };

  var setClientId = function(){
    $scope.paymentSummary.client_id = $scope.selectedClient.id;
  };

  var updatePaymentSummary = function(){
    $scope.paymentSummary.put()
      .then(function( response ){
        FSCModalService.loading = false;
        $state.go( "clients" );
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  //// PUBLIC ////
  $scope.clients;
  $scope.file;
  $scope.paymentSummary
  $scope.selectedClient;
  $scope.updatingSummary;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          BackEndService.getClients()
            .then(function( response ){
              $scope.clients = response;
              BackEndService.getPaymentSummary( $stateParams.id )
                .then(function( response ){
                  console.log( response );
                  $scope.paymentSummary = response;
                  setClient();
                }, function( errors ){
                  AlertService.processErrors( errors );
                });
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

  $scope.uploadFileThenUpdatePaymentSummary = function( form ){
    if ( !form.$valid ) {
      $("#payment-summary-form").addClass("was-validated");
      return;
    };


    if ( !$scope.updatingSummary ){
      FSCModalService.showLoading();
      $scope.updatingSummary = true;
      setClientId();

      if ( $scope.file ){
        BackEndService.getPresignedUrl( { filename: $scope.file.name, type: $scope.file.type } )
          .then(function( response ){

            var publicUrl = response.public_url;
            var awsKey = response.aws_key;
            BackEndService.uploadFileToAWS( response.presigned_url, $scope.file, $scope.file.type )
              .then(function( response ){
                $scope.newPaymentSummary.attachments.push( { url: publicUrl, aws_key: awsKey } );
                updatePaymentSummary();
              }, function(errors){
                AlertService.processErrors( errors );
              });

          }, function( errors ){
            AlertService.processErrors( errors );
          });
      } else {
        updatePaymentSummary();
      };
    };
  };

}]);