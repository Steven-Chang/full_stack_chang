app.controller('ProjectsEditController', ['$stateParams', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', function($stateParams, $scope, $state, AlertService, Auth, BackEndService, DatetimeService, FSCModalService){

	// --------------------
	// Private
	// --------------------

	// --------------------
	// Public
	// --------------------

	// This is a function.
  $scope.project;
  $scope.signedIn = Auth.isAuthenticated;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        DatetimeService.initiateDatePicker('#date-picker-start');
        DatetimeService.initiateDatePicker('#date-picker-end');
        BackEndService.getProject( $stateParams.id )
          .then(function( response ){
            $scope.project = response;
          }, function( errors ){
            AlertService.processErrors( errors );
          });
      }, function( errors ){
        $state.go( "home" );
      });
  };

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