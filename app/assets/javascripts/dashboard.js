function updateDashboard() {  
    $.getScript('/dashboard.js');  
    setTimeout(updateDashboard, 10000);  
}  

$(document).ready(function(){

    setTimeout(updateDashboard, 10000);

});

