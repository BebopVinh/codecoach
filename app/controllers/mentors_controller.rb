class MentorsController < ApplicationController
  def new
    @mentor = Mentor.new

  end

  def create
    @mentor = Mentor.new(mentor_params)

    if @mentor.save
      return head(:forbidden) unless @mentor.authenticate(params[:mentor][:password])
      session[:user_id] = @mentor.id
      redirect_to mentor_path(@mentor)
    else
      redirect_to new_mentor_path
    end
  end

  def show
    
  end

  private

  def mentor_params
    params.require(:mentor).permit(:username, :first_name, :last_name, :email, :profile_img, :location, :github_link, :student_id, :password, :password_confirmation)
  end
end
