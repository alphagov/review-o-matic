function updateDashboard() {
    $.getScript('/dashboard/missing_mappings.js');
    setTimeout(updateDashboard, 10000);
}

$(document).ready(function(){
  updateDashboard();
});
