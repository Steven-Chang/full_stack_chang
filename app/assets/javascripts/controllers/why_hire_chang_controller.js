app.controller('WhyHireChangController', ['$scope', '$timeout', function($scope, $timeout){
	'usestrict;'

	// --------------------
	// Private
	// --------------------

	var screamAudio = document.getElementById("scream-audio");
	var phoneVibrateAudio = document.getElementById("phone-audio");
	var youTubePlayer;

	var init = function(){
		$("body").css("background-color", "black");

		// Makes cursor look like a video tape
		$("body").css("cursor", "url('http://res.cloudinary.com/digguide/image/upload/s--bG08Bp80--/c_scale,w_125/v1473835092/Personal%20Site/Portflio/Why%20Hire%20Chang/S-VHS-cassette-tape.jpg'), pointer");

		$("html").css("height", "100%");
		$("body").css("height", "100%");
	};

	var slideUpPhoneInHand = function(){
		$("#phone-in-hand").show("slide", {
	      direction: "down"
	  }, 2000, function(){
	  	// action to run once animation is complete
	  	screamAudio.play();
	  });
	};

	// --------------------
	// Public
	// --------------------

	$scope.staticImageVisible = true;
	$scope.phoneVisible = false;
	$scope.theRing = 'yiFrSgW3ZvU';
	$scope.videoSlotVisible = true;
  $scope.youTubePlayerVariables = { controls: 0, frameborder: 0, showinfo: 0, rel: 0 };

 	$scope.$on('youtube.player.ended', function ($event, player) {
 		$scope.phoneVisible = true;
 		phoneVibrateAudio.play();
 		$scope.staticImageVisible = true;
  });

 	$scope.$on('youtube.player.ready', function ($event, player) {
		youTubePlayer = player;
  });

	$scope.runPhoneClickEvents = function(){
		$scope.phoneVisible = false;
		phoneVibrateAudio.pause();
		slideUpPhoneInHand();
	};

	$scope.clickVideoSlot = function(){
		youTubePlayer.playVideo();
		$timeout(function(){
			$scope.staticImageVisible = false;
		}, 4500)

		// remove #video-slot other wise every click restarts the video
    $scope.videoSlotVisible = false;

    // changes curso to look normal
   	$("body").css("cursor", "default");

   	youTubePlayer.playVideo();
	};

	init();

}])