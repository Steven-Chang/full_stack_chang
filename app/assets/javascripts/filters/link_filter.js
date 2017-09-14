'use strict';

app.filter("linkFilter", function () {
  return function (link) {
    var result;
    var startingUrl = "http://";
    var httpsStartingUrl = "https://"; 
    if( link.startWith( httpsStartingUrl ) ){
      result = link;
    } else if ( link.startWith( startingUrl ) ) {
      result = link.replace( startingUrl, httpsStartingUrl );
    } else {
      result = httpsStartingUrl + link;
    };

    return result;
  }
});

String.prototype.startWith = function (str) {
  return this.indexOf(str) == 0;
};