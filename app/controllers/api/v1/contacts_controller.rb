class Api::V1::ContactsController < ApplicationController
  before_action :check_login
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :set_options

  def index
    contacts = ContactSerializer.new(current_user.contacts, @options).serializable_hash
    render json: contacts, status: :ok
  end

  def show
    render json: ContactSerializer.new(@contact, @options).serializable_hash, status: :ok
  end

  def create
    contact = current_user.contacts.build(contact_params)

    if contact.save
      render json: ContactSerializer.new(contact, @options).serializable_hash, status: :created
    else
      render json: { errors: contact.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: ContactSerializer.new(@contact, @options).serializable_hash, status: :ok
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    head 204
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def set_options
    @options = { include: [:user] }
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :phone, :street, :neighborhood, :city, :state, :birthday, :user_id)
  end
end
