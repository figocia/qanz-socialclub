class Admin::TeamMembersController < AdminsController
  def create
    @team_member = TeamMember.new(team_members_params)


    respond_to do |format|
      if @team_member.save
        if params[:old_team_member_id].present?
          old_team_member = TeamMember.find(params[:old_team_member_id])
          old_team_member.destroy if old_team_member
        end    
        format.json { render json: @team_member }                                     
      else
        format.json { render json: @team_member.errors.full_messages,
                                     status: :unprocessable_entity }
      end 
     end
     
  end

  
  def destroy
    @team_member = TeamMember.find(params[:id])
    @team_member.destroy if @team_member
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  

  def team_members_params
    params.require(:team_member).permit(:team_id, :member_id)
  end
end