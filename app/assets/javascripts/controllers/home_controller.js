app.controller('HomeController', ['$filter', '$http', '$ngConfirm', '$scope', '$timeout', 'Auth', 'BackEndService', 'blogPosts', 'cloudinary', 'DatetimeService', 'FSCModalService', 'Restangular', function( $filter, $http, $ngConfirm, $scope, $timeout, Auth, BackEndService, blogPosts, cloudinary, DatetimeService, FSCModalService, Restangular){

	// --------------------
	// Private
	// --------------------
  var page = 2;
  var recentlyCreatedBlogPostIds = [];
  var searching = false;
  var selectedTag;

  var createPost = function(){
    blogPosts.post( { aws_key: $scope.newBlogPostHub.awsKey,
                      description: $scope.newBlogPostHub.description, 
                      image_url: $scope.newBlogPostHub.imageUrl, 
                      title: $scope.newBlogPostHub.title, 
                      youtube_url: $scope.newBlogPostHub.youtubeUrl, 
                      date_added: $scope.newBlogPostHub.dateAdded, 
                      tags: $scope.newBlogPostHub.tags,
                      attachments: $scope.newBlogPostHub.attachments } )
    .then(function( result ){
      $scope.blogPosts.unshift(result);
      $scope.newBlogPostHub.attachments = [];
      $scope.newBlogPostHub.awsKey = "";
      $scope.newBlogPostHub.description = "";
      $scope.newBlogPostHub.imageUrl = "";
      $scope.newBlogPostHub.title = "";
      $scope.newBlogPostHub.youtubeUrl = "";
      $scope.newBlogPostHub.dateAdded = "";
      $scope.newBlogPostHub.tags = [];
      $scope.newBlogPostHub.tag = "";
      recentlyCreatedBlogPostIds = recentlyCreatedBlogPostIds.push( result.id );
    })
    .finally(function(){
      $scope.newBlogPostHub.postingNewBlogPost = false;
      FSCModalService.loading = false;
    });
  };

  var urlify = function( text ){
    var urlRegex = />{2}/g;
  };

	// --------------------
	// Public
	// --------------------

  $scope.blogPosts = blogPosts;
	// This is a function.
  $scope.signedIn = Auth.isAuthenticated;
  $scope.addBlogPostsFormVisible = false;
  $scope.youTubePlayerVariables = { controls: 0, frameborder: 0, showinfo: 0, rel: 0 
  };

  $scope.newBlogPostHub = {
    attachments: [],
  	description: "",
  	imageUrl: "",
    tag: "",
    tags: [],
  	title: "",
  	youtubeUrl: "",
  	dateAdded: $filter('date')(new Date(), 'EEE dd MMMM yyyy'),
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

  DatetimeService.initiateDatePicker("#date-picker");

  $scope.deleteBlogPost = function(post){
    $ngConfirm({
      title: 'Sure you wanna blaze this shit?',
      content: '',
      scope: $scope,
      buttons: {
        delete: {
          text: 'Delete',
          btnClass: 'btn-primary',
          action: function(scope){
            post.remove().then(function(){
              var index = scope.blogPosts.indexOf(post);
              if (index > -1) scope.blogPosts.splice(index, 1);
            });
          }
        },
        close: function(scope, button){
          text: 'Cancel'
          // close the modal
        }
      }
    })
  };

  $scope.getBlogPosts = function(){
    if ( !searching ){
      searching = true;
      var params = {
        "page": page,
        "tag": selectedTag,
        "ids_to_exclude[]": recentlyCreatedBlogPostIds
      };
      Restangular.all( 'blog_posts' ).getList( params )
        .then(function( blogPosts ){
          if ( blogPosts.length ){
            $scope.blogPosts = $scope.blogPosts.concat( blogPosts );
            searching = false;
            page += 1;
          };
        });
    };
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

  $scope.setTagAndGetBlogPosts = function( tag ){
    recentlyCreatedBlogPostIds = [];
    selectedTag = tag;
    page = 1;
    $scope.blogPosts = [];
    searching = false;
    $scope.getBlogPosts();
  };

  $scope.slideToggleAddBlogPostForm = function(){
    $( "#add-blog-post-form" ).slideToggle( "slow" );
  };

  $scope.uploadFileThenCreatePost = function( form ){
    if ( !form.$valid ) {
      $("#new-post-form").addClass("was-validated");
      return;
    };

    if ( !$scope.newBlogPostHub.postingNewBlogPost ){
      FSCModalService.showLoading();
      $scope.newBlogPostHub.postingNewBlogPost = true;

      if ( $scope.file ){
        BackEndService.getPresignedUrl( { filename: $scope.file.name, type: $scope.file.type } )
          .then(function( response ){
            var publicUrl = response.public_url;
            var awsKey = response.aws_key;
            $http.put( response.presigned_url, $scope.file, { headers: { 'Content-Type': $scope.file.type } } )
              .then(function( response ){
                $scope.newBlogPostHub.attachments.push( { url: publicUrl, aws_key: awsKey } );
                createPost();
              }, function(errors){
                AlertService.processErrors( errors );
              });
          }, function( errors ){
            AlertService.processErrors( errors );
          });
      } else {
        createPost();
      };
    };
  };

}])