(function($) {
	"use strict";

/* ----------------------------
    Preloader
    ------------------------------ */

$(window).on('load', function(){        
	$('#preloader').delay(300).fadeOut('slow',function(){
	$(this).remove();
	});
});

/* ----------------------------
    jQuery sticky area
    ------------------------------ */
	
$('.header-lover').sticky({
	topSpacing: 0,
});

/* ----------------------------
    Top Scroll
    ------------------------------ */

var offset = 220;
var duration = 500;
jQuery(window).on('scroll', function() {
	if (jQuery(this).scrollTop() > offset) {
		jQuery('.scroll-top').fadeIn(duration);
	} 
	else {
		jQuery('.scroll-top').fadeOut(duration);
	}
});
jQuery('.scroll-top').on('click', function() {
	event.preventDefault();
	jQuery('html, body').animate({scrollTop: 0}, duration);
	return false;
})

/* ----------------------------
	@module       Copyright
	@description  Evaluates the copyright year
    ------------------------------ */
	
var currentYear = (new Date).getFullYear();
	$(document).ready(function () {
		$(".current-year").text((new Date).getFullYear());
});

/* ----------------------------
    Counter Up
    ------------------------------ */
	
$('.counter').counterUp({
	delay: 10,
	time: 2000
});

/* ----------------------------
    venobox
    ------------------------------ */

$('.venobox').venobox();

/* ----------------------------
    testimonial owlcursol
    ------------------------------ */

$('.testimonial-owlcursol').owlCarousel({
	loop: true,
	margin: 15,
	nav: true,
	items: 3,
	autoplay:true,
	navText: ["<i class='fas fa-long-arrow-alt-left'></i>", "<i class='fas fa-long-arrow-alt-right'></i>"],
	dots: false,
	responsiveClass: true,
	responsive: {
	  0: {
		items: 1
	  },
	  767: {
		items: 1
	  },
	  768: {
		items: 2
	  },
	  1000: {
		items: 3
	  }
	}
})

})(jQuery);