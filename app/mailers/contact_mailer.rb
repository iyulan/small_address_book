class ContactMailer < ActionMailer::Base
  default from: 'admin@admin.com'
  layout 'mailer'

  def share(contact, mail_to)
    @contact = contact
    mail(to: mail_to, subject: t('.subject', full_name: contact.full_name)) do |format|
      format.text
      format.html
    end
  end
end
