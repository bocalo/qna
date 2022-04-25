require 'rails_helper'

RSpec.describe Services::Notification do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:subscription) { create(:subscription, question: question, user: user) }

  it 'send notification' do
    question.subscriptions.each do |subscription|
      expect(NotificationMailer).to receive(:notification).with(subscription.user, answer).and_call_original
    end
    subject.send_notification(answer)
  end
end
