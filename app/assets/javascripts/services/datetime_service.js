app.service('DatetimeService', ['$timeout', 
  function ( $timeout ) {

  'use strict';

  // -----------------------
  // Private
  // -----------------------

  // -----------------------
  // Public
  // -----------------------

  var DatetimeService = {};

  DatetimeService.initiateDatePicker = function( selector ){
    $timeout(function(){
      $( selector ).datepicker({
        autoclose: true,
        format: "D dd MM yyyy"
      });
    });
  };

  return DatetimeService;

}]);
