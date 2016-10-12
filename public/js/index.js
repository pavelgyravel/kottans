$(document).ready(function(){
	$('#js_message_form').submit(function(ev){
		var form = $(ev.target);
		var message = form.find('#js_message');
		var password = form.find('#js_password');

		message.val(CryptoJS.AES.encrypt(message.val(), password.val()).toString())
		password.val('');
		return true;
	});

	
});
