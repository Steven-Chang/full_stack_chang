// https://ned.im/noty/#/types

app.service('AlertService', ['_',
  function ( _ ) {

  'use strict';

  // -----------------------
  // Private
  // -----------------------

  function humanize(str) {
      return _.capitalize(_.trim(_.snakeCase(str).replace(/_id$/, '').replace(/_/g, ' ')));
  };

  var show = function( type, message ){
     new Noty({
      type: type,
      layout: 'topRight',
      text: message,
      closeWith: ['click', 'button'],
      timeout: 2500,
      animation: {
        open: 'animated fadeInDown', // Animate.css class names
        close: 'animated fadeOutUp' // Animate.css class names
      }
    }).show()
  };

  // -----------------------
  // Public
  // -----------------------

  var alertService = {};

  alertService.processErrors = function( errors ){
    if ( errors.data.error ){
       alertService.error( errors.data.error );
    } else if ( errors.data.errors ){
      if ( typeof errors.data.errors  === 'string'  ) {
         alertService.error( humanize( errors.data.errors ) );
      } else if ( errors.data.errors instanceof Array ) {
        _.each( errors.data.errors, function( error ){
           alertService.error( humanize( error ) );
        });
      } else if ( typeof errors.data.errors  === 'object' ){
        _.each( errors.data.errors, function( subErrors, key ){
          if ( typeof subErrors === 'string' ) {
             alertService.error( humanize( key ) + ": " + humanize( subErrors ) );
          } else if ( subErrors instanceof Array ){
            _.each( subErrors, function( error ){
               alertService.error( humanize( key ) + ": " + humanize( error ) );
            });
          } else if ( typeof subErrors === 'object' ){
            _.each( subErrors, function( serror, key ){
               alertService.error( humanize( key ) + ": " + humanize( serror ) );
            })
          };
        });
      };
    } else if ( errors.data ) {
      _.each( errors.data, function( subErrors, key ){
          if ( typeof subErrors === 'string' ) {
             alertService.error( humanize( key ) + ": " + humanize( subErrors ) );
          } else if ( subErrors instanceof Array ){
            _.each( subErrors, function( error ){
               alertService.error( humanize( key ) + ": " + humanize( error ) );
            });
          } else if ( typeof subErrors === 'object' ){
            _.each( subErrors, function( error, key ){
               alertService.error( humanize( key ) + ": " + humanize( error ) );
            })
          };
        });
    } else {
      alertService.error( humanize( errors.statusText ) );
    };
  };

  alertService.error = function( message ){
    show( 'error', message );
  };

  alertService.success = function( message ){
    show( 'success', message );
  };

  return alertService;

}]);