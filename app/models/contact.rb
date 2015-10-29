class Contact < ActiveRecord::Base
  has_many :phones
  has_many :emails

  validates :first_name, :last_name, :full_name, :emails, :phones, presence: true
  validates :full_name, uniqueness: true

  before_validation :set_full_name

  private

  def set_full_name
    self.full_name = "#{first_name} #{last_name}"
  end
end
