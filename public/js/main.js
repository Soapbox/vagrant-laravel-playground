(function (window, $) {
	"use strict";

	$(window).on('load', function () {
		$('#thanks-btn').click(function () {
			$('#youre-welcome-modal').modal('show');
		});
	});

})(window, jQuery);
