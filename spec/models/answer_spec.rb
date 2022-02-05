require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should have_many(:links).dependent(:destroy) }
  it { should belong_to(:user) }
  
  it { should validate_presence_of :body }
  it { should accept_nested_attributes_for :links }

  describe 'best answer' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    let(:other_answer) { create(:answer, question: question, user: user) }

    context 'mark best set' do
      it 'as true' do
        answer.mark_as_best
        expect(answer).to be_best
      end

      it 'as false' do
        other_answer.mark_as_best
        expect(other_answer).to be_best
        answer.mark_as_best
        answer.reload
        other_answer.reload
        expect(answer).to be_best
        expect(other_answer).to_not be_best
      end

      it 'only one answer must be the best' do
        answer.mark_as_best
        other_answer.mark_as_best
        expect(question.answers.where(best: true).count).to eq 1
      end
    end
  end

  it 'have many attached files' do
    expect(Answer.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
