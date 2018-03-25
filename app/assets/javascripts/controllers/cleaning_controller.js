app.controller('CleaningController', ['$filter', '$rootScope', '$scope', '$timeout', 'Auth', 'DatetimeService', 'DisplayService', 'Restangular', function( $filter, $rootScope, $scope, $timeout, Auth, DatetimeService, DisplayService, Restangular ){

  //// PUBLIC ////
  $scope.addTenantFormVisible = false;
  $scope.cleaningRecords = [];
  $scope.creatingTask = false;
  $scope.dates = [];
  $scope.newRecord = {
    cleaning_task_id: 0,
    date: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
    user_id: 0
  };
  $scope.newTask = {
    description: ""
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
        .post( $scope.newRecord )
        .then(function( response ){
          for(var i = 0; i < $scope.tenants.length; i++){
            if( $scope.tenants[i].id === response.user_id ){
              if( $scope.tenants[i].cleaning_summary[response.cleaning_task_id] ){
                $scope.tenants[i].cleaning_summary[response.cleaning_task_id] += 1;
              } else {
                $scope.tenants[i].cleaning_summary[response.cleaning_task_id] = 1;
              };
            };
          };
          $scope.creatingRecord = false;
          $scope.cleaningRecords.unshift( response );
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
        $scope.newRecord.cleaning_task_id = tasks[0].id;
      });

    DatetimeService.initiateDatePicker('#date-picker');
  };

  $scope.slideToggleContainer = function( id ){
    DisplayService.slideToggleContainer( id );
  };

}]);