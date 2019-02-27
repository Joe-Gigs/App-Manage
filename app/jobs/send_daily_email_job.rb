class SendDailyEmailJob
  def self.queue
    :queues
  end

  def perform(app)
    DailyEmailMailer.send_daily(app).deliver_now
  end
end
