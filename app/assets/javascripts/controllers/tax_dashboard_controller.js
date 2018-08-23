app.controller('TaxDashboardController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'FSCModalService', function( $filter, $ngConfirm, $rootScope, $scope, $state, AlertService, Auth, BackEndService, FSCModalService ){

  //// PRIVATE
  var getBalances = function(){
    if ( $scope.yearEnding ){
      var params = {
        from_date: ($scope.yearEnding - 1).toString() + "-7-1",
        to_date: $scope.yearEnding + "-6-30",
        tax: true,
        tranxaction_type: "revenue"
      }

      BackEndService.getBalance( params )
        .then(function( response ){
          $scope.revenue = response.balance;
        }, function( errors ){
          AlertService.processErrors( errors );
        });

      params.tranxaction_type = "expense";

      BackEndService.getBalance( params )
        .then(function( response ){
          $scope.expenses = response.balance;
        }, function( errors ){
          AlertService.processErrors( errors );
        });
    }
  };

  var getBalance = function( resource, resourceType, resourceId, taxCategory ){
    if ( $scope.yearEnding ){
      var params = {
        resource_type: resourceType,
        resource_id: resourceId,
        from_date: ($scope.yearEnding - 1).toString() + "-7-1",
        to_date: $scope.yearEnding + "-6-30",
        tax: true,
        tax_category: taxCategory
      };

      BackEndService.getBalance( params )
        .then(function( response ){
          resource.balance = response.balance;
          return response.balance;
        }, function( errors ){
          AlertService.processErrors( errors );
        });
    }
  };

  var getCategoriesAndBalancesForProperty = function( property ){
    var params = {
      resource_type: "Property",
      resource_id: property.id
    };

    BackEndService.get("tax_categories", params)
      .then(function( response ){
        property.expenses = response;
        for( var i = 0; i < response.length; i++ ){
          getBalance( response[i], "Property", property.id, response[i].description );
        };
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  var getPaymentSummaries = function(){
    FSCModalService.showLoading();
    var params = {
      year_ending: $scope.yearEnding
    };

    BackEndService.getPaymentSummaries( params )
      .then(function(response){
        $scope.paymentSummaries = response;
      }, function( errors ){
        AlertService.processErrors( errors );
      })
      .finally(function(){
        FSCModalService.loading = false;
      });
  };

  var getPropertySummaries = function(){
    var params = {
      year_ending: $scope.yearEnding
    };

    BackEndService.get( "properties" )
      .then(function( response ){
        $scope.properties = response;

        for (var i = 0; i < $scope.properties.length; i++){
          getTenancyAgreementsAndBalancesForProperty( $scope.properties[i] );
          getCategoriesAndBalancesForProperty( $scope.properties[i] );
        };
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  var getTenancyAgreementsAndBalancesForProperty = function( property ){
    var params = {
      property_id: property.id
    };

    BackEndService.get("tenancy_agreements", params)
      .then(function( response ){
        property.tenancy_agreements = response;
        for( var i = 0; i < response.length; i++ ){
          getBalance( response[i], "TenancyAgreement", response[i].id );
        };
      }, function( errors ){
        AlertService.processErrors( errors );
      });
  };

  //// PUBLIC ////
  $scope.client;
  $scope.expenses;
  $scope.paymentSummaries;
  $scope.properties;
  $scope.revenue;
  $scope.tenancyAgreements;
  $scope.yearEnding;
  $scope.yearEndings;

  $scope.$watch( "yearEnding", function(){
    getPaymentSummaries();
    getPropertySummaries();
    getBalances();
    // We need to get the balances of each payment summary for the date
  });

  $scope.init = function(){
    FSCModalService.showLoading();
    Auth.currentUser()
      .then(function( user ){
        $scope.user = user;
        FSCModalService.loading = false;
        if ( user.admin ){
          BackEndService.getYearEndings()
            .then(function( response ){
              $scope.yearEndings = response;
              $scope.yearEnding = response[0];
            }, function( errors ){
              AlertService.processErrors( errors );
            });
        } else {
          $state.go( 'home' )
        };
      }, function( error ){
        FSCModalService.loading = false;
        $state.go( 'login' )
      });
  };

  $scope.deleteSummary = function( $index ){
    FSCModalService.confirmDelete()
      .then(function( modal ){
        modal.close
          .then(function( confirmed ){
            if ( confirmed ){
              FSCModalService.showLoading();
              $scope.paymentSummaries[$index].remove()
                .then(function( response){
                  $scope.paymentSummaries.splice( $index, 1 );
                  AlertService.success( "Payment summary deleted.")
                }, function( errors ){
                  AlertService.processErrors( errors );
                })
                .finally(function(){
                  FSCModalService.loading = false;
                });
            };
          })
      })
  };

  $scope.calculateTotalRentalIncomeForProperty = function( property ){
    var total = 0;

    for (var i = 0; i < property.tenancy_agreements.length; i++){
      total += parseFloat( property.tenancy_agreements[i].balance );
    };

    return total;
  };

  $scope.calculateTotalExpensesForProperty = function( property ){
    var total = 0;

    for (var i = 0; i < property.expenses.length; i++){
      total += parseFloat( property.expenses[i].balance );
    };

    return total;
  };

}]);