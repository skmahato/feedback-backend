class Api::DealershipSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :description, :phone, :email, :website

  belongs_to :user
  has_many :reviews
end
