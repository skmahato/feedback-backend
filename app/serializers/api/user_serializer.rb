class Api::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :admin, :name

  has_one :dealership
  has_many :reviews
end
  