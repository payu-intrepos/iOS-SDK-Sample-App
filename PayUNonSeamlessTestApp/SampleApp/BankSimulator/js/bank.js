(function(window, document, $){
	var tabs = {
		$panels:$(".panel"),
		$triggers:$('.tabs li a'),
		init:function(){
			tabs.$triggers.on('click', tabs.toggle);
		},
		toggle:function(){
			var $ele = $(this);
			var $panel = $($ele.attr('data-target'));
			tabs.$triggers.removeClass('active');
			tabs.$panels.hide();
			$panel.find('input')[0].value="";
			$panel.show();
			$ele.addClass('active');
		}
	};
	
	tabs.init();
	
	var form = {
		$ipinSubmit:$("#SubmitIpinForm"),
		$otpSubmit:$("#SubmitOtpForm"),
		init:function(){
			this.$ipinSubmit.on('click', form.submit);
			this.$otpSubmit.on('click', form.submit);
		},
		submit:function(){
			var $form = form.current();
			var $input = $form.find('input');
			var errorStr = "Enter " + ($form[0].id == "IpinPanel"?"PIN":"OTP");
			if(form.check($input)){
				form.submitFinal();
			}
			else{
				alert(errorStr);
			}
			return false;
		},
		submitFinal:function(){
			$form = $("#ResponseForm");
			//$form.find('#authDecision').val('success');
			console.log("hello");
			PayU.onPayuSuccess('{"status":"success","data":"test"}');
			$form.submit();
		},
		check:function($input){
			var val = $input.val();
			
			if(val == '') return false;
			
			return true;
		},
		current:function(){
			$ipin = $("#IpinPanel");
			$otp = $("#OtpPanel");
			
			if($ipin.is(':visible')) return $ipin;
			
			return $otp;
		}
	};
	
	form.init();
	
	
})(window, document, jQuery);