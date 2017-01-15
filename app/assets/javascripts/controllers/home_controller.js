app.controller('HomeController', ['$scope', '$timeout', 'Auth', 'projects', function($scope, $timeout, Auth, projects){

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
  	date_added: "",
  	createNewProject: function(){
  		projects.post({description: this.description, image_url: this.image_url, title: this.title, url: this.url, date_added: this.date_added})
      .then(function( result ){
        $scope.projects.push(result);
      });
  	}
  };

  $scope.projects = projects;

  $timeout(function(){
    $('#date-picker').datepicker({
      format: "dd/mm/yyyy"
    });
  }, 100)
}])