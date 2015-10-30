require 'csv'

class Contact
  class ImportCSV
    class << self
      def perform(file)
        line = 1
        errors = []
        SmarterCSV.process(file, set_parse_options) do |chunk|
          chunk.each do |data|
            errors << record_contact(data, line)
            line += 1
          end
        end
        errors.compact
      end

      private

      def set_parse_options
        {
          col_sep: ';',
          headers_in_file: true,
          remove_empty_values: false,
          force_simple_split: true,
          convert_values_to_numeric: false,
          quote_char: "'",
          chunk_size: 10,
          key_mapping: { phones: :phones_attributes, emails: :emails_attributes }
        }
      end

      def record_contact(data, line)
        Contact.transaction do
          contact = Contact.find_or_initialize_by(first_name: data[:first_name], last_name: data[:last_name])
          parsed_data = parse_contact_details!(contact, data)
          if contact.update_attributes!(data)
            remove_old_contacts(contact, parsed_data)
          end
          nil
        end
      rescue => e
        e.message + ": line #{line} - #{data[:first_name]}"
      end

      def parse_contact_details!(contact, data)
        parsed_data = {}
        %w(email phone).each do |type|
          parsed_data[type.to_sym] = get_contact_details(data, type)
          contact_detail_to_hash!(contact, data, type)
        end
        parsed_data
      end

      def remove_old_contacts(contact, parsed_data)
        %w(email phone).each do |type|
          contact.send(type.pluralize).where("#{type} not in (?)", parsed_data[type.to_sym]).destroy_all
        end
      end

      def get_contact_details(data, type)
        data["#{type.pluralize}_attributes".to_sym].to_s.split(',').map(&:strip)
      end

      def contact_detail_to_hash!(contact, data, type)
        key = "#{type.pluralize}_attributes".to_sym
        uniq_data = get_contact_details(data, type) - contact.send("#{type.to_s.pluralize}_list")
        data[key] = uniq_data.map { |row| { type => row } }
      end
    end
  end
end
