// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// require jquery3
// require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks


$(document).ready(function() {
    $('[data-js-like-link]').click(function(event){

        var track_id = $(this).attr('data-js-id');
        var liked_by_me = $(this).attr('data-js-liked-by-me');
        
        //var verb = (liked_by_me && liked_by_me == 'true' ? "unlike" : "like");
        var verb = "";
        if (liked_by_me == 'true') {
            verb = "unlike"
        }
        if (liked_by_me == 'false') {
            verb = "like"
        }
        $.ajax({
            method: 'put',
            url: verb + '/' + track_id,
            success: function(result){
                var $a = $('[data-js-id="' + track_id + '"]');            
                if (liked_by_me === 'false') {
                    $a.attr('data-js-liked-by-me', 'true')
                    $a.html("<i class='fa fa-heart icon' style='color:red;'></i> &nbsp; " + result.count);
                }
                else {
                    $a.attr('data-js-liked-by-me', 'false');
                    $a.html("<i class='fa fa-heart icon'></i> &nbsp; " + result.count);
                }
            }
        });

        
        event.preventDefault(); 
    });
});

// from : https://stackoverflow.com/questions/35678761/how-to-update-data-attribute-on-ajax-complete
function updateLikeLink(id, liked, likeCount) {
    var clickedA = event.currentTarget,
        newAttrValue = $(clickedA).attr('data-request-data').replace("active:'0'", "active:'1'");

    $(clickedA).attr('data-request-data', newAttrValue);
}



/* yet a new plan

So this tangled mess is yet again not working perfectly...

start over, clear out all existing js/coffeescript
clear out link helpers

start slow...
add button w/ proper classs definition
add a click event listener with jquery (remember event.prevetn default?)
https://www.engineyard.com/blog/using-jquery-with-rails-how-to
X have it just throw an alert
X then have it include the track ID in the alert

X then have it make an ajax call (google examples of this) (to make hte update)
[IN PROGRESS - UPDATING ELEMENT on ajax success ] : then have it be able to make an unlike OR like call
X then have it process the response (alert)
then have it update the element(s) based on the response

*/