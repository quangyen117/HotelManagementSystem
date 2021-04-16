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
			"nowpassword": {
				required: true,
				minlength: 6
			},
			
                        "newpassword": {
				required: true,
				minlength: 6
			},
                        "re-newpassword": {
                                required: true,
				equalTo: "#newpassword",
				minlength: 6
			},
		}
	});
});