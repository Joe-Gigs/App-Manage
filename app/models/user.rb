class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :subscriptions
  has_many :apps, through: :subscriptions, dependent: :destroy
  before_save :skip_confirmation!
  before_create :upcase_name


  def full_name
    "#{self.fname} #{self.lname}"
  end

  def upcase_name
    self.fname.capitalize
    # self.lname.capitalize
  end

  def verify_is_agent?
    (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.agent?)
  end
end
