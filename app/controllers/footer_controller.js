app.controller('FooterController', ['_', '$scope', '$state', 'Auth', 'ElisyamService', 'Restangular', function( _, $scope, $state, Auth, ElisyamService, Restangular ){

  // --------------------
  // Private
  // --------------------

  // --------------------
  // Public
  // --------------------
  $scope.init = function(){
  	console.log(123);
    $(window).scroll(function () {
        if ($(this).scrollTop() > 350) {
            $('.go-top').fadeIn(100);
        } else {
            $('.go-top').fadeOut(200);
        }
    });

    // Animate the scroll to top
    $('.go-top').click(function (event) {
        event.preventDefault();

        $('html, body').animate({
            scrollTop: 0
        }, 800);
    })
  };

}]);