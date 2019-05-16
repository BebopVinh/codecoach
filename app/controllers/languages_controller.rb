class LanguagesController < ApplicationController
  def new_or_destroy
    @language = Language.new
  end

  def create
    if !language_params[:name].empty?
      @language = Language.find_or_create_by(name: language_params[:name])
    else
      @language = Language.find_by_id(params[:language][:id])
    end

    @user = Mentor.find_by_id(session[:mentor_id]) || Student.find_by_id(session[:student_id])
    @user.languages << @language

    if session[:mentor_id]
      redirect_to mentor_path(@user)
    elsif session[:student_id]
      redirect_to student_path(@user)
    end
  end

  def edit
    @language = Language.new
  end

  def destroy
    @languages = params[:language][:id]
    @languages.delete("")

    @user = Mentor.find_by_id(session[:mentor_id]) || Student.find_by_id(session[:student_id])

    @languages.each do |lang_id|
      language = Language.find_by_id(lang_id)

      @user.languages.destroy(language)
    end

    if session[:mentor_id]
      redirect_to mentor_path(@user)
    elsif session[:student_id]
      redirect_to student_path(@user)
    end
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end
end
