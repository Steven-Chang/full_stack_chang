// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// WOULD USE WITHOUT REMARK THEME
require("bootstrap/dist/js/bootstrap")

// REMARK THEME
// Core
require("animsition/dist/js/animsition.min")
require("remark_classic/global/vendor/babel-external-helpers/babel-external-helpers")
require("jquery-mousewheel/jquery.mousewheel")
require("jquery-asScrollbar/dist/jquery-asScrollbar.min")
require("jquery-asScrollable/dist/jquery-asScrollable.min")

// Plugins
require("switchery/switchery")
require("intro.js/minified/introjs.min")
require("jquery-slidePanel/dist/jquery-slidePanel.min")
require("jquery-placeholder/jquery.placeholder")
require("remark_classic/global/js/Plugin/responsive-tabs")
require("screenfull/dist/screenfull")
require("remark_classic/global/js/Plugin/tabs")

// Scripts
require("remark_classic/global/vendor/breakpoints/breakpoints.min")
Breakpoints()
require("remark_classic/global/js/Component")
require("remark_classic/global/js/Plugin")
require("remark_classic/global/js/Base")
require("remark_classic/global/js/Config").set('assets', 'remark_classic/topbar/assets')
require("remark_classic/topbar/assets/js/Section/Menubar")
require("remark_classic/topbar/assets/js/Section/Sidebar")
require("remark_classic/topbar/assets/js/Section/PageAside")
require("remark_classic/topbar/assets/js/Plugin/menu")

// Config
require("remark_classic/global/js/config/colors")
require("remark_classic/topbar/assets/js/config/tour")

// Page
require("remark_classic/global/js/Plugin/asscrollable")
require("remark_classic/global/js/Plugin/slidepanel")
require("remark_classic/global/js/Plugin/switchery")
require("remark_classic/global/js/Plugin/jquery-placeholder")
require("remark_classic/global/js/Plugin/material")
$(document).ready(function(){
  require("remark_classic/topbar/assets/js/Site").run();
});


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)