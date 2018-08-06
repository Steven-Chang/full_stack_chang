app.service('BackEndService', ['$http', 'Restangular',
  function( $http, Restangular ) {

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

  BackEndService.getBalance = function( route, resourceId ){
    return Restangular.one( route, resourceId ).customGET("balance")
  };

  BackEndService.getClient = function( id ){
    return Restangular.one( 'clients', id ).get()
  };

  BackEndService.getClients = function(){
    return Restangular.all('clients').getList()
  };

  BackEndService.getPresignedUrl = function( params ){
    return Restangular.all('attachments').customGET("presigned", params)
  };

  BackEndService.getProject = function( id ){
    return Restangular.one( "projects", id ).get()
  };

  BackEndService.getTenancyAgreement = function( id ){
    return Restangular.one( 'tenancy_agreements', id ).get()
  };

  BackEndService.getTenancyAgreements = function(){
    return Restangular.all('tenancy_agreements').getList()
  };

  BackEndService.getTranxactions = function( params ){
    return Restangular.all('tranxactions').getList( params )
  };

  BackEndService.getTranxactionTypes = function(){
    return Restangular.all('tranxaction_types').getList()
  };

  BackEndService.getUsers = function(){
    return Restangular.all('users').getList()
  };

  BackEndService.uploadFileToAWS = function( presignedUrl, file, fileType ){
    return $http.put( presignedUrl, file, { headers: { 'Content-Type': fileType } } )
  };

  return BackEndService;

}]);
