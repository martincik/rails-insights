class Position < ActiveRecord::Base
  belongs_to :company
  belongs_to :portal
end
