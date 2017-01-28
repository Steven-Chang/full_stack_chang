app.controller('HomeController', ['$scope', '$timeout', 'Auth', 'blogPosts', function($scope, $timeout, Auth, blogPosts){

	// --------------------
	// Private
	// --------------------

	// --------------------
	// Public
	// --------------------

	// This is a function.
  $scope.signedIn = Auth.isAuthenticated;
  $scope.addBlogPostsFormVisible = false;

  $scope.newBlogPostHub = {
  	description: "",
  	imageUrl: "",
  	title: "",
  	youtubeUrl: "",
  	dateAdded: "",
    postingNewBlogPost: false,
  	createNewBlogPost: function(){
      if ( !$scope.newBlogPostHub.postingNewBlogPost ){
        $scope.newBlogPostHub.postingNewBlogPost = true;
        blogPosts.post({description: $scope.newBlogPostHub.description, image_url: $scope.newBlogPostHub.imageUrl, title: $scope.newBlogPostHub.title, youtube_url: $scope.newBlogPostHub.youtubeUrl, date_added: $scope.newBlogPostHub.dateAdded})
        .then(function( result ){
          $scope.blogPosts.push(result);
          $scope.newBlogPostHub.description = "";
          $scope.newBlogPostHub.imageUrl = "";
          $scope.newBlogPostHub.title = "";
          $scope.newBlogPostHub.youtubeUrl = "";
          $scope.newBlogPostHub.dateAdded = "";
        })
        .finally(function(){
          $scope.newBlogPostHub.postingNewBlogPost = false;
        });
      };
  	}
  };

  $scope.blogPosts = blogPosts;

  $timeout(function(){
    $('#date-picker').datepicker({
      format: "dd/mm/yyyy"
    });
  }, 100);

  $scope.slideToggleAddBlogPostForm = function(){
    $( "#add-blog-post-form" ).slideToggle( "slow" );
  };
}])