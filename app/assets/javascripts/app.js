var app = angular.module('app', [
	'angularModalService',
	'chart.js',
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

  // This is to access the previous state after log in
  // Using $window.history.back() can take you to a page outside of the site
	$rootScope.$on('$stateChangeSuccess', function(event, to, toParams, from, fromParams) {
	  $rootScope.previousState = from.name;
	});
}])

.config(
  ['cloudinaryProvider', 
  function (cloudinaryProvider) {
    cloudinaryProvider
      .set("cloud_name", "digguide")
      .set("upload_preset", "thelook")
      .set("secure", "true")
  }])

.config(['momentPickerProvider', function (momentPickerProvider) {
    momentPickerProvider.options({
    	format: "ddd D MMM YYYY HH:mm A",
    	minView: "month",
    	maxView: "minute",
    	today: true
		})
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
		.state('aims', {
			url: '/aims',
			templateUrl: 'views/aims/aims.html',
			controller: 'AimsController'
		})
		.state('home', {
			url: '/',
			templateUrl: 'views/home.html',
			controller: 'HomeController'
		})
		.state('paymentsummariesedit', {
			url: '/payment-summaries/:id/edit',
			templateUrl: 'views/payment_summaries/edit.html',
			controller: 'PaymentSummariesEditController'
		})
		.state('paymentsummariesnew', {
			url: '/payment-summaries/new',
			templateUrl: 'views/payment_summaries/new.html',
			controller: 'PaymentSummariesNewController'
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
		.state('taxdashboard', {
			url: '/tax-dashboard',
			templateUrl: 'views/tax_dashboard.html',
			controller: 'TaxDashboardController'
		})
		.state('tetris', {
			url: '/tetris',
			templateUrl: 'views/tetris.html',
			controller: 'TetrisController',
			resolve: {
				highScoresAndAssociations: ['Restangular', function( Restangular ){
					return Restangular.all('scores').getList({
						title: "tetris"})
						.then(function(scores){
							return scores;
      			});
				}]
			}
		})
		.state('tranxactions', {
			url: '/tranxactions',
			templateUrl: 'views/tranxactions/tranxactions.html',
			controller: 'TranxactionsController'
		})
		.state('tranxactionsedit', {
			url: '/tranxactions/:id/edit',
			templateUrl: 'views/tranxactions/edit.html',
			controller: 'TranxactionsEditController'
		})
		.state('tranxactiontypes', {
			url: '/tranxaction-types',
			templateUrl: 'views/tranxaction_types/tranxaction_types.html',
			controller: 'TranxactionTypesController'
		})
		.state('whyhirechang', {
			url: '/whyhirechang',
			templateUrl: 'views/whyhirechang.html',
			controller: 'WhyHireChangController'
		})
}])
