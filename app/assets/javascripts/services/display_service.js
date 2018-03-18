app.service('DisplayService', [
  function () {

  'use strict';

  // -----------------------
  // Private
  // -----------------------

  // -----------------------
  // Public
  // -----------------------

  var displayService = {};

  displayService.slideToggleContainer = function( id ){
    $( id ).slideToggle( "slow" );
  };

  return displayService;

}]);
