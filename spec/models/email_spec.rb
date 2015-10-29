require 'rails_helper'

describe Email do
  describe 'associtations' do
    it { should belong_to :contact }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
  end
end
