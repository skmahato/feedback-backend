class Api::ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :comment, :visible, :rating

  belongs_to :dealership
  belongs_to :user
end
