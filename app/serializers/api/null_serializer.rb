class Api::NullSerializer < ActiveModel::Serializer::Null
    def id
      nil
    end
  end
  