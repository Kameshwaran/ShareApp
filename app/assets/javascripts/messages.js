$(document).ready(function(){
 var client = new Faye.Client('http://localhost:9292/faye');
 var subscription = client.subscribe('/messages/all', function(message) { 
 		receiver_id = "t-user"+message.sender_id;
 		$("div#"+receiver_id).append("<p style='text-align:left'>"+message.content+"</p>");
	});
user_id = $("#my-id").val();
$(".name-list").on("click",function(){
	tab_name = $(this).html();
	tab_id = $(this).attr("id");
	avail = false;
	if($(".nav-tabs").children().length == 0)
		avail = false;
	else {
		$(".name").each(function(){
			if ($(this).html() == tab_name)
			avail = true;
		});
	}
	if(avail == false){
	$(".nav-tabs").append("<li><a href=#t-"+tab_id+" class='name' >"+tab_name+"</a></li>");
	$(".tab-content").append("<div class='tab-pane' id =t-"+tab_id+"></div>");
	console.log("sender_id");
	$.post("/users/"+user_id+"/messages/display",{id: tab_id.split("r")[1] },function(data){
		for(var i=0;i<data.length;i++){
		if(data[i].sender_id == user_id ){
		$("div.active").append("<p style='text-align:left'>"+data[i].content+"</p>")
		}
		else{
		$("div.active").append("<p style='text-align:right'>"+data[i].content+"</p>")
		}
		}
		},"JSON");
	$("a[href=#t-"+tab_id+"]").tab('show');
	}
	else
	$("a[href=#t-"+tab_id+"]").tab('show');
});
$("#type-box").keypress(function(event){
	if(event.keyCode == 13){
		data = $("#type-box").val();
		$("#type-box").val("");
		tab_id = $($(".active").children()).attr("href").split("r")[1];
		window.receiver_id = tab_id;
		window.data = data;
		$.post("/users/"+user_id+"/messages/",{receiver_id: tab_id , content: data },function(data){
		$("#t-user"+window.receiver_id).append("<p>"+window.data+"</p>");
		client.publish('/messages/all', data);
		},"JSON");
	}
});
});