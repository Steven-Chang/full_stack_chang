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

  displayService.slideToggleContainer = function( element, toggleSpeed ){
    if ( !toggleSpeed ){
      var toggleSpeed = "slow";
    };

    $( element ).slideToggle( toggleSpeed );
  };

  return displayService;

}]);
