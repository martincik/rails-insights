class Position < ActiveRecord::Base
  belongs_to :company
  belongs_to :portal

  alias_attribute :description, :description_text
end
