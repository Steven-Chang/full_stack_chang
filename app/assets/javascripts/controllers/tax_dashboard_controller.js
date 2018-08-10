app.controller('TaxDashboardController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', function( $filter, $ngConfirm, $rootScope, $scope, $state, AlertService, Auth, BackEndService, DatetimeService ){

  //// PRIVATE
  var getPaymentSummaries = function(){
    var params = {
      year_ending: 2018
    };

    BackEndService.getPaymentSummaries( params )
      .then(function(response){
        console.log( response );
        $scope.paymentSummaries = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  //// PUBLIC ////
  $scope.client;
  $scope.paymentSummaries;
  $scope.tranxactions;
  $scope.yearEndings;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          BackEndService.getYearEndings()
            .then(function( response ){
              $scope.yearEndings = response;
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

