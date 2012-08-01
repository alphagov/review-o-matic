function updateDashboard() {
    $('.missing_mappings_table').empty();
    $.getJSON('/__/dashboard/missing_mappings.json', function(data){
    	$(data).each( function() {
    		var link = this['old_url'];
    		$('.missing_mappings_table').append('<tr><td><a href=" ' + link + ' " target="_blank">' + link.substring(0,100) + '</a></td></tr>');
    	})
    })
    setTimeout(updateDashboard, 10000);
}

$(document).ready(function(){
  updateDashboard();
});
