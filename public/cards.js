$(document).ready(function() {

	$('.card').find('.hidden').hide();
	$('.card').find('.delete').hide();

	$('.card').on('mouseover', function() {
			$(this).find('.delete').show();
			$(this).find('.hidden').show();
			$(this).find('.visible').hide();
	});

	$('.card').on('mouseleave', function() {
			$(this).find('.delete').hide();
			$(this).find('.visible').show();
			$(this).find('.hidden').hide();
	});

});