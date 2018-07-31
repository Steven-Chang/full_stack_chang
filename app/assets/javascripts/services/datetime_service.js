app.service('DatetimeService', ['$filter', '$timeout', 
  function ( $filter, $timeout ) {

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

  DatetimeService.formatDate = function( date, format ){
    return $filter( 'date' )( date, format )
  };

  return DatetimeService;

}]);
