require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:question) { create(:question, user: user) }

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
  
  describe 'POST #create' do
    before { login(user) }
    context 'with valid attributes' do
      it 'Authenticated user saves a new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end
      it 'redirects to question show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'Authenticated user does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid_answer) } }.to_not change(Answer, :count)
      end
      it 're-renders new view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid_answer) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  
end
