# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Competition.delete_all
User.delete_all
Game.delete_all
Team.delete_all
TeamMember.delete_all
Event.delete_all
EventParticipant.delete_all
Round.delete_all

competition2015 = Competition.create(name: '2015 Foosball Competition')
competition2014 = Competition.create(name: '2014 Foosball Competition', is_finished: true)

# teams
team1 = Team.create(name: 'Team1', competition: competition2015 ) 
team2 = Team.create(name: 'Team2', competition: competition2015 ) 
team3 = Team.create(name: 'Team3', competition: competition2015 ) 
team4 = Team.create(name: 'Team4', competition: competition2015 ) 
# team5 = Team.create(name: 'Team5', competition: competition2015 ) 
# team6 = Team.create(name: 'Team6', competition: competition2015 ) 
# team7 = Team.create(name: 'Team7', competition: competition2015 ) 
# team8 = Team.create(name: 'Team8', competition: competition2015 ) 

# team10 = Team.create(name: 'Team8', competition: competition2014 ) 
# team11 = Team.create(name: 'Team7', competition: competition2014 ) 
round4 = Round.create( name: 'Round4', competition: competition2015)
round5 = Round.create( name: 'Round5', competition: competition2015)
round6 = Round.create( name: 'Round6', competition: competition2015)
round7 = Round.create( name: 'Round7', competition: competition2015)
round1 = Round.create( name: 'Round1', competition: competition2015)
round2 = Round.create( name: 'Round2', competition: competition2015)
round3 = Round.create( name: 'Round3', competition: competition2015)
round8 = Round.create( name: 'Round8', competition: competition2015)


game1 = Game.create(round: round4, competition: competition2015, team_one: team1, team_two: team2, is_finished: false)
game2 = Game.create(round: round5, competition: competition2015, team_one: team3, team_two: team4, is_finished: false)
game3 = Game.create(round: round6, competition: competition2015, team_one: team2, team_two: team1, is_finished: false)
game4 = Game.create(round: round7, competition: competition2015, team_one: team4, team_two: team3, is_finished: false)
game5 = Game.create(round: round1, competition: competition2015, team_one: team1, team_two: team4, is_finished: true, team_one_score: 10, team_two_score: 2)
game6 = Game.create(round: round2, competition: competition2015, team_one: team3, team_two: team2, is_finished: true, team_one_score: 10, team_two_score: 2)
game7 = Game.create(round: round3, competition: competition2015, team_one: team1, team_two: team3, is_finished: true, team_one_score: 10, team_two_score: 2)
game8 = Game.create(round: round8, competition: competition2015, team_one: team2, team_two: team4, is_finished: true, team_one_score: 10, team_two_score: 2)



user1 = User.create(name: 'Figo', email: 'admin@socialclub.com', is_member: true, is_admin: true,  password: '12345' )
user2 = User.create(name: 'Alice', email: 'alice@socialclub.com', is_member: false, password: '12345' )
user3 = User.create(name: 'Bob', email: 'bob@socialclub.com', is_member: false, password: '12345' )
user4 = User.create(name: 'Yufei', email: 'yufei@socialclub.com', is_member: false, password: '12345' )
user5 = User.create(name: 'Kenny', email: 'kenny@socialclub.com', is_member: false, password: '12345' )
user6 = User.create(name: 'CT', email: 'ct@socialclub.com', is_member: false, password: '12345' )
user7 = User.create(name: 'Chee Jun', email: 'cj@socialclub.com', is_member: false, password: '12345' )
user8 = User.create(name: 'Sher Jun', email: 'sherjun@socialclub.com', is_member: false, password: '12345' )
user9 = User.create(name: 'Tim', email: 'tim@socialclub.com', is_member: false, password: '12345' )
user10 = User.create(name: 'PG', email: 'pg@socialclub.com', is_member: false, password: '12345' )
user11 = User.create(name: 'PS', email: 'ps@socialclub.com', is_member: false, password: '12345' )
user12 = User.create(name: 'Selin', email: 'selin@socialclub.com', is_member: false, password: '12345' )
user13 = User.create(name: 'Jemma', email: 'jemma@socialclub.com', is_member: false, password: '12345' )
user14 = User.create(name: 'Loris', email: 'loris@socialclub.com', is_member: false, password: '12345' )


TeamMember.create(team: team1, member: user1)
TeamMember.create(team: team1, member: user2)
TeamMember.create(team: team1, member: user3)
TeamMember.create(team: team1, member: user4)
TeamMember.create(team: team2, member: user5)
TeamMember.create(team: team2, member: user6)
TeamMember.create(team: team2, member: user7)
TeamMember.create(team: team2, member: user8)
TeamMember.create(team: team3, member: user9)
TeamMember.create(team: team3, member: user10)
TeamMember.create(team: team3, member: user11)
TeamMember.create(team: team3, member: user12)
TeamMember.create(team: team4, member: user13)
TeamMember.create(team: team4, member: user14)





# EVENT 

event1 = Event.create(name: 'SocialClub Lunch', non_member_fee: 27.5, member_only: true, time: 1.day.from_now, address: '417 St kilda Road, Melbourne', description: "you will be serve with Lobster...jo fai o aisjdoijff\naoisjdofijaoi\naoisdjofaijsodifjaosijd\naoisjdfoaijs")
event2 = Event.create(name: 'SocialClub End of year event', member_only: false, time: 60.day.from_now, address: '417 St kilda Road, Melbourne', description: "you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...you will be serve with Lobster again!!...")

# EventParticipant.create(event: event1, participant: user1)
# EventParticipant.create(event: event1, participant: user2)
# EventParticipant.create(event: event1, participant: user3)
# EventParticipant.create(event: event1, participant: user4)
# EventParticipant.create(event: event1, participant: user5)

# EventParticipant.create(event: event2, participant: user2)
# EventParticipant.create(event: event2, participant: user3)
# EventParticipant.create(event: event2, participant: user4)
# EventParticipant.create(event: event2, participant: user5)
# EventParticipant.create(event: event2, participant: user6)





