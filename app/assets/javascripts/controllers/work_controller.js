app.controller('WorkController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', '$timeout', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $rootScope, $scope, $state, $timeout, Auth, DatetimeService, DisplayService, Restangular ){

  // Private

  //// PUBLIC ////
  $scope.clients;
  $scope.creatingClient = false;
  $scope.deletingClient = false;
  $scope.newClient = {
    email: "",
    name: ""
  };

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

  $scope.createClient = function(){
    if ( !$scope.creatingClient ){
      $scope.creatingClient = true;
      Restangular.all('clients')
        .post( $scope.newClient )
        .then(function( response ){
          $scope.clients.unshift( response );
          $scope.newClient.email = "";
          $scope.newClient.name = "";
          $scope.creatingClient = false;
        });
    };
  };

  $scope.deleteClient = function( $index ){
    if ( !$scope.deletingClient ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingClient = true;
              $scope.clients[$index].remove()
                .then(function(){
                  $scope.clients.splice( $index, 1  );
                  $scope.deletingClient = false;
                });
            }
          },
          close: function(scope, button){
            text: 'Cancel'
          }
        }
      });
    };
  };


}]);