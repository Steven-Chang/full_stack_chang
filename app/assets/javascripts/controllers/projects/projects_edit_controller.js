app.controller('ProjectsEditController', ['$stateParams', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', function($stateParams, $scope, $state, AlertService, Auth, BackEndService, DatetimeService, FSCModalService){

	// --------------------
	// Private
	// --------------------
  var updatingProject = false;

  var updateProject = function(){
    $scope.project.put()
      .then(function( response ){
        // Currently we're gonna go back to the projects page on update
        // But later on it should goto the show page, if the show page is going to exist at all... 
        // I can see a lot of reasons for it to exist.
        FSCModalService.showLoading = false;
        $state.go( "projects" );
      }, function( errors ){
        FSCModalService.showLoading = false;
        AlertService.processErrors( errors );
      })
      .finally(function(){
        updatingProject = false;
      });
  };

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
            $scope.project.start_date = DatetimeService.formatDate( response.start_date, "EEE d LLLL yyyy" );
            $scope.project.end_date = DatetimeService.formatDate( response.end_date, "EEE d LLLL yyyy" );
          }, function( errors ){
            AlertService.processErrors( errors );
          });
      }, function( errors ){
        $state.go( "home" );
      });
  };

  $scope.uploadFileThenUpdateProject = function( form ){
    if ( !form.$valid ) {
      $("#edit-project-form").addClass("was-validated");
      return;
    };

    if ( !updatingProject ){
      FSCModalService.showLoading();
      updatingProject = true;

      if ( $scope.file ){
        BackEndService.getPresignedUrl( { filename: $scope.file.name, type: $scope.file.type } )
          .then(function( response ){
            var publicUrl = response.public_url;
            var awsKey = response.aws_key;
            BackEndService.uploadFileToAWS( response.presigned_url, $scope.file, $scope.file.type )
              .then(function( response ){
                $scope.project.attachments.push( response );
                updateProject();
              }, function(errors){
                AlertService.processErrors( errors );
              });
          }, function( errors ){
            AlertService.processErrors( errors );
          });
      } else {
        updateProject();
      };
    };
  };
}])