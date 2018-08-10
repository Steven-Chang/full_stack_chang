app.controller('ClientsShowController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$stateParams', '$timeout', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', function( $filter, $ngConfirm, $rootScope, $scope, $state, $stateParams, $timeout, AlertService, Auth, BackEndService, DatetimeService ){

  //// PRIVATE
  var getPaymentSummaries = function(){
    var params = {
      client_id: $stateParams.id
    };

    BackEndService.getPaymentSummaries( params )
      .then(function(response){
        console.log( response );
        $scope.paymentSummaries = response;
        console.log( response[0] );
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  //// PUBLIC ////
  $scope.client;
  $scope.paymentSummaries;
  $scope.tranxactions;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          $scope.getTranxactions();
          getPaymentSummaries();
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

  $scope.getTranxactions = function(){
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