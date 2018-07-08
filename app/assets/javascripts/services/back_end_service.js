app.service('BackEndService', ['Restangular',
  function( Restangular ) {

  'use strict';

  // -----------------------
  // Private
  // -----------------------

  // -----------------------
  // Public
  // -----------------------

  var BackEndService = {};

  BackEndService.getUsers = function(){
    return Restangular.all('users').getList()
  };

  return BackEndService;

}]);
