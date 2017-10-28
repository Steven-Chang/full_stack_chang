app.controller('TheSystem', ['$scope', 'Restangular', function($scope, Restangular){

  'use strict';

  // ---------------------
  // Private
  // ---------------------

  // ---------------------
  // Public
  // ---------------------

  $scope.results;

  $scope.init = function(){
    Restangular.allUrl('competitions', 'http://sandbox.whapi.com/v1/').getList().then(function(response){
      $scope.results = response;
    });

  };

}])