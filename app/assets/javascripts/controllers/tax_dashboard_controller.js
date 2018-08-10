app.controller('TaxDashboardController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'FSCModalService', function( $filter, $ngConfirm, $rootScope, $scope, $state, AlertService, Auth, BackEndService, FSCModalService ){

  //// PRIVATE
  var getPaymentSummaries = function(){
    FSCModalService.showLoading();
    var params = {
      year_ending: $scope.yearEnding
    };

    BackEndService.getPaymentSummaries( params )
      .then(function(response){
        $scope.paymentSummaries = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      })
      .finally(function(){
        FSCModalService.loading = false;
      });
  };

  //// PUBLIC ////
  $scope.client;
  $scope.paymentSummaries;
  $scope.tranxactions;
  $scope.yearEnding;
  $scope.yearEndings;

  $scope.$watch( "yearEnding", function(){
    getPaymentSummaries();
  });

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          BackEndService.getYearEndings()
            .then(function( response ){
              $scope.yearEndings = response;
              $scope.yearEnding = response[0];
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

}]);

