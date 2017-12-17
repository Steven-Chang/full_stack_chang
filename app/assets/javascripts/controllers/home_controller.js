app.controller('HomeController', ['$filter', '$ngConfirm', '$scope', '$timeout', 'Auth', 'blogPosts', 'cloudinary', 'Restangular', function( $filter, $ngConfirm, $scope, $timeout, Auth, blogPosts, cloudinary, Restangular){

	// --------------------
	// Private
	// --------------------
  var page = 2;
  var recentlyCreatedBlogPostIds = [];
  var searching = false;
  var selectedTag;

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
          $scope.blogPosts.unshift(result);
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

  $timeout(function(){
    $('#date-picker').datepicker({
      format: "dd/mm/yyyy"
    });
  }, 100);

  $scope.slideToggleAddBlogPostForm = function(){
    $( "#add-blog-post-form" ).slideToggle( "slow" );
  };

  $scope.files = {};
  $scope.uploadedFiles = [];

  $scope.widget = $(".cloudinary_fileupload")
    .unsigned_cloudinary_upload(cloudinary.config().upload_preset, {}, {
      // Uncomment the following lines to enable client side image resizing and validation.
      // Make sure cloudinary/processing is included the js file
      //disableImageResize: false,
      //imageMaxWidth: 800,
      //imageMaxHeight: 600,
      //acceptFileTypes: /(\.|\/)(gif|jpe?g|png|bmp|ico)$/i,
      maxFileSize: 2000000, // 2MB
      dropZone: "#direct_upload_jquery",
      start: function (e) {
        $scope.files = {};
      },
      fail: function (e, data) {
        // $scope.status = "Upload failed";
        // $scope.$apply();
        /* 
        if (data.files){
          var name = data.files[0].name;

          if ( !$scope.files[name] ) {
            $scope.files[name] = data.files[0];
          };

          $scope.files[name].status = "Upload failed";
          $scope.files[name].statusType = "fail";
          $scope.$apply();
        };
        */
      }
    })
    .on("cloudinaryprogress", function (e, data) {
      /*
        var name = data.files[0].name;
        var file = $scope.files[name] || {};
        file.progress = Math.round((data.loaded * 100.0) / data.total);
        file.status = "Uploading... " + file.progress + "%";
        $scope.files[name] = file;
        $scope.$apply();
      */
    })
    .on("cloudinaryprogressall", function (e, data) {
      // $scope.progress = Math.round((data.loaded * 100.0) / data.total);
      // $scope.status = "Uploading... " + $scope.progress + "%";
      // $scope.$apply();
    })
    .on("cloudinarydone", function (e, data) {
      // $rootScope.photos = $rootScope.photos || [];
      // data.result.context = {custom: {photo: $scope.title}};
      // $scope.result = data.result;
      // var name = data.files[0].name;
      // var file = $scope.files[name] ||{};
      // file.name = name;
      // file.result = data.result;
      // $scope.files[name] = file;
      // $rootScope.photos.push(data.result);
      /*
      $scope.files = _.omit( $scope.files, [data.result.original_filename + "." + data.result.format]);
      */
      $scope.newBlogPostHub.imageUrl = data.result.secure_url
      $scope.$apply();
    }).on("cloudinaryfail", function(e, data){
        // var file = $scope.files[name] ||{};
        // file.name = name;
        // file.result = data.result;
        // $scope.files[name] = file;
      });

}])