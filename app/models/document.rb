class Document < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
