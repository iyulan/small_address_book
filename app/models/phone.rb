class Phone < ActiveRecord::Base
  belongs_to :contact

  validates :phone, presence: true
end
