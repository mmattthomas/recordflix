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