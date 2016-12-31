var app = angular.module('app', ['ui.router', 'Devise', 'templates', 'restangular'])

.config(function($stateProvider, $urlRouterProvider){
	$urlRouterProvider.otherwise('/home')

	$stateProvider
		.state('home', {
			url: '/home',
			templateUrl: 'views/home.html',
			controller: 'BusinessController',
			resolve: {
				business: function(Restangular){
					return Restangular.all('businesses').getList()
						.then(function(businesses){
							return businesses[0];
      			});
				}
			}
		})
		.state('login', {
			url: '/login',
			templateUrl: 'views/login.html',
			controller: 'AuthController',
			onEnter: function(Auth, $state){
				if ( Auth.isAuthenticated() ){
					$state.go('dashboard');
				};
			}
		})
		.state('register', {
			url: '/register',
			templateUrl: 'views/register.html',
			controller: 'AuthController',
			resolve: {
				numberOfUsers: function(Restangular){
					return Restangular.oneUrl('number_of_users').get()
						.then(function(response){
							return response.number_of_users;
      			});
      	}
			},
			onEnter: function(Auth, $state, numberOfUsers){
				console.log( Auth.isAuthenticated() );
				if ( Auth.isAuthenticated() ){
					$state.go('dashboard');
				} else if ( numberOfUsers >= 1 ){
					$state.go('home');
				};
			}
		})
		.state('dashboard', {
			url: '/dashboard',
			templateUrl: 'views/dashboard.html',
			controller: 'DashboardController',
			resolve: {
				business: function(Restangular){
					return Restangular.all('businesses').getList()
						.then(function(businesses){
							return businesses[0];
      			});
				}
			},
			onEnter: function(Auth, $state){
				if ( !Auth.isAuthenticated() ){
					$state.go('login');
				};
			}
		})
})

.config(
  ['RestangularProvider',
  function(RestangularProvider) {

    // RestangularProvider.setBaseUrl('/api/v1');
    RestangularProvider.setRequestSuffix('.json');

  }]);