$(document).ready(function(){



$('#image_id1').click(function(){
		

		$("ul:nth-child(1)").animate({width: '60px'}, "slow");
		// $(".container").style.marginLeft = "10px";
		$("ul:nth-child(1) li:nth-child(2)").hide();
		$("ul:nth-child(1) li:nth-child(3)").hide();
		$("ul:nth-child(1) li:nth-child(4)").hide();
		$("ul:nth-child(1) li:nth-child(5)").hide();
		$("ul:nth-child(1) li:nth-child(6)").hide();
		$("ul:nth-child(1) li:nth-child(7)").hide();
		$('#image_id1').hide();
		$('#image_id2').show();


	});

$('#image_id2').click(function(){
		
		console.log('test');
		$("ul:nth-child(1)").animate({width: '150px'}, "slow");
		$("ul:nth-child(1) li:nth-child(2)").show();
		$("ul:nth-child(1) li:nth-child(3)").show();
		$("ul:nth-child(1) li:nth-child(4)").show();
		$("ul:nth-child(1) li:nth-child(5)").show();
		$("ul:nth-child(1) li:nth-child(6)").show();
		$("ul:nth-child(1) li:nth-child(7)").show();
		$('#image_id2').hide();
		$('#image_id1').show();


	});




});

