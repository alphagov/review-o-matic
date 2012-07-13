(function ($) {
    var NULL_MAPPING_URL = 'http://4.bp.blogspot.com/_CBk-5X4QQvQ/TH-kNuQ8GpI/AAAAAAAAB7U/BzXdt6teQe8/s1600/Cat-fixes-your-computer.jpg';
    var NO_MAPPINGS_URL = 'http://4.bp.blogspot.com/_CBk-5X4QQvQ/TH-kNuQ8GpI/AAAAAAAAB7U/BzXdt6teQe8/s1600/Cat-fixes-your-computer.jpg';

    var curUrl;
    var offDomainWarning = "You've now navigated off the chosen domain. No updates will occur to the right-hand panel.";
    var shownOffDomainWarning = false;

    function updateFrame(url) {
      $.getJSON('/__/explore.json?', {old_url: url})
        .then(function (data) {
          var m;
          console.log(data);
          if (data.new_url !== 'undefined') {
            m = data.new_url;
          } else {
            m = NO_MAPPINGS_URL;
          }
          if (m == null) {
            m = NULL_MAPPING_URL;
          }
          $('#new').attr('src', m);
        });
    }

    function updateUrl() {
      url = $('#old')[0].contentWindow.location.pathname;
      
      if (url === 'blank') { return; }
      if (url === curUrl) { return; }
      curUrl = url;

      if (typeof url === 'undefined') {
        if (shownOffDomainWarning) { return; }

        if (confirm(offDomainWarning)) {
          location.href = '/__browser__';
        } else {
          shownOffDomainWarning = true;
        }
      } else {
        updateFrame(url);
        console.log(url);
        history.pushState({}, "", '/__/explore?old_url=http://www.direct.gov.uk' + url);      
      }
    }

    function init() {
        path = window.location.search.replace('?old_url=http://www.direct.gov.uk', "");
        console.log(path);
        $('#old').attr('src', window.location.origin + path);
        updateTimer = setInterval(updateUrl, 500);
    }

    $(init);
}(jQuery));