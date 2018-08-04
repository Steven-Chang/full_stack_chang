var app = angular.module('app', [
	'angularModalService',
	'cloudinary',
	'cp.ngConfirm',
  'infinite-scroll',
  'moment-picker',
	'ui.router', 
	'Devise', 
	'templates', 
	'restangular',
	'youtube-embed'
])

.constant('_', window._)

.run(["$rootScope", function($rootScope) {
  $rootScope._ = window._;
  // Getting rid of that pre loader
  $(".loader").fadeOut();
  $("#preloader").delay(350).fadeOut("slow");
}])

.config(
  ['cloudinaryProvider', 
  function (cloudinaryProvider) {
    cloudinaryProvider
      .set("cloud_name", "digguide")
      .set("upload_preset", "thelook")
      .set("secure", "true")
  }])

.config(
  ['RestangularProvider',
  function(RestangularProvider) {

    // RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.setRequestSuffix('.json');

  }])

.config(['$qProvider', function ($qProvider) {
  $qProvider.errorOnUnhandledRejections(false);
}])

.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider){
	$urlRouterProvider.otherwise('/')

	$stateProvider

		.state('cleaning', {
			url: '/cleaning',
			templateUrl: 'views/cleaning.html',
			controller: 'CleaningController'
		})

		.state('work', {
			url: '/work',
			templateUrl: 'views/work.html',
			controller: "WorkController"
		})

		.state('home', {
			url: '/',
			templateUrl: 'views/home.html',
			controller: 'HomeController',
			resolve: {
				blogPosts: ['Restangular', function(Restangular){
					return Restangular.all('blog_posts').getList({ "page": 1 })
						.then(function(blogPosts){
							return blogPosts;
      			});
				}]
			}
		})

		.state('projects', {
			url: '/projects',
			templateUrl: 'views/projects/index.html',
			controller: 'ProjectsController',
			resolve: {
				projects: ['Restangular', function( Restangular ){
					return Restangular.all('projects').getList()
						.then(function(projects){
							return projects;
      			});
				}]
			}
		})
		.state('projectsedit', {
			url: '/projects/:id/edit',
			templateUrl: 'views/projects/edit.html',
			controller: 'ProjectsEditController'
		})

		.state('properties', {
			url: '/properties',
			templateUrl: 'views/properties.html',
			controller: 'PropertiesController'
		})
		.state('propertiesshow', {
			url: '/properties/:id',
			templateUrl: 'views/properties/show.html',
			controller: 'PropertiesShowController'
		})

		.state('login', {
			url: '/login',
			templateUrl: 'views/login.html',
			controller: 'AuthController',
			onEnter: ['Auth', '$state', function(Auth, $state){
				if ( Auth.isAuthenticated() ){
					$state.go('home');
				};
			}]
		})

		.state('register', {
			url: '/register',
			templateUrl: 'views/register.html',
			controller: 'AuthController',
			resolve: {
				numberOfUsers: ['Restangular', function(Restangular){
					return Restangular.oneUrl('number_of_users').get()
						.then(function(response){
							return response.number_of_users;
      			});
      	}]
			},
			onEnter: ['Auth', '$state', 'numberOfUsers', function(Auth, $state, numberOfUsers){
				if ( Auth.isAuthenticated() ){
					$state.go('dashboard');
				} else if ( numberOfUsers >= 2 ){
					$state.go('home');
				};
			}]
		})

		.state('tenancyagreements', {
			url: '/tenancy-agreements',
			templateUrl: 'views/tenancy_agreements/index.html',
			controller: "TenancyAgreementsController"
		})

		.state('tetris', {
			url: '/tetris',
			templateUrl: 'views/tetris.html',
			controller: 'TetrisController',
			resolve: {
				highScoresAndAssociations: ['Restangular', function( Restangular ){
					return Restangular.all('scores').getList({
						title: "Tetris"})
						.then(function( scores ){
							return scores;
      			});
				}]
			}
		})

		.state('tranxactions', {
			url: '/tranxactions',
			templateUrl: 'views/tranxactions.html',
			controller: 'TranxactionsController'
		})

		.state('tranxactiontypes', {
			url: '/tranxaction-types',
			templateUrl: 'views/tranxaction_types/tranxaction_types.html',
			controller: 'TranxactionTypesController'
		})

		.state('users', {
			url: "/users",
			templateUrl: "views/users/users.html",
			controller: "UsersController"
		})
		.state('usersedit', {
			url: '/users/:id/edit',
			templateUrl: "views/users/edit.html",
			controller: ""
		})

		.state('whyhirechang', {
			url: '/whyhirechang',
			templateUrl: 'views/whyhirechang.html',
			controller: 'WhyHireChangController'
		})

}])