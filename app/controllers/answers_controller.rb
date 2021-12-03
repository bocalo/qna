class AnswersController < ApplicationController
  expose :question, ->{ Question.find(params[:question_id]) }
  
  def create
    @answer = question.answers.new(answer_params)

    if @answer.save
      redirect_to question
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end














  #   def new
#   end

#   def create
#     @answer = question.answers.new(answer_params)

#     if @answer.save
#       redirect_to question
#     else
#       render :new
#     end
#   end

#   private

#   def answer
#     @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
#   end

#   helper_method :answer

#   def question
#     @question ||= Question.find(params[:question_id])
#   end

#   helper_method :question

#   def answer_params
#     params.require(:answer).permit(:body)
#   end
# end
