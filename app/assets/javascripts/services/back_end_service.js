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

  BackEndService.create = function( route, params ){
    return Restangular.all( route ).post( params )
  };

  BackEndService.createJob = function( newJob ){
    return Restangular.all('jobs').post( newJob )
  };

  BackEndService.createPaymentSummary = function( newSummary ){
    return Restangular.all('payment_summaries').post( newSummary )
  };

  BackEndService.createTranxaction = function( newTranxaction ){
    return Restangular.all('tranxactions').post( newTranxaction )
  };

  BackEndService.createTranxactionType = function( newTranxactionType ){
    return Restangular.all('tranxaction_types').post( newTranxactionType )
  };

  BackEndService.get = function( route ){
    return Restangular.all( route ).getList()
  };

  BackEndService.getOne = function( route, id ){
    return Restangular.one( route, id ).get()
  };

  BackEndService.getAims = function(){
    return Restangular.all("aims").getList()
  };

  BackEndService.getBalance = function( params ){
    return Restangular.all( 'tranxactions' ).customGET( "balance", params )
  };

  BackEndService.getClient = function( id ){
    return Restangular.one( 'clients', id ).get()
  };

  BackEndService.getClients = function(){
    return Restangular.all('clients').getList()
  };

  BackEndService.getEntries = function(params){
    return Restangular.all('entries').customGET('by_date', params)
  };

  BackEndService.getJobs = function(){
    return Restangular.all('jobs').getList()
  };

  BackEndService.getJobsBalance = function( params ){
    return Restangular.all( 'jobs' ).customGET( "balance", params )
  };

  BackEndService.getPaymentSummary = function( id ){
    return Restangular.one('payment_summaries', id).get()
  };

  BackEndService.getPaymentSummaries = function( params ){
    return Restangular.all('payment_summaries').getList( params )
  };

  BackEndService.getPresignedUrl = function( params ){
    return Restangular.all('attachments').customGET("presigned", params)
  };

  BackEndService.getProject = function( id ){
    return Restangular.one( "projects", id ).get()
  };

  BackEndService.getProperties = function(){
    return Restangular.all("properties").getList();
  };

  BackEndService.getTaxSummaryForProperties = function( params ){
    return Restangular.all("properties").customGET("tax_summaries", params)
  };

  BackEndService.getTenancyAgreement = function( id ){
    return Restangular.one( 'tenancy_agreements', id ).get()
  };

  BackEndService.getTenancyAgreements = function( params ){
    return Restangular.all('tenancy_agreements').getList( params )
  };

  BackEndService.getTranxaction = function( id ){
    return Restangular.one( "tranxactions", id ).get()
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

  BackEndService.getYearEndings = function(){
    return Restangular.all('payment_summaries').customGET("year_endings")
  };

  BackEndService.restangularizeObject = function(object, route){
    if(!object.route && route){
      object.route = route;
    };

    // All restangular objects will have the remove function
    if(!object.remove){
      object = Restangular.copy(object);
    };

    return object;
  };

  BackEndService.uploadFileToAWS = function( presignedUrl, file, fileType ){
    return $http.put( presignedUrl, file, { headers: { 'Content-Type': fileType } } )
  };

  return BackEndService;

}]);
