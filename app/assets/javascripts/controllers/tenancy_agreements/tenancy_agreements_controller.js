app.controller('TenancyAgreementsController', ['$filter', '$ngConfirm', '$scope', '$state', 'Auth', 'BackEndService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, Auth, BackEndService, DisplayService, Restangular ){

  // PRIVATE
  var getTenancyAgreements = function(activeStatus){
    var active;

    if(activeStatus == "Active"){
      active = true;
    }else if(activeStatus == "Inactive"){
      active = false;
    };

    var params = {
      active: active
    };

    BackEndService.getTenancyAgreements(params)
      .then(function(response){
        $scope.tenancyAgreements = response;
      }, function(errors){
        AlertService.processErrors(errors);
      });
  };

  // PUBLIC
  $scope.activeStatus = "Active";
  $scope.activeStatuses =["Active", "Inactive", "All"];
  $scope.tenancyAgreements;

  $scope.$watch("activeStatus", function(){
    getTenancyAgreements($scope.activeStatus);
  });
}]);