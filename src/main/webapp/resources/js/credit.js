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
			"cvcCode": {
				required: true,
                                digits: true,
				minlength: 3
			},
			"cardNumber": {
				required: true,
                                digits: true,
				minlength: 6
			},
                        "monthExp": {
				required: true,
			},
                        "yearExp": {
				required: true,
			},
                        "name": {
				required: true,
				minlength: 6
			},
                        
		}
	});
});
