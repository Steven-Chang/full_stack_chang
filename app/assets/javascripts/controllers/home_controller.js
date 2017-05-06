app.controller('HomeController', ['$ngConfirm', '$scope', '$timeout', 'Auth', 'blogPosts', 'Restangular', function($ngConfirm, $scope, $timeout, Auth, blogPosts, Restangular){

	// --------------------
	// Private
	// --------------------

	// --------------------
	// Public
	// --------------------

	// This is a function.
  $scope.signedIn = Auth.isAuthenticated;
  $scope.addBlogPostsFormVisible = false;
  $scope.stackText = "{ backEnd : RUBY ON RAILS, frontEnd : ANGULAR }";
  $scope.theAimText = "theAim = [ FUN, FUNCTIONAL, DIFFERENT ]"
  $scope.youTubePlayerVariables = { controls: 0, frameborder: 0, showinfo: 0, rel: 0 
  };

  $scope.newBlogPostHub = {
  	description: "",
  	imageUrl: "",
    tag: "",
    tags: [],
  	title: "",
  	youtubeUrl: "",
  	dateAdded: "",
    postingNewBlogPost: false,
    addTagAndReset: function(){
      this.removeWhiteSpacesFromTag();
      if (this.tag.length && this.tagIsUnique()){
        this.tags.push(this.tag);
      };
      this.tag = "";
    },
    // keyCode 13 === Enter
    addTagOnKeyPress: function($event){
      if ($event.keyCode === 13){
        $event.preventDefault();
        this.addTagAndReset();
      };
    },
    returnMatchingTag: function(word){
      return word.toLowerCase() === $scope.newBlogPostHub.tag.toLowerCase();
    },
  	createNewBlogPost: function(){
      if ( !$scope.newBlogPostHub.postingNewBlogPost ){
        $scope.newBlogPostHub.postingNewBlogPost = true;
        blogPosts.post( { description: $scope.newBlogPostHub.description, 
                          image_url: $scope.newBlogPostHub.imageUrl, 
                          title: $scope.newBlogPostHub.title, 
                          youtube_url: $scope.newBlogPostHub.youtubeUrl, 
                          date_added: $scope.newBlogPostHub.dateAdded, 
                          tags: $scope.newBlogPostHub.tags } )
        .then(function( result ){
          $scope.blogPosts.push(result);
          $scope.newBlogPostHub.description = "";
          $scope.newBlogPostHub.imageUrl = "";
          $scope.newBlogPostHub.title = "";
          $scope.newBlogPostHub.youtubeUrl = "";
          $scope.newBlogPostHub.dateAdded = "";
          $scope.newBlogPostHub.tags = [];
          $scope.newBlogPostHub.tag = "";
          console.log( $scope.blogPosts );
        })
        .finally(function(){
          $scope.newBlogPostHub.postingNewBlogPost = false;
        });
      };
  	},
    removeTag: function( index ){
      this.tags.splice(index, 1);
    },
    removeWhiteSpacesFromTag: function(){
      $scope.newBlogPostHub.tag = $scope.newBlogPostHub.tag.replace(/ /g,'');
    },
    tagIsUnique: function(){
      return !this.tags.find(this.returnMatchingTag)
    }
  };

  $scope.blogPosts = blogPosts;

  $scope.deleteBlogPost = function(post){
    post.remove().then(function(){
      var index = $scope.blogPosts.indexOf(post);
      if (index > -1) $scope.blogPosts.splice(index, 1);
    });
  };

  // I wonder if you can insert it in at 0% and then change the class of it
  // well i mean switch classes...
  $scope.initiateVideo = function( index ){
    // Gotta remove the image container
    // and increase the size of the container
    $("#play-button-container-" + index).remove();
    $("#youtube-container-" + index).css("height", "98%");
    $("#blog-post-image-"+ index).css("height", "0px");
    $("#project-image-frame-" + index).css("min-height", "275px");
  };

  $scope.retrieveAllBlogPostsViaTag = function( tag ){
    Restangular.all('blog_posts').getList([tag])
            .then(function(blogPosts){
              $scope.blogPosts = blogPosts;
            });
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