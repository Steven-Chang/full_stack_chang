import "@hotwired/turbo-rails";
import "./src/jquery";
import "./src/bootstrap";
import "./src/dropzone";

// === VELZON ===
import "../../lib/assets/js/layout";
import "../../lib/assets/libs/flatpickr/flatpickr.min";
import "../../lib/assets/js/app";

// === CUSTOM ===
import { TRANSACTIONS_NEW } from "./tranxactions/new";

// === GLOBAL LISTENERS ===
$(document).on("turbo:load", function () {
  if ($("#transactions-new").length) {
    TRANSACTIONS_NEW.init();
  }
});
