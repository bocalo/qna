# class AnswersController < ApplicationController
#   expose :question, ->{ Question.find(params[:question_id]) }
  
#   def create
#     @answer = question.answers.new(answer_params)

#     if @answer.save
#       redirect_to question
#     else
#       render :new
#     end
#   end

#   private

#   def answer_params
#     params.require(:answer).permit(:body)
#   end
# end



class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_question, only: %i[new create]
  
  def new
   
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question, notice: 'Your answer was successfully created'
    else
      render 'questions/show'
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end


  











  