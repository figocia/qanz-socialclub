class Admin::BatchUsersGenerationController < AdminsController
  
  def index
    
  end

  def new    
  end

  def create
    emails = params[:emails].split(";").map(&:strip)
    begin         
      create_users(emails)
      redirect_to admin_batch_users_generation_index_path
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Create users failed, please check the emails you entered are correct"
      render :new
    end                     
    
    
  end

  def create_users(emails=[])
    ActiveRecord::Base.transaction do
      emails.each do |email|
        user = User.find_by(email: email)
        name = email.split("@").first.split('.').join(" ") unless user
        User.create( email: email, password: '12345', name: name) unless user
      end  
    end
  end
end