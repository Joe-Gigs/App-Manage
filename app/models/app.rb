class App < ActiveRecord::Base
  before_create :generate_app_key
  before_create :generate_api_key
  before_create :default_frequency

  has_many :messages
  has_many :important_messages
  has_many :email_notifications
  validates_presence_of :app_name
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :events
  has_many :devices

  def generate_app_key
    if self.app_key === nil
      self.app_key = loop do
        random_key = SecureRandom.urlsafe_base64(nil, false)
        break random_key unless App.exists?(app_key: random_key)
      end
    end
  end

  def default_frequency
    self.email_frequency = 'daily'
  end

  def generate_api_key
    if self.api_key === nil
      self.api_key = loop do
        random_key = SecureRandom.urlsafe_base64(nil, false)
        break random_key unless App.exists?(api_key: random_key)
      end
    end
  end

  def first_runs_total
    self.events.where(message_code: 'FTR').count
  end

  def first_runs_today
    today = Time.zone.now
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'FTR', today.beginning_of_day, today.end_of_day])
  end

  def first_runs_yesterday
    yesterday = Time.zone.now - 1.day
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'FTR', yesterday.beginning_of_day, yesterday.end_of_day])
  end

  def first_runs_last_week
    last_week = Time.zone.now.beginning_of_week - 1.week
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'FTR', last_week, last_week.end_of_week])
  end

  def first_runs_this_week
    this_week = Time.zone.now.beginning_of_week
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'FTR', this_week, Time.zone.now.end_of_week])
  end

  def first_runs_this_month
    this_month = Time.zone.now.beginning_of_month
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'FTR', this_month, Time.zone.now.end_of_month])
  end

  def first_runs_last_month
    last_month = Time.zone.now - 1.month
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'FTR', last_month.beginning_of_month, last_month.end_of_month])
  end

  def unread_count
    self.important_messages.where(is_read: false).count
  end

  def app_session_total
    self.events.where(message_code: 'SES').count
  end

  def app_sessions_today
    today_session = Time.zone.now
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'SES', today_session.beginning_of_day, today_session.end_of_day])
  end

  def app_sessions_this_week
    this_week_session = Time.zone.now.beginning_of_week
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'SES', this_week_session, Time.zone.now.end_of_week])
  end

  def app_sessions_this_month
    this_month_session = Time.zone.now.beginning_of_month
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'SES', this_month_session, Time.zone.now.end_of_month])
  end

  def app_sessions_yesterday
    yesterday_session = Time.zone.now - 1.day
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'SES', yesterday_session.beginning_of_day, yesterday_session.end_of_day])
  end

  def app_sessions_last_week
    last_week_session = Time.zone.now.beginning_of_week - 1.week
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'SES', last_week_session, last_week_session.end_of_week])
  end

  def app_sessions_last_month
    last_month_session = Time.zone.now - 1.month
    self.events.where(['message_code = ? AND created_at >= ? AND created_at <= ?', 'SES', last_month_session.beginning_of_month, last_month_session.end_of_month])
  end

  def check_for_token
    self.production_key.present?
  end

  def send_daily_stats
    DailyEmailMailer.delay.send_daily(self)
  end
end