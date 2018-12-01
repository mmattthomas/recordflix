# RecordPool

At the moment, this is a clone of Kentflix in order to make a music social media app... it has a lot of the same elements and I want to just get it off the ground quickly, so cloning kentflix and planning to do the following:

 - [x] Copy directory
 - [X] Rename basics - title, logo etc.     
 - [X] Rename databases/module names
 - [ ] Redo keys (secrets.yml)?
 - [X] db create/migrate
 - [X] Test... OK!
 - [X] create TRACK scaffold - much like Movies
 - [X] set routes to post by default
 - [X] connect tracks to users
 - [X] get general Listing/feed of tracks
 - [X] get oEmbedd connected - first try youtube
 - [X] set post new track on listing form, simplify, pull in data from oEmbed
 - [X] add likes
 - [X] style likes
 - [ ] 
 - [ ] connect comments to posts
 - [ ] style listing page better for likes/comments/date/posted-by information ... card format
 - [ ] better front page
 - [ ] V1 ... add to github, add to herokku
 - [X] get mail working (sendgrid api) for account setup with devise, etc.
 - [ ] twilio integration - inbound text messages to add.
 - [ ] better styling
 - [ ] view/sort/filter list of tracks
 - [ ] tagging
 


 Notes:
 instead of posts - new object called "Track"
 to start, similar to post - hyperlink, who posted (posted_by)
 people can COMMENT + LIKE tracks - then see list of LIKED
 later: tagging


