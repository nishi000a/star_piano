class Teacher::LessonsController < ApplicationController
  before_action :authenticate_teacher!

  def index
    @lessons = Lesson.joins(:post).where(post:{teacher_id: current_teacher.id}).page(params[:page]).per(8)

  end

  def show
    @lessons = Lesson.where(id: params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:student_id, :name, :introduction, :post_id, :lesson_1, :lesson_2, :lesson_3, :lesson_4, :lesson_5)
  end

end
