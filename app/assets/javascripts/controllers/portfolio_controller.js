app.controller('PortfolioController', ['$scope', '$timeout', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', 'projects', function($scope, $timeout, Auth, BackEndService, DatetimeService, FSCModalService, projects){

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
    attachments: [],
  	description: "",
  	title: "",
  	url: "",
  	dateAdded: "",
    postingNewProject: false,
  	createNewProject: function(){
      projects.post({ 
        description: $scope.newProjectHub.description, 
        title: $scope.newProjectHub.title, 
        url: $scope.newProjectHub.url, 
        date_added: $scope.newProjectHub.dateAdded, 
        attachments: $scope.newProjectHub.attachments })
      .then(function( result ){
        $scope.projects.push(result);
        $scope.newProjectHub.description = "";
        $scope.newProjectHub.title = "";
        $scope.newProjectHub.url = "";
        $scope.newProjectHub.dateAdded = "";
        $scope.newProjectHub.attachments = [];
      })
      .finally(function(){
        $scope.newProjectHub.postingNewProject = false;
        FSCModalService.loading = false;
      });
  	}
  };

  $scope.projects = projects;

  DatetimeService.initiateDatePicker('#date-picker');

  $scope.uploadFileThenCreateProject = function( form ){
    if ( !form.$valid ) {
      $("#add-project-form").addClass("was-validated");
      return;
    };

    if ( !$scope.newProjectHub.postingNewProject ){
      FSCModalService.showLoading();
      $scope.newProjectHub.postingNewProject = true;

      if ( $scope.file ){
        BackEndService.getPresignedUrl( { filename: $scope.file.name, type: $scope.file.type } )
          .then(function( response ){
            BackEndService.uploadFileToAWS( response.presigned_url, $scope.file, $scope.file.type )
              .then(function( response ){
                var publicUrl = response.public_url;
                var awsKey = response.aws_key;
                $scope.newProjectHub.attachments.push( { url: publicUrl, aws_key: awsKey } );
                $scope.newProjectHub.createNewProject();
              }, function(errors){
                AlertService.processErrors( errors );
              });
          }, function( errors ){
            AlertService.processErrors( errors );
          });
      } else {
        $scope.newProjectHub.createNewProject();
      };
    };
  };
}])