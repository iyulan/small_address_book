require 'rails_helper'

describe ContactsHelper do
  describe '#view_errors' do
    context 'when contact invalid' do
      let!(:contact) { build(:contact, emails_count: 0) }

      before { contact.valid? }

      it 'return activerecord errors' do
        expect(view_errors(contact.errors)).to include(t('activerecord.errors.models.contact.attributes.emails.blank'))
      end
    end

    context 'when simple error' do
      it 'return error' do
        expect(view_errors('error')).to include('error')
      end
    end
  end

  describe '#messages' do
    let(:notice) { { notice: 'notice' } }

    it 'return notice' do
      expect(messages(notice)).to include(notice[:notice])
    end
  end
end
