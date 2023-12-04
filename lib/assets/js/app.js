$(document).on("turbo:load", function () {
	$(".navbar-header .light-dark-mode").on("click", function() {
		let theme;
		if ($("html").attr("data-bs-theme") == "light") {
			theme = "dark"
		} else {
			theme = "light"
		}
		sessionStorage.setItem("data-bs-theme", theme)
		$("html").attr("data-bs-theme", theme)
	});

	// FLATPICKR DATE PICKER
	(z = document.querySelectorAll("[data-provider]")),
        Array.from(z).forEach(function (e) {
            var t, a, n;
            "flatpickr" == e.getAttribute("data-provider")
                ? ((n = e.attributes),
                  ((t = {}).disableMobile = "true"),
                  n["data-date-format"] && (t.dateFormat = n["data-date-format"].value.toString()),
                  n["data-enable-time"] && ((t.enableTime = !0), (t.dateFormat = n["data-date-format"].value.toString() + " H:i")),
                  n["data-altFormat"] && ((t.altInput = !0), (t.altFormat = n["data-altFormat"].value.toString())),
                  n["data-minDate"] && ((t.minDate = n["data-minDate"].value.toString()), (t.dateFormat = n["data-date-format"].value.toString())),
                  n["data-maxDate"] && ((t.maxDate = n["data-maxDate"].value.toString()), (t.dateFormat = n["data-date-format"].value.toString())),
                  n["data-deafult-date"] && ((t.defaultDate = n["data-deafult-date"].value.toString()), (t.dateFormat = n["data-date-format"].value.toString())),
                  n["data-multiple-date"] && ((t.mode = "multiple"), (t.dateFormat = n["data-date-format"].value.toString())),
                  n["data-range-date"] && ((t.mode = "range"), (t.dateFormat = n["data-date-format"].value.toString())),
                  n["data-inline-date"] && ((t.inline = !0), (t.defaultDate = n["data-deafult-date"].value.toString()), (t.dateFormat = n["data-date-format"].value.toString())),
                  n["data-disable-date"] && ((a = []).push(n["data-disable-date"].value), (t.disable = a.toString().split(","))),
                  n["data-week-number"] && ((a = []).push(n["data-week-number"].value), (t.weekNumbers = !0)),
                  flatpickr(e, t))
                : "timepickr" == e.getAttribute("data-provider") &&
                  ((a = {}),
                  (n = e.attributes)["data-time-basic"] && ((a.enableTime = !0), (a.noCalendar = !0), (a.dateFormat = "H:i")),
                  n["data-time-hrs"] && ((a.enableTime = !0), (a.noCalendar = !0), (a.dateFormat = "H:i"), (a.time_24hr = !0)),
                  n["data-min-time"] && ((a.enableTime = !0), (a.noCalendar = !0), (a.dateFormat = "H:i"), (a.minTime = n["data-min-time"].value.toString())),
                  n["data-max-time"] && ((a.enableTime = !0), (a.noCalendar = !0), (a.dateFormat = "H:i"), (a.minTime = n["data-max-time"].value.toString())),
                  n["data-default-time"] && ((a.enableTime = !0), (a.noCalendar = !0), (a.dateFormat = "H:i"), (a.defaultDate = n["data-default-time"].value.toString())),
                  n["data-time-inline"] && ((a.enableTime = !0), (a.noCalendar = !0), (a.defaultDate = n["data-time-inline"].value.toString()), (a.inline = !0)),
                  flatpickr(e, a));
        })
});
