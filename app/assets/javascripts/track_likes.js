// $(document).ready(function() {
//     $(".newvote").click(function() {
//         var track_id = $(this).attr('id');
//         //alert("newvote clicked");
//         $.ajax({
//         type: "PUT",
//         url: 'like/' + track_id,
//         success: function() {

//             // change image or something
//             $(this).html = "<i class='fa fa-heart icon redheart'></i>";
            
//         }
//         })
//     })
// });

/* yet a new plan

So this tangled mess is yet again not working perfectly...

start over, clear out all existing js/coffeescript
clear out link helpers

start slow...
add button w/ proper classs definition
add a click event listener with jquery (remember event.prevetn default?)
https://www.engineyard.com/blog/using-jquery-with-rails-how-to
have it just throw an alert
then have it include the track ID in the alert
then have it make an ajax call (google examples of this) (to make hte update)
then have it be able to make an unlike OR like call
then have it process the response (alert)
then have it update the element(s) based on the response

*/