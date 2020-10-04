class Api::UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :admin
  
    has_many :posts
  end
  