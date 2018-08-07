app.controller('TranxactionsEditController', ['$stateParams', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'DatetimeService', 'FSCModalService', function($stateParams, $scope, $state, AlertService, Auth, BackEndService, DatetimeService, FSCModalService){

	// --------------------
	// Private
	// --------------------
  var updatingTranxaction = false;

  var updateTranxaction = function(){
    $scope.tranxaction.put()
      .then(function( response ){
        // Currently we're gonna go back to the projects page on update
        // But later on it should goto the show page, if the show page is going to exist at all... 
        // I can see a lot of reasons for it to exist.
        FSCModalService.loading = false;
        $state.go( "tranxactions" );
      }, function( errors ){
        FSCModalService.loading = false;
        AlertService.processErrors( errors );
      })
      .finally(function(){
        updatingTranxaction = false;
      });
  };

	// --------------------
	// Public
	// --------------------

	// This is a function.
  $scope.tranxaction;
  $scope.signedIn = Auth.isAuthenticated;

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        DatetimeService.initiateDatePicker('#date-picker');
        BackEndService.getTranxaction( $stateParams.id )
          .then(function( response ){
            $scope.tranxaction = response;
            $scope.tranxaction.date = DatetimeService.formatDate( response.date, "EEE d LLLL yyyy" );
          }, function( errors ){
            AlertService.processErrors( errors );
          });
      }, function( errors ){
        $state.go( "home" );
      });
  };

  $scope.uploadFileThenUpdateTranxaction = function( form ){
    if ( !form.$valid ) {
      $("#edit-tranxaction-form").addClass("was-validated");
      return;
    };

    if ( !updatingTranxaction ){
      FSCModalService.showLoading();
      updatingTranxaction = true;

      if ( $scope.file ){
        BackEndService.getPresignedUrl( { filename: $scope.file.name, type: $scope.file.type } )
          .then(function( response ){
            var publicUrl = response.public_url;
            var awsKey = response.aws_key;
            BackEndService.uploadFileToAWS( response.presigned_url, $scope.file, $scope.file.type )
              .then(function( response ){
                $scope.project.attachments.push( response );
                updateTranxaction();
              }, function(errors){
                AlertService.processErrors( errors );
              });
          }, function( errors ){
            AlertService.processErrors( errors );
          });
      } else {
        updateTranxaction();
      };
    };
  };

}])