app.controller('TenancyAgreementsEditController', ['$filter', '$ngConfirm', '$scope', '$state', '$stateParams', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', function( $filter, $ngConfirm, $scope, $state, $stateParams, AlertService, Auth, BackEndService, DatetimeService, FSCModalService ){

  // PRIVATE

  // PUBLIC
  $scope.tenancyAgreement;
  $scope.updatingAgreement = false;

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

    if ( !$scope.updatingAgreement ){
      $scope.updatingAgreement = true;
      FSCModalService.showLoading();
      $scope.tenancyAgreement.put()
        .then(function( response ){
          FSCModalService.loading = false;
          $state.go("tenancyagreements");
        }, function( errors ){
          FSCModalService.loading = false;
          AlertService.processErrors( errors );
        });
    };
  };

}]);