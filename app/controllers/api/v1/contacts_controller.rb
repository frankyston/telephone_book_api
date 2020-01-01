class Api::V1::ContactsController < ApplicationController
  # before_action :check_owner
  before_action :check_login

  def create
    contact = current_user.contacts.build(contact_params)

    if contact.save
      render json: contact, status: :created
    else
      render json: { errors: contact.errors }, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :phone, :street, :neighborhood, :city, :state, :birthday, :user_id)
  end
end
