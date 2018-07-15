app.controller('TranxactionTypesController', ['$filter', '$ngConfirm', '$scope', '$state', 'Auth', 'BackEndService', 'DisplayService', 'Restangular', function( $filter, $ngConfirm, $scope, $state, Auth, BackEndService, DisplayService, Restangular ){

  // Private

  var getTranxactionTypes = function(){
    BackEndService.getTranxactionTypes()
      .then(function( response ){
        $scope.tranxactionTypes = response;
      }, function( errors ){
        console.log( errors );
      });
  };

  //// PUBLIC ////
  $scope.creatingTranxactionType = false;
  $scope.gettingTranxactions = false;
  $scope.selectedTranxactionType;
  $scope.tranxactions = [];
  $scope.tranxactionTypes = [];

  $scope.newTranxactionType = {
    description: ""
  };

  $scope.createTranxactionType = function(){
    if( !$scope.creatingTranxactionType ){
      $scope.creatingTranxactionType = true;
      BackEndService.createTranxactionType( $scope.newTranxactionType )
        .then(function( response ){
          $scope.tranxactionTypes.unshift( response );
          $scope.newTranxactionType.description = "";
        }, function( errors ){
          console.log( errors );
        })
        .finally(function(){
          $scope.creatingTranxactionType = false;
        });
    };
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getTranxactionTypes();
        } else {
          $state.go( 'login' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.getTranxactions = function( transactionTypeId ){
    if ( !$scope.gettingTranxactions ){
      $scope.gettingTranxactions = true;
      BackEndService.getTranxactions( { tranxaction_type_id: transactionTypeId } )
        .then(function( response ){
          $scope.tranxactions = response;
        }, function( errors ){
          console.log( errors );
        })
        .finally(function(){
          $scope.gettingTranxactions = false;
        });
      };
  };


}]);