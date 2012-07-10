function updateMosaic() {
    $.getScript('/dashboard/mosaic.js');
    setTimeout(updateMosaic, 30000);
}

$(document).ready(function(){

    var sections = [];
    var i 
      , sectionContainer
      , unreviewedCount
      , reviewedCount;

    updateMosaic();
});

