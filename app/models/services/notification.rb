class Services::Notification
  def send_notification(answer)
    subscriptions = answer.question.subscriptions
    subscriptions.find_each do |subscription|
      NotificationMailer.notification(subscription.user, answer).deliver_later
    end
  end
end
