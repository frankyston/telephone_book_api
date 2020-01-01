class ContactSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :phone, :street, :neighborhood, :city, :state, :birthday
end
