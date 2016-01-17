class Admin::CompetitionsController < AdminsController
  def index
    @competitions = Competition.order('is_finished, created_at DESC').all
  end

  def new
    @competition = Competition.new
  end

  def show
    @competition = Competition.find(params[:id])
    
  end 

  def create
    @new_competition = Competition.new(competition_params)
    respond_to do |format|
      if @new_competition.save
        format.json { head :no_content }
        format.js 
        format.html { redirect_to admin_competitions_path }
      else      
        format.json { render json: @new_competition.errors.full_messages,
                                     status: :unprocessable_entity }
      
        format.html do
          flash[:error] = 'You are not allowed to do that.'
          redirect_to admin_competitions_path
        end      
      end
    end
  end

  def competition_params
    params.require(:competition).permit(:name, :is_finished)
  end
  
end