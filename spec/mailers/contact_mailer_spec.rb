require 'rails_helper'

describe ContactMailer do
  describe '.share' do
    let!(:shared_contact) { create(:contact) }
    let(:mail_to) { Faker::Internet.safe_email }

    before { @mail = ContactMailer.share(shared_contact, mail_to) }

    it 'sends contact' do
      expect(@mail.subject).to eq I18n.t('contact_mailer.share.subject', full_name: shared_contact.full_name)
      expect(@mail.to).to eq [mail_to]
      expect(@mail.body.encoded).to match 'UTF-8'
    end
  end
end
