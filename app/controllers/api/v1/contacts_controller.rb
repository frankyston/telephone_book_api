class Api::V1::ContactsController < ApplicationController
  include Paginable
  before_action :check_login
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :set_options

  def index
    @contacts = current_user.contacts.page(current_page).per(per_page)
    @contacts = @contacts.search(params[:q]) if params[:q].present?
    @options = get_links_serializer_options(@options, 'api_v1_contacts_path', @contacts)
    render json: ContactSerializer.new(@contacts, @options).serializable_hash, status: :ok
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
