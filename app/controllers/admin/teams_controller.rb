class Admin::TeamsController < AdminsController
  
  def new
    @competition = Competition.find(params[:competition_id])  
    respond_to do |format|
      if @competition
        format.js
      else
        format.json { render json: @competition.errors.full_messages,
                                     status: :unprocessable_entity }
      end
    end
  end

  def create
    @competition = Competition.find(params[:competition_id])
    count = [0, params[:count].to_i].max

    respond_to do |format|
      begin
        create_teams(count, @competition)
        format.js
      rescue
        format.json { render json: { responseText: 'Create teams failed.'},
                                     status: :unprocessable_entity }
      end
    end
  end

  def create_teams(count, competition)
    index = competition.next_team_index
    ActiveRecord::Base.transaction do
      count.times do |i|
        new_team = Team.new( name: "Team#{index + i}", competition: competition)
        new_team.save!
      end
    end
  end
end