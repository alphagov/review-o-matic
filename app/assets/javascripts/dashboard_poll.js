function updateDashboard() {
    $.getScript('/dashboard.js');
    setTimeout(updateDashboard, 10000);
}

$(document).ready(function(){
  updateDashboard();
});

