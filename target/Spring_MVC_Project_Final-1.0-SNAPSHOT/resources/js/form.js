$().ready(function() {
	$("#demoForm").validate({
		onfocusout: false,
		onkeyup: false,
		onclick: false,
		rules: {
			"fullName": {
				required: true,
				minlength: 6
			},
			"password": {
				required: true,
				minlength: 6
			},
			"re-password": {
				equalTo: "#password",
				minlength: 6
			},
                        "email": {
//                                email: true,
				required: true,
				minlength: 6
			},
                        "phoneNumber": {
				required: true,
				minlength: 6
			},
                        "address": {
				required: true,
				minlength: 6
			},
                        "birthDate": {
				required: true,
				minlength: 6
			},
		}
	});
});