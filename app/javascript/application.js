// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails



//import "@hotwired/turbo-rails"
import "controllers"



//Pikwik
var pikwik = function() {
   var pkBaseURL = (("https:" == document.location.protocol) ? "https://statsbox.info/" : "http://statsbox.info/");

    document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));

    try {
       var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 25);
       piwikTracker.trackPageView();
       piwikTracker.enableLinkTracking();
    } catch( err ) {}
};
$(document).on("page:load ready", pikwik);


