class PositionDecorator < ApplicationDecorator
  delegate_all

  def description_text(length: 150)
    truncate object.description_text, length: length, separator: ' ', escape: false, omission: '... (continued)' if object.description_text.present?
  end

  alias_method :description, :description_text
end
