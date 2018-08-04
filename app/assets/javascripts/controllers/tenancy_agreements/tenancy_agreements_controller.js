app.controller('TenancyAgreementsController', ['$filter', '$ngConfirm', '$scope', '$state', 'Auth', 'BackEndService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, Auth, BackEndService, DisplayService, Restangular ){

  // PRIVATE

  // PUBLIC

  $scope.tenancyAgreements;

  $scope.init = function(){
    BackEndService.getTenancyAgreements()
      .then(function( response ){
        $scope.tenancyAgreements = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

}]);