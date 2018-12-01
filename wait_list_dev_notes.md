Wait list logic:

Table wait_list (movie_id, user_id, created_at)

*Events:*
Movie LOAD:
Query checked-out status
Query Waitlist table:
 - build string list of who is waiting…
 - IF current_user is first on that list - set checkout status = AVAILABLE
 - IF you are on the list anywehre else, indicate that in message (bold yourself?)

CHECKOUT button:
 - query waitlist - if doesnt exist or you are NEXT - proceed, otherwise stop/err
 - delete any related waitlist record w/ current_user name on it
 - continue checkout process

ADD TO WAIT button:
 - create new waitlist record for item for current user

RETURN button:
 - **Query waitlist and notify next person in line


EXTRAS:
- add comment icon in movie list for movies w/ comments
- add waitlist icon for movies w/ waitlist