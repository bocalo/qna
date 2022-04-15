class Api::V1::AnswersController < Api::V1::BaseController
  
  def index
    @answers = question.answers
    render json: @answers
  end

  def show
    answer = Answer.find(params[:id])
    render json: answer, serializer: AnswerDataSerializer
  end

  def create
    @answer = question.answers.new(answer_params)
    @answer.user = current_resource_owner

    if @answer.save
      render json: @answer, status: :created
    else
      render json: { errors: @answer.errors }, status: :unprocessable_entity
    end
  end

  def update
    if answer.update(answer_params)
      render json: answer, status: :created
    else
      render json: { errors: answer.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    answer.destroy
    render json: { messages: ["Answer was successfully deleted."] }
  end

  private

  def answer
    @answer = Answer.find(params[:id])
  end

  helper_method :answer

  def question
    @question = Question.find(params[:question_id])
  end

  helper_method :question

  def answer_params
    params.require(:answer).permit(:body)
  end
end
