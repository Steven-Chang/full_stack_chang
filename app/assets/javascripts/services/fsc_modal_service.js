// https://ned.im/noty/#/types

app.service('FSCModalService', ['ModalService',
  function ( ModalService ) {

  'use strict';

  // -----------------------
  // Private
  // -----------------------

  // -----------------------
  // Public
  // -----------------------

  var fscModalService = {};

  fscModalService.loading = true;

  fscModalService.closeAll = function(){
    ModalService.closeModals()
  };

  fscModalService.confirmDelete = function(){
    return ModalService.showModal({
      templateUrl: "views/modals/confirm.html",
      controller: ['$scope', 'close', function( $scope, close ){
        $scope.confirm = function(){
          close( true );
        };

        $scope.cancel = function(){
          close( false )
        };
      }],
    })
  };

  fscModalService.showEmailConfirmationSent = function(){
    ModalService.showModal({
      templateUrl: "views/modals/email_confirmation_sent.html",
      controller: ['$scope', 'close', function( $scope, close ){
      }],
    }).then(function(modal) {

    });
  };

  fscModalService.showLoading = function(){
    fscModalService.loading = true;
    ModalService.showModal({
      templateUrl: "views/modals/loading.html",
      controller: ['$scope', 'FSCModalService', 'close', function( $scope, FSCModalService, close ){
        $scope.FSCModalService = FSCModalService;
        $scope.$watch( 'FSCModalService.loading', function( newItem, oldItem ){
          if ( !newItem ){
            close();
          };
        });
      }]
    }).then(function(modal) {

    });
  };

  return fscModalService;

}]);