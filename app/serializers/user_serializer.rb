class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :admin, :first_name, :last_name
end
