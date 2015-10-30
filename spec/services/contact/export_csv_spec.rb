require 'rails_helper'

RSpec.describe Contact::ExportCSV do
  describe '.perform' do
    let(:contacts) { create_list(:contact, 4) }

    before { @filename = Contact::ExportCSV.perform(contacts) }

    it 'return filename tmp/contacts.csv' do
      expect(@filename).to eq(Rails.root.join('tmp/contacts.csv').to_s)
    end

    it 'return headers in first line' do
      first_line = File.read('tmp/contacts.csv').split("\n").first
      expect(first_line.split(';')).to eq(['First Name', 'Last Name', 'Phones', 'Emails'])
    end
  end
end
