app.controller('PortfolioController', ['$scope', '$timeout', 'Auth', 'DatetimeService', 'projects', function($scope, $timeout, Auth, DatetimeService, projects){

	// --------------------
	// Private
	// --------------------

	// --------------------
	// Public
	// --------------------

	// This is a function.
  $scope.signedIn = Auth.isAuthenticated;
  $scope.addProjectFormVisible = false;

  $scope.newProjectHub = {
  	description: "",
  	imageUrl: "",
  	title: "",
  	url: "",
  	dateAdded: "",
    postingNewProject: false,
  	createNewProject: function(){
      if ( !$scope.newProjectHub.postingNewProject ){
        $scope.newProjectHub.postingNewProject = true;
        projects.post({description: $scope.newProjectHub.description, image_url: $scope.newProjectHub.imageUrl, title: $scope.newProjectHub.title, url: $scope.newProjectHub.url, date_added: $scope.newProjectHub.dateAdded})
        .then(function( result ){
          $scope.projects.push(result);
          $scope.newProjectHub.description = "";
          $scope.newProjectHub.imageUrl = "";
          $scope.newProjectHub.title = "";
          $scope.newProjectHub.url = "";
          $scope.newProjectHub.dateAdded = "";
        })
        .finally(function(){
          $scope.newProjectHub.postingNewProject = false;
        });
      };
  	}
  };

  $scope.projects = projects;

  DatetimeService.initiateDatePicker('#date-picker');

  $scope.slideToggleAddProjectForm = function(){
    $( "#add-project-form" ).slideToggle( "slow" );
  };
}])