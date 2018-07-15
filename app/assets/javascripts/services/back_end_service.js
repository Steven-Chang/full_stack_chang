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

  BackEndService.createTranxaction = function( newTranxaction ){
    return Restangular.all('tranxactions').post( newTranxaction )
  };

  BackEndService.createTranxactionType = function( newTranxactionType ){
    return Restangular.all('tranxaction_types').post( newTranxactionType )
  };

  BackEndService.getClients = function(){
    return Restangular.all('clients').getList()
  };

  BackEndService.getUsers = function(){
    return Restangular.all('users').getList()
  };

  return BackEndService;

}]);
