app.controller('TransactionsController', ['$scope', '$state', '$timeout', 'Auth', 'Restangular', function($scope, $state, $timeout, Auth, Restangular){

  'usestrict;'

  // --------------------
  // Private
  // --------------------

  // --------------------
  // Public
  // --------------------

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){

      }, function( errors ){
        $state.go("login");
      });
  };

}])