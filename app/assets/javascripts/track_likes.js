$(document).ready(function() {
    $(".newvote").click(function() {
        var track_id = $(this).attr('id');
        //alert("newvote clicked");
        $.ajax({
        type: "PUT",
        url: 'like/' + track_id,
        success: function() {

            // change image or something
            $(this).html = "<i class='fa fa-heart icon redheart'></i>";
            
        }
        })
    })
});