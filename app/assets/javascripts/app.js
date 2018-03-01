var app = angular.module('app', [
	'cloudinary',
	'cp.ngConfirm',
  'infinite-scroll',
	'ui.router', 
	'Devise', 
	'templates', 
	'restangular',
	'youtube-embed'
])

.config(
	['$locationProvider', function($locationProvider){
    // use the HTML5 History API
    $locationProvider.html5Mode(true);
	}])

.config(
  ['cloudinaryProvider', 
  function (cloudinaryProvider) {
    cloudinaryProvider
      .set("cloud_name", "digguide")
      .set("upload_preset", "thelook");
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

		.state('portfolio', {
			url: '/portfolio',
			templateUrl: 'views/portfolio.html',
			controller: 'PortfolioController',
			resolve: {
				projects: ['Restangular', function(Restangular){
					return Restangular.all('projects').getList()
						.then(function(projects){
							return projects;
      			});
				}]
			}
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

		.state('rent', {
			url: '/rent',
			templateUrl: 'views/rent.html',
			controller: 'RentController'
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

		.state('whyhirechang', {
			url: '/whyhirechang',
			templateUrl: 'views/whyhirechang.html',
			controller: 'WhyHireChangController'
		})

}])