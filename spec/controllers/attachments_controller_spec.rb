require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:question_files) { create(:question, :question_files, user: user) }
  let(:answer_files) { create(:answer, :answer_files, question: question_files, user: user) }

  describe 'DELETE #destroy' do
    before { login(user) }

    describe 'Question file' do
      context 'Authorized user can' do
        it 'delete the file' do
          expect { delete :destroy, params: { id: question_files.files.first}, format: :js }.to change(question_files.files, :count).by(-1)
        end
        it 'redirect to destroy' do
          delete :destroy, params: { id: question_files.files.first}, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'Authorized other user' do
        before { login(other_user) }

        it 'tries to delete file' do
          expect { delete :destroy, params: { id: question_files.files.first}, format: :js }.to_not change(question_files.files, :count)
        end
        it 'redirect to destroy' do
          delete :destroy, params: { id: question_files.files.first}, format: :js
          expect(response).to render_template :destroy
        end
      end
    end

    describe 'Answer file' do
      context 'Authorized user can' do
        it 'delete the file' do
          expect { delete :destroy, params: { id: answer_files.files.first}, format: :js }.to change(answer_files.files, :count).by(-1)
        end
        it 'redirect to destroy' do
          delete :destroy, params: { id: answer_files.files.first}, format: :js
          expect(response).to render_template :destroy
        end
      end

      context 'Authorized other user' do
        before { login(other_user) }

        it 'tries to delete file' do
          expect { delete :destroy, params: { id: answer_files.files.first}, format: :js }.to_not change(answer_files.files, :count)
        end
        it 'redirect to destroy' do
          delete :destroy, params: { id: answer_files.files.first}, format: :js
          expect(response).to render_template :destroy
        end
      end
    end
  end
end
