app.controller('PropertiesShowController', ['$filter', '$ngConfirm', '$scope', '$state', '$timeout', 'Auth', 'BackEndService', 'DatetimeService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, $timeout, Auth, BackEndService, DatetimeService, Restangular){

	// --------------------
	// Private
	// --------------------
  var getProperty = function(){
    Restangular.one("properties", $state.params.id)
      .get()
      .then(function( response ){
        $scope.property = response;
      }, function( errors ){
        console.log( errors );
      });
  };

  var getTenancyAgreements = function(){
    Restangular.one("properties", $state.params.id)
      .getList("tenancy_agreements")
      .then(function( response ){
        $scope.tenancyAgreements = response;
      }, function( errors ){
        console.log( errors );
      });
  };

  var getUsers = function(){
    BackEndService.getUsers()
      .then(function( response ){
        $scope.users = response;
      }, function( errors ){
        console.log( errors );
      });
  };

	// --------------------
	// Public
	// --------------------
  $scope.property;
  $scope.tenancyAgreements;
  $scope.users;
  $scope.newTenancyAgreement = {
    user_id: undefined,
    amount: 0,
    starting_date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    property_id: $state.params.id
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getProperty();
          getUsers();
          getTenancyAgreements();
          DatetimeService.initiateDatePicker("#date-picker");
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createTenancyAgreement = function(){
    console.log(123);
    Restangular.all("tenancy_agreements")
      .post( $scope.newTenancyAgreement )
      .then(function( response ){
        $scope.tenancyAgreements.unshift( response );
      }, function( errors ){
        console.log( errors );
      });
  };

}])