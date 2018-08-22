app.controller('TaxCategoriesController', ['$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'FSCModalService', function( $scope, $state, AlertService, Auth, BackEndService, FSCModalService){

	// --------------------
	// Private
	// --------------------

  var getTaxCategories = function(){
    FSCModalService.showLoading();
    BackEndService.get( "tax_categories")
      .then(function( response ){
        console.log( response );
        $scope.taxCategories = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      })
      .finally(function(){
        FSCModalService.loading = false;
      });
  };

	// --------------------
	// Public
	// --------------------
  $scope.taxCategories;

  $scope.newTaxCategory = {
    description: ""
  };

  $scope.init = function(){
    Auth.currentUser()
      .then(function( user ){
        if ( user.admin ){
          getTaxCategories();
        } else {
          $state.go( 'home' )
        };
      }, function( error ){
        $state.go( 'login' )
      });
  };

  $scope.createTaxCategory = function(){
    FSCModalService.showLoading();
    BackEndService.create( "tax_categories", $scope.newTaxCategory )
      .then(function( response ){
        $scope.taxCategories.unshift( response );
        AlertService.success("Tax category created.")
        $scope.newTaxCategory.description = "";
      }, function( errors ){
        AlertService.processErrors( errors );
      })
      .finally(function(){
        FSCModalService.loading = false;
      });
  };

  $scope.deleteTaxCategory = function( $index ){
    FSCModalService.confirmDelete()
      .then(function( modal ){
        modal.close
          .then(function( confirmed ){
            if ( confirmed ){
              FSCModalService.showLoading();
              $scope.taxCategories[$index].remove()
                .then(function( response ){
                  $scope.taxCategories.splice( $index, 1  );
                  AlertService.success("Tax category deleted.");
                }, function( errors ){
                  AlertService.processErrors( errors );
                })
                .finally(function(){
                  FSCModalService.loading = false;
                });
            };
          });
      });
  };

}])