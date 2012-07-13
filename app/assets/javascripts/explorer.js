
(function ($) {
var NULL_MAPPING_URL = 'http://4.bp.blogspot.com/_CBk-5X4QQvQ/TH-kNuQ8GpI/AAAAAAAAB7U/BzXdt6teQe8/s1600/Cat-fixes-your-computer.jpg';
var NO_MAPPINGS_URL = 'http://4.bp.blogspot.com/_CBk-5X4QQvQ/TH-kNuQ8GpI/AAAAAAAAB7U/BzXdt6teQe8/s1600/Cat-fixes-your-computer.jpg';

var curUrl;
var offDomainWarning = "You've now navigated off the chosen domain. No updates will occur to the right-hand panel.";
var shownOffDomainWarning = false;


var windowLocation = window.location;

function updateNewUrl() {
    $.getJSON('/__/explore.json', windowLocation.search).then(function(data) {
        var m;
        if (typeof data.mappings !== 'undefined' && data.mappings.length > 0) {
            m = data.mappings[0].mapping.new_url;
        } else {
            m = NO_MAPPINGS_URL;
        }
        if (m == null) {
            m = NULL_MAPPING_URL;
        }
        $('#new').attr('src', m);
    });
}

function updateOldUrl() {
    path = windowLocation.search.replace('?old_url=http://www.direct.gov.uk', "");
    $('#old').attr('src', windowLocation.origin + path);
}

function updateUrl() {
    url = windowLocation.search.replace(/\?old_url=/,"");

    console.log(url);
    console.log('hello');
    //if (url === 'blank') { return; }
    //if (url === curUrl) { return; }
    //curUrl = url;

    //if (typeof url === 'undefined') {
    //if (shownOffDomainWarning) { return; }

    //if (confirm(offDomainWarning)) {
    //  location.href = '/__';
    //} else {
    //  shownOffDomainWarning = true;
    //}
    //} else {
    //    //updateFrame(url);
    //    //history.pushState({}, "", '/__/explore?old_url=' + url);      
    //}
    //$('#old').attr('src', "/en/index.html");
}

function updateOldIframe() {
}

function init() {
    //var windowLocation = window.location.pathname.replace(/^\/__/, "");
    //windowLocation = '/en/Parents/Preschooldevelopmentandlearning/index.htm';
    //var old_mapping = $('#old').attr('src', windowLocation  || '/');
    //updateTimer = setInterval(updateUrl, 500);

    updateOldUrl();
    updateNewUrl();
}

$(init);
}(jQuery));

