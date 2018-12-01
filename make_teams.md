# How to 'franchise' this project for use for others?

1. [X] Create TEAM table
    - [X] Team name
    - [X] invite code ... special code to send to invitees
    - [ ] some label stuff, tbdd
    - [ ] Team Name, Team Appreviation (Kentflix, KF)
1. [X] Add TEAM link to user table
1. [X] Modify Registration view+controller, Create logic:
    - [X] add team name field (attribute)
    - [ ] enforce team name populated
    - [X] in CREATE method, Lookup team name:            
        - If does not exist
            - [X] create team record, associate user to it, set user.admin = true
        - If existing team found:
            - [X] if so, create user, associate it to team record
1. [X] Make use of team name everywhere
    - [X] set navigation window to show team name
    - [ ] bonus, set all routes to be kentflix.com/teamname
1. [X] Add TEAM link to Movies table
1. [X] On create of movie, team is set to current_user.team
1. [X] Add scope for movie model to only show movies for current team



_Note, we're still "Movies", but in the future this could be anything needing check-in/check-out feature._

Future:
- Send invites out to people (is there a gem for this)
- https://github.com/scambra/devise_invitable
