app.controller('ClientsShowController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$stateParams', '$timeout', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', function( $filter, $ngConfirm, $rootScope, $scope, $state, $stateParams, $timeout, AlertService, Auth, BackEndService, DatetimeService ){

  //// PRIVATE
  var getPaymentSummaries = function(){
    var params = {
      client_id: $stateParams.id
    };

    BackEndService.getPaymentSummaries( params )
      .then(function(response){
        $scope.paymentSummaries = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  var getTranxactionsBalance = function(){
    var params = {
      resource_type: "Client",
      resource_id: $stateParams.id
    };

    BackEndService.getBalance( params )
      .then(function( response ){
        $scope.tranxactionsBalance = response.balance;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  var getJobsBalance = function(){
    var params = {
      client_id: $stateParams.id
    }

    BackEndService.getJobsBalance( params )
      .then(function( response ){
        $scope.jobsBalance = response.balance;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  //// PUBLIC ////
  $scope.client;
  $scope.jobsBalance;
  $scope.paymentSummaries;
  $scope.tranxactions;
  $scope.tranxactionsBalance;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          $scope.getTranxactions();
          getPaymentSummaries();
          BackEndService.getClient( $stateParams.id )
            .then(function( response ){
              $scope.client = response;
              getTranxactionsBalance();
              getJobsBalance();
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