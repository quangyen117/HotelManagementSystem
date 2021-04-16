/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


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
                        "idCard":{
				required: true,
				minlength: 6
                         },
		}
	});
});