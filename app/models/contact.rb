class Contact < ActiveRecord::Base
  has_many :phones
  has_many :emails

  validates :first_name, :last_name, :full_name, :emails, :phones, presence: true
  validates :full_name, uniqueness: true

  before_validation :set_full_name

  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :emails, allow_destroy: true

  def phones_list
    phones.map(&:phone)
  end

  def emails_list
    emails.map(&:email)
  end

  private

  def set_full_name
    self.full_name = "#{first_name} #{last_name}"
  end
end
