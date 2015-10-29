require 'rails_helper'

describe Contact do
  let!(:emails_count) { 2 }
  let!(:phones_count) { 2 }
  let!(:contact) { create(:contact, emails_count: emails_count, phones_count: phones_count) }

  describe 'associtations' do
    it { should have_many :emails }
    it { should have_many :phones }
  end

  describe 'field validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'full_name validation' do
    let(:dup_contact) { build(:contact, first_name: contact.first_name, last_name: contact.last_name) }

    it 'contact with same full_name not valid' do
      expect(dup_contact).not_to be_valid
    end
  end

  describe 'emails validation' do
    let!(:contact_without_emails) { build(:contact, emails_count: 0) }

    it 'contact without emails not valid' do
      expect(contact_without_emails).not_to be_valid
    end
  end

  describe 'phones validation' do
    let!(:contact_without_phones) { build(:contact, phones_count: 0) }

    it 'contact without phones not valid' do
      expect(contact_without_phones).not_to be_valid
    end
  end

  describe '#phones_list' do
    let!(:contact_phone) { create(:phone, contact: contact) }

    it 'return phones array' do
      expect(contact.reload.phones_list.size).to eq(phones_count + 1)
    end

    it 'include contact_phone' do
      expect(contact.reload.phones_list).to include(contact_phone.phone)
    end
  end

  describe '#emails_list' do
    let!(:contact_email) { create(:email, contact: contact) }

    it 'return emails array' do
      expect(contact.reload.emails_list.size).to eq(emails_count + 1)
    end

    it 'include contact_email' do
      expect(contact.reload.emails_list).to include(contact_email.email)
    end
  end

  describe '#full_name' do
    it 'return linked first_name and last_name' do
      expect(contact.full_name).to eq("#{contact.first_name} #{contact.last_name}")
    end
  end
end
