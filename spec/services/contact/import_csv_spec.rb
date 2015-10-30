require 'rails_helper'

RSpec.describe Contact::ImportCSV do
  describe '.perform' do
    context 'with valid .csv' do
      let(:valid_file) { Rails.root.join('spec/fixtures/valid_contacts.csv') }
      let!(:exist_contact) { create(:contact, first_name: 'Stan', last_name: 'Marsh') }
      before { @errors = Contact::ImportCSV.perform(File.open(valid_file)) }

      it 'create all contacts from file' do
        expect(Contact.count).to eq(4)
      end

      it 'return empty errors' do
        expect(@errors).to be_blank
      end

      it 'overwrite emails and phones for exist contact' do
        expect(exist_contact.reload.emails_list).to match_array('stan@southpark.com')
        expect(exist_contact.reload.phones_list).to match_array('+1(111)222-33-44')
      end
    end

    context 'with invalid .csv' do
      let(:invalid_file) { Rails.root.join('spec/fixtures/invalid_contacts.csv') }
      before { @errors = Contact::ImportCSV.perform(File.open(invalid_file)) }

      it 'create not all contacts from file' do
        expect(Contact.count).not_to eq(4)
      end

      it 'return errors' do
        expect(@errors).not_to be_blank
      end
    end
  end
end
