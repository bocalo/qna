require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:rewards).dependent(:destroy) }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  it 'User is author of question' do
    expect(user).to be_author(question)
  end

  it 'User is author of answer' do
    expect(user).to be_author(answer)
  end

  describe 'Check who is an author?' do
    let!(:user) { create(:user) }

    it 'current user is an author' do
      question = create(:question, user_id: user.id)

      expect(user).to be_author(question)
    end

    it 'current user is not an author' do
      question = create(:question)

      expect(user).to_not be_author(question)
    end
  end
end
