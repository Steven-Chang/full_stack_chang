app.controller('TaxDashboardController', ['$filter', '$ngConfirm', '$rootScope', '$scope', '$state', 'AlertService', 'Auth', 'BackEndService', 'FSCModalService', function( $filter, $ngConfirm, $rootScope, $scope, $state, AlertService, Auth, BackEndService, FSCModalService ){

  //// PRIVATE
  var getBalances = function(){
    if ( $scope.yearEnding ){
      var params = {
        from_date: new Date( $scope.yearEnding - 1, 7, 1 ),
        end_date: new Date($scope.yearEnding, 6, 30),
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

    BackEndService.getPropertyTaxSummaries( params )
      .then(function( response ){
        $scope.properties = response;
      }, function( errors ){

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

}]);

