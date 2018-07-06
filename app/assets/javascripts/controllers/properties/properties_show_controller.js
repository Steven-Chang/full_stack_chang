app.controller('PropertiesShowController', ['$filter', '$ngConfirm', '$scope', '$state', '$timeout', 'Auth', 'DatetimeService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, $timeout, Auth, DatetimeService, Restangular){

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

	// --------------------
	// Public
	// --------------------
  $scope.property;
  $scope.tenancyAgreements;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getProperty();
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

}])