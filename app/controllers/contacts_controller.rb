class ContactsController < ApplicationController
  def index
    load_contacts
  end

  def show
    load_contact
  end

  def new
    build_contact
  end

  def create
    build_contact
    save_contact || render('new')
  end

  def edit
    load_contact
    build_contact
  end

  def update
    load_contact
    build_contact
    save_contact || render('edit')
  end

  def destroy
    load_contact
    @contact.destroy
    redirect_to contacts_path
  end

  def import
    @errors = Contact::ImportCSV.perform(params[:file].tempfile)
    if @errors.present?
      render :import
    else
      redirect_to contacts_path, notice: t('.success')
    end
  end

  def export
    filename = Contact::ExportCSV.perform(Contact.includes(:emails, :phones))
    send_file(filename, filename: 'contacts.csv', type: 'application/csv')
  end

  def share
    load_contact
    share_contact
  end

  private

  def share_contact
    ContactMailer.share(@contact, params[:mail_to]).deliver_now if params[:mail_to].blank?
    redirect_to @contact, notice: params[:mail_to].present? ? t('.success') : t('.failed')
  end

  def load_contacts
    @contacts ||= contact_scope.to_a
  end

  def load_contact
    @contact ||= contact_scope.find(params[:id])
  end

  def build_contact
    @contact ||= contact_scope.build
    @contact.attributes = contact_params
  end

  def save_contact
    redirect_to @contact if @contact.save
  end

  def contact_params
    contact_params = params[:contact]
    if contact_params
      contact_params.permit(
        :first_name, :last_name,
        phones_attributes: [:id, :phone, :_destroy],
        emails_attributes: [:id, :email, :_destroy]
      )
    else
      {}
    end
  end

  def contact_scope
    Contact.all
  end
end
