require 'csv'

class Contact
  class ExportCSV
    def self.perform(contacts)
      filename = Rails.root.join('tmp/contacts.csv').to_s
      CSV.open(filename, 'wb', col_sep: ';') do |csv|
        csv << ['First Name', 'Last Name', 'Phones', 'Emails']
        contacts.each do |contact|
          csv << [
            contact.first_name,
            contact.last_name,
            contact.phones_list.join(', '),
            contact.emails_list.join(', ')
          ]
        end
      end
      filename
    end
  end
end
