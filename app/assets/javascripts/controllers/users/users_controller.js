app.controller('UsersController', ['$filter', '$ngConfirm', '$scope', '$state', '$timeout', 'Auth', 'BackEndService', 'DatetimeService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, $timeout, Auth, BackEndService, DatetimeService, Restangular){

	// --------------------
	// Private
	// --------------------
  var getUsers = function(){
    Restangular.all("users")
      .getList()
      .then(function( response ){
        $scope.users = response;
      }, function( errors ){
        console.log( errors );
      });
  };

	// --------------------
	// Public
	// --------------------
  $scope.users;

  $scope.newUser = {
    username: "",
    first_name: "",
    last_name: "",
    email: "",
    password: "",
    password_confirmation: ""
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getUsers();
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createUser = function(){
    Auth.register( $scope.newUser )
      .then(function( user ){
        $scope.users.unshift( user );
      }, function( errors ){
        console.log( errors );
      });
  };

}])