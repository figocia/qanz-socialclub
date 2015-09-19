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
 
game1 = Game.create(round: 'Round4', competition: competition2015, team_one: team1, team_two: team2, is_finished: false)
game2 = Game.create(round: 'Round5', competition: competition2015, team_one: team3, team_two: team4, is_finished: false)
game3 = Game.create(round: 'Round6', competition: competition2015, team_one: team2, team_two: team1, is_finished: false)
game4 = Game.create(round: 'Round7', competition: competition2015, team_one: team4, team_two: team3, is_finished: false)
game5 = Game.create(round: 'Round1', competition: competition2015, team_one: team1, team_two: team4, is_finished: true, team_one_score: 10, team_two_score: 2)
game6 = Game.create(round: 'Round2', competition: competition2015, team_one: team3, team_two: team2, is_finished: true, team_one_score: 10, team_two_score: 2)
game7 = Game.create(round: 'Round3', competition: competition2015, team_one: team1, team_two: team3, is_finished: true, team_one_score: 10, team_two_score: 2)
game8 = Game.create(round: 'Round4', competition: competition2015, team_one: team2, team_two: team4, is_finished: true, team_one_score: 10, team_two_score: 2)



user1 = User.create(name: 'Figo', email: 'yufei1.chen@3ds.com', is_member: false, password: '12345' )
user2 = User.create(name: 'Alice', email: 'yufei2.chen@3ds.com', is_member: false, password: '12345' )
user3 = User.create(name: 'Bob', email: 'yufei3.chen@3ds.com', is_member: false, password: '12345' )
user4 = User.create(name: 'Yufei', email: 'yufei4.chen@3ds.com', is_member: false, password: '12345' )
user5 = User.create(name: 'Kenny', email: 'yufei5.chen@3ds.com', is_member: false, password: '12345' )
user6 = User.create(name: 'CT', email: 'yufei6.chen@3ds.com', is_member: false, password: '12345' )
user7 = User.create(name: 'Chee Jun', email: 'yufei7.chen@3ds.com', is_member: false, password: '12345' )
user8 = User.create(name: 'Sher Jun', email: 'yufei8.chen@3ds.com', is_member: false, password: '12345' )
user9 = User.create(name: 'Tim', email: 'yufei9.chen@3ds.com', is_member: false, password: '12345' )
user10 = User.create(name: 'PG', email: 'yufei10.chen@3ds.com', is_member: false, password: '12345' )
user11 = User.create(name: 'PS', email: 'yufei11.chen@3ds.com', is_member: false, password: '12345' )
user12 = User.create(name: 'Selin', email: 'yufei12.chen@3ds.com', is_member: false, password: '12345' )
user13 = User.create(name: 'Jemma', email: 'yufei13.chen@3ds.com', is_member: false, password: '12345' )
user14 = User.create(name: 'Loris', email: 'yufei14.chen@3ds.com', is_member: false, password: '12345' )


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

event1 = Event.create(name: 'SocialClub Lunch', time: 1.day.from_now, address: '417 St kilda Road, Melbourne', description: "you will be serve with Lobster...")
event2 = Event.create(name: 'SocialClub End of year event', time: 60.day.from_now, address: '417 St kilda Road, Melbourne', description: "you will be serve with Lobster again!!...")

EventParticipant.create(event: event1, participant: user1)
EventParticipant.create(event: event1, participant: user2)
EventParticipant.create(event: event1, participant: user3)
EventParticipant.create(event: event1, participant: user4)
EventParticipant.create(event: event1, participant: user5)

EventParticipant.create(event: event2, participant: user2)
EventParticipant.create(event: event2, participant: user3)
EventParticipant.create(event: event2, participant: user4)
EventParticipant.create(event: event2, participant: user5)
EventParticipant.create(event: event2, participant: user6)





