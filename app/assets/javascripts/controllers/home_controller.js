app.controller('HomeController', ['$scope', '$timeout', 'Auth', function($scope, $timeout, Auth){

	// --------------------
	// Private
	// --------------------


	// --------------------
	// Public
	// --------------------

	// This is a function.
  $scope.signedIn = Auth.isAuthenticated;

  $scope.newProjectHub = {
  	description: "This works",
  	image_url: "",
  	title: "",
  	url: "",
  	dateAdded: "",
  	createNewProject: function(){
  		console.log(3);
  	}
  };

  $scope.testItems = ["a", "b", "c", "d", "e", "f", "g"]

  $timeout(function(){
    $('#date-picker').datepicker({
      format: "dd/mm/yyyy"
    });
  }, 100)
}])