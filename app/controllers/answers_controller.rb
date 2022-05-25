class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_question, only: :create
  before_action :find_answer, only: [:destroy, :mark_as_best, :update]
  after_action :publish_answer, only: :create

  authorize_resource
  
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    if current_user&.author?(@answer)
      @answer.destroy
    end
  end

  def mark_as_best
    @question = @answer.question
    @answer.mark_as_best 
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:id, :name, :url, :_destroy])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      'questions#{params[:question_id]}/answers', 
        {
        partial: ApplicationController.render(
          partial: 'answers/answer',
          locals: { answer: @answer, current_user: current_user }
        )
      }
    )
  end
end
