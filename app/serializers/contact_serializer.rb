class ContactSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :phone, :street, :neighborhood, :city, :state, :birthday
  belongs_to :user
end
