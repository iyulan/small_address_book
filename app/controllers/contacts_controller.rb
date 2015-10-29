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

  private

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
