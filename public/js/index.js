$(document).ready(function(){
	$('#js_message_form').submit(function(ev){
		ev.preventDefault();
		var form = $(ev.target);
		var message = form.find('#js_message');
		var password = form.find('#js_password');

		message.val(CryptoJS.AES.encrypt(message.val(), password.val()).toString())
		password.val('');

		$.ajax({
			type: 'post',
			url: form.attr('url'),
			data: form.serialize(),
			success: function(result) {
				$('#result').append($('<a>').attr('href', '/'+result.url).text('Link to message'));
			}
		});
		return false;
	});



	$('#encode_message').submit(function(ev) {
		ev.preventDefault();

		var form = $(ev.target);
		var message = form.find('#js_message');
		var password = form.find('#js_password');
		message.val(CryptoJS.AES.decrypt(message.val(),password.val()).toString(CryptoJS.enc.Utf8));

		return false;
	});
});
