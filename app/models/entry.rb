class Entry
  include Mongoid::Document

  field :name,  type: String
  field :url,   type: String
  field :type,  type: String
  field :links, type: Array, default: []

end
