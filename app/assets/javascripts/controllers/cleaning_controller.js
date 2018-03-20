app.controller('CleaningController', ['$filter', '$rootScope', '$scope', '$timeout', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $rootScope, $scope, $timeout, Auth, DatetimeService, DisplayService, Restangular ){

  //// PRIVATE ////

  //// PUBLIC ////
  $scope.addTenantFormVisible = false;
  $scope.creatingTask = false;
  $scope.newTask = {
    description: "",
    points: 1
  };
  $scope.newTenant = {
    email: "",
    username: "",
    remember_me: false,
    tenant: true
  };
  $scope.tasks;
  $scope.tenants;

  $scope.createTask = function(){
    if ( !$scope.creatingTask ){
      $scope.creatingTask = true;
      Restangular.all('cleaning_tasks')
        .post( $scope.newTask )
        .then(function( response ){
          $scope.tasks.push( response );
          $scope.newTask.description = "";
          $scope.newTask.points = 1;
          $scope.creatingTask = false;
        });
    };
  };

  $scope.createTenant = function(){
    Auth.register($scope.newTenant, config)
    .then(function( tenant ){
      $scope.newTenant.email = "";
      $scope.newTenant.username = "";
      $scope.tenants.push( tenant );
    }, function(response){
      console.log("Error");
    });
  };

  $scope.init = function(){
  	Restangular
  		.all('tenants')
  		.getList({page: "cleaning"})
  		.then(function( tenants ){
  			$scope.tenants = tenants;
  		})

    Restangular
      .all('cleaning_tasks')
      .getList()
      .then(function(tasks){
        $scope.tasks = tasks;
      });
  };

  $scope.slideToggleContainer = function( id ){
    DisplayService.slideToggleContainer( id );
  };

}]);