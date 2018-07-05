app.controller('PropertiesController', ['$filter', '$ngConfirm', '$scope', '$state', '$timeout', 'Auth', 'DatetimeService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, $timeout, Auth, DatetimeService, Restangular){

	// --------------------
	// Private
	// --------------------
  var getProperties = function(){
    Restangular.all("properties")
      .getList()
      .then(function( response ){
        $scope.properties = response;
        console.log( response );
      }, function( errors ){
        console.log( errors );
      });
  };



	// --------------------
	// Public
	// --------------------
  $scope.creatingProperty = false;
  $scope.deletingProperty = false;
  $scope.properties;

  $scope.newProperty = {
    address: ""
  };

  $scope.deleteProperty = function( $index ){
    if ( !$scope.deletingProperty ){
      $ngConfirm({
        title: 'Confirm Delete',
        content: '',
        scope: $scope,
        buttons: {
          delete: {
            text: 'Delete',
            btnClass: 'btn-primary',
            action: function(scope){
              $scope.deletingProperty = true;
              $scope.properties[$index]
                .remove()
                .then(function( response ){
                  $scope.properties[$index].splice( $index, 1 );
                }, function( errors ){
                  console.log( errors );
                })
            }
          },
          close: function(scope, button){
            text: 'Cancel'
          }
        }
      });
    };
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getProperties();
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createProperty = function(){
    if ( !$scope.creatingProperty ){
      $scope.creatingProperty = true;
      Restangular.all("properties")
        .post( $scope.newProperty )
        .then(function( response ){
          $scope.properties.unshift( response );
          $scope.newProperty.address = "";
        }, function( errors ){
          console.log( errors );
        })
        .finally(function(){
          $scope.creatingProperty = false;
        });
    }
  };


}])