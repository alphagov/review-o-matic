$(document).ready(function(){

    $(function (){
        var colors = new Hex(0xFF0000).range(new Hex(0x00FF00), 101, true);
        $(".mosaic_container > span").each(function(index){
            $(this).css({
            'background-color' : '#'+colors[parseInt($(this).text())].toString()
            });
            $(this).html('');
        });
    });


});

