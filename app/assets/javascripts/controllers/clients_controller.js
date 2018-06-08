app.controller('ClientsController', ['$filter', '$rootScope', '$scope', '$timeout', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $rootScope, $scope, $timeout, Auth, DatetimeService, DisplayService, Restangular ){

  // Private

  //// PUBLIC ////

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          Restangular.all('clients')
            .getList()
            .then(function( response ){
              $scope.clients = response;
            }, function( error ){
            	alert( "Couldn't get them clients from the back end my man!");
            });
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };


}]);