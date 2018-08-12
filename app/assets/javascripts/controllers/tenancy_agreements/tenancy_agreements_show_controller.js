app.controller('TenancyAgreementsShowController', ['$filter', '$ngConfirm', '$scope', '$state', '$stateParams', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', function( $filter, $ngConfirm, $scope, $state, $stateParams, AlertService, Auth, BackEndService, DatetimeService, FSCModalService ){

  // PRIVATE

  // PUBLIC
  $scope.tenancyAgreement;
  $scope.tranxactions;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          $scope.getTranxactions();

          var params = {
            resource_type: "TenancyAgreement",
            resource_id: $stateParams.id
          };

          BackEndService.getBalance( params )
            .then(function( response ){
              $scope.balance = response.balance
            }, function( errors ){
              AlertService.processErrors( errors );
            });
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

  $scope.getTranxactions = function(){
    var params = {
      resource_type: "TenancyAgreement",
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