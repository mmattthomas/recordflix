# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movie_list = [
    "A FANTASTIC WOMAN",
    "ALL I SEE IS YOU",
    "AMERICAN MADE",
    "BABY DRIVER",
    "BATTLE OF THE SEXES",
    "BEATRIZ AT DINNER",
    "BEAUTY AND THE BEAST",
    "BREATHE",
    "CALL ME BY YOUR NAME",
    "CROWN HEIGHTS",
    "DARKEST HOUR",
    "DETROIT",
    "ELIZABETH BLUE",
    "FILM STARS DON’T DIE IN LIVERPOOL",
    "GET OUT",
    "GIFTED",
    "GIRLS TRIP",
    "GUARDIANS OF THE GALAXY 2",
    "I, TONYA ",
    "IN THE FADE",
    "IT",
    "LADY BIRD",
    "LAST FLAG FLYING",
    "LOGAN",
    "MARJORIE PRIME",
    "MARK FELT",
    "MARSHALL",
    "MAUDIE",
    "MOLLY’S GAME",
    "MOTHER!",
    "MUDBOUND",
    "NORMAN",
    "NOVITIATE",
    "SPLIT",
    "STRONGER",
    "THE BIG SICK",
    "THE DINNER",
    "THE DISASTER ARTIST",
    "THE FLORIDA PROJECT",
    "THE HERO",
    "THE LEISURE SEEKER",
    "THE MAN WHO INVENTED CHRISTMAS",
    "THE MEYEROWITZ STORIES",
    "THE SHAPE OF WATER",
    "THREE BILLBOARDS OUTSIDE EBBING, MISSOURI",
    "VICTORIA AND ABDUL",
    "WAR FOR THE PLANET OF THE APES",
    "WIND RIVER",
    "WONDERSTRUCK",
    "WONDER WHEEL",
    "WONDER WOMAN"
  ]

  
Team.create( name: "MyFlix", short_name: "MF!", checkout_limit: 3)
t = Team.first

movie_list.each do |name|
    title = name.titleize
    description = "Someone should probably write a description for <u>" + title + "</u>."
    url = "http://www.imdb.com/find?ref_=nv_sr_fn&q=" + title.downcase
    Movie.create( title: title, description: description, rating: 0, runtime: 120, released: "2017-01-01", url: url, team_id: t.id )
end
