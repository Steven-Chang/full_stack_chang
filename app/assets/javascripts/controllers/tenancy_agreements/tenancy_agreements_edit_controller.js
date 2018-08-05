app.controller('TenancyAgreementsEditController', ['$filter', '$ngConfirm', '$scope', '$state', '$stateParams', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, $stateParams, AlertService, Auth, BackEndService, DatetimeService, Restangular ){

  // PRIVATE

  // PUBLIC
  $scope.tenancyAgreement;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          BackEndService.getTenancyAgreement( $stateParams.id )
            .then(function( response ){
              $scope.tenancyAgreement = response;
              $scope.tenancyAgreement.starting_date = DatetimeService.formatDate( response.starting_date, "EEE d LLLL yyyy" );
                DatetimeService.initiateDatePicker('#date-picker');
            }, function( errors ){
              AlertService.processErrors( errors );
            });
          } else {
            $state.go("home");
          };
      }, function( errors ){
        $state.go("login");
      });
  };

  $scope.updateTenancyAgreement = function( form ){
    if ( !form.$valid ) {
      $("#edit-form").addClass("was-validated");
      return;
    };

    $scope.tenancyAgreement.put()
      .then(function( response ){
        $state.go("tenancyagreements");
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

}]);