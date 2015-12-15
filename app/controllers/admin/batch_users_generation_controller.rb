class Admin::BatchUsersGenerationController < AdminsController
  
  def index
    @users = User.all
  end

  def new    
  end

  def create
    emails = params[:emails].split(";").map(&:strip)
    begin         
      create_users(emails)
      redirect_to admin_batch_users_generation_index_path
    rescue ActiveRecord::RecordInvalid
      flash.now[:error] = "Create users failed, please check the emails you entered are correct"
      render :new
    end                             
  end

  
  def update_users
    begin
      update_items
    rescue ActiveRecord::RecordInvalid
      flash[:error] = 'Update users failed'      
    end
    redirect_to admin_batch_users_generation_index_path
  end

  private

   def update_items
    ActiveRecord::Base.transaction do
      params[:user_datas].each do |user_data|
        user = User.find(user_data[:id])            
        user.update_attributes!(is_member: user_data[:is_member], is_admin: user_data[:is_admin])
      end  
    end
  end

  def create_users(emails=[])
    ActiveRecord::Base.transaction do
      emails.each do |email|
        user = User.find_by(email: email)
        if user.nil?
          name = email.split("@").first.split('.').join(" ")
          new_user = User.new( email: email, password: '12345', name: name)
          new_user.save!
        end        
      end  
    end
  end

end