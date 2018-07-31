app.controller('PortfolioController', ['$scope', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', 'projects', function($scope, AlertService, Auth, BackEndService, DatetimeService, FSCModalService, projects){

	// --------------------
	// Private
	// --------------------

	// --------------------
	// Public
	// --------------------

	// This is a function.
  $scope.signedIn = Auth.isAuthenticated;
  $scope.addProjectFormVisible = false;
  $scope.deletingProject = false;

  $scope.newProjectHub = {
    attachments: [],
  	description: "",
  	title: "",
  	url: "",
  	dateAdded: "",
    endDate: "",
    postingNewProject: false,
  	createNewProject: function(){
      projects.post({ 
        description: $scope.newProjectHub.description, 
        title: $scope.newProjectHub.title, 
        url: $scope.newProjectHub.url, 
        start_date: $scope.newProjectHub.dateAdded, 
        end_date: $scope.newProjectHub.endDate,
        attachments: $scope.newProjectHub.attachments })
      .then(function( result ){
        $scope.projects.push(result);
        $scope.newProjectHub.description = "";
        $scope.newProjectHub.title = "";
        $scope.newProjectHub.url = "";
        $scope.newProjectHub.dateAdded = "";
        $scope.newProjectHub.endDate = "";
        $scope.newProjectHub.attachments = [];
      })
      .finally(function(){
        $scope.newProjectHub.postingNewProject = false;
        FSCModalService.loading = false;
      });
  	}
  };

  $scope.projects = projects;

  DatetimeService.initiateDatePicker('#date-picker-start');
  DatetimeService.initiateDatePicker('#date-picker-end');

  $scope.deleteProject = function( project ){
    if ( !$scope.deletingProject ){
      FSCModalService.confirmDelete()
        .then(function( modal ){
          modal.close
            .then(function( confirmed ){
              if ( confirmed ){
                FSCModalService.showLoading();
                $scope.deletingProject = true;
                project.remove()
                  .then(function( response ){
                    var index = $scope.projects.indexOf( project );
                    if (index > -1) $scope.projects.splice(index, 1);
                    AlertService.success("Project deleted");
                  }, function( errors ){
                    AlertService.processErrors( errors );
                  })
                  .finally(function(){
                    $scope.deletingProject = false;
                    FSCModalService.loading = false;
                  });
              };
            });
        });
    };
  };

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
            var publicUrl = response.public_url;
            var awsKey = response.aws_key;
            BackEndService.uploadFileToAWS( response.presigned_url, $scope.file, $scope.file.type )
              .then(function( response ){
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