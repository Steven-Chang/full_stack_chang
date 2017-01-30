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
    tag: "",
    tags: [],
  	title: "",
  	youtubeUrl: "",
  	dateAdded: "",
    postingNewBlogPost: false,
    addTag: function(){
      if (this.tag.length){
        this.tags.push(this.tag);
        this.tag = "";
      };
    },
    // keyCode 13 === Enter
    addTagOnKeyPress: function($event){
      // Stop the form from sending.
      $timeout(function(){
        $scope.newBlogPostHub.tag = $scope.newBlogPostHub.tag.replace(/ /g,'');
      }, 1);
      if ($event.keyCode === 13){
        $event.preventDefault();
        if (this.tag.length){
          this.tags.push( this.tag );
          this.tag = "";
        };
      };
    },
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
  	},
    removeTag: function( index ){
      this.tags.splice(index, 1);
    }
  };

  $scope.blogPosts = blogPosts;

  $scope.initiateVideo = function( index, youtubeUrl ){
    if ( youtubeUrl ){
      var youtubeUrl = youtubeUrl.replace("watch?v=", "v/");
      var youtubeUrl = "<iframe src=\"" + youtubeUrl + "?rel=0&autoplay=1" + "\" frameborder=\"0\" allowfullscreen></iframe>";
      var divId = "#project-image-frame-" + index;
      $( divId ).html(youtubeUrl);
      $( divId ).css({"width": "100%", "max-width": "343px", "height": "200px"});
    };
  };

  $timeout(function(){
    $('#date-picker').datepicker({
      format: "dd/mm/yyyy"
    });
  }, 100);

  $scope.slideToggleAddBlogPostForm = function(){
    $( "#add-blog-post-form" ).slideToggle( "slow" );
  };
}])