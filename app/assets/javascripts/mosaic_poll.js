function updateMosaic() {  
    $.getScript('/dashboard/mosaic.js');  
    setTimeout(updateMosaic, 10000);  
}  

$(document).ready(function(){
    setTimeout(updateMosaic, 10000);
});

