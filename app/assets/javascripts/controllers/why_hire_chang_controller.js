app.controller('WhyHireChangController', ['$scope', '$timeout', function($scope, $timeout){
	'usestrict;'

	// --------------------
	// Private
	// --------------------

	var screamAudio = document.getElementById("scream-audio");
	var phoneVibrateAudio = document.getElementById("phone-audio");
	var youTubePlayer;

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
 		$scope.staticImageVisible = false;
  });

 	$scope.$on('youtube.player.ready', function ($event, player) {
		youTubePlayer = player;
  });

 	$scope.$on('$destroy', function() {
    $("body").css("background-color", "white");
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
   	$("#why-hire-chang").css("cursor", "default");

   	youTubePlayer.playVideo();
	};

	$("body").css("background-color", "black");

}])