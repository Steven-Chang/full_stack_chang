app.controller('CleaningController', ['$filter', '$rootScope', '$scope', '$timeout', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $rootScope, $scope, $timeout, Auth, DatetimeService, DisplayService, Restangular ){

  //// PRIVATE ////
  var setWeekStartingDates = function(){
    var today = new Date();
    var daysToMinus = today.getDay() - 1;
    if ( daysToMinus < 0 ){
      daysToMinus = 6;
    };
    today.setDate( today.getDate() - daysToMinus );
    $scope.dates.push( today );
  };

  //// PUBLIC ////
  $scope.addTenantFormVisible = false;
  $scope.creatingTask = false;
  $scope.dates = [];
  $scope.newRecord = {
    description: "",
    points: 1,
    user_id: 0
  };
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
  $scope.records;
  $scope.tasks;
  $scope.tenants;

  $scope.createRecord = function(){
    if ( !$scope.creatingRecord ){
      $scope.creatingRecord = true;
      Restangular.all('cleaning_records')
        .post( $scope.creatingRecord )
        .then(function( response ){
          $scope.records.push( response );
        });
    };
  };

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
        $scope.newRecord.user_id = tenants[0].id;
  		})

    Restangular
      .all('cleaning_tasks')
      .getList()
      .then(function(tasks){
        $scope.tasks = tasks;
        $scope.newRecord.description = tasks[0].description;
      });

    setWeekStartingDates();
  };

  $scope.slideToggleContainer = function( id ){
    DisplayService.slideToggleContainer( id );
  };

}]);