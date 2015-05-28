module Switchable
  extend ActiveSupport::Concern

  module ClassMethods
    def switchable(date_field, default_value: false, new_field: nil)
      new_field = date_field.to_s.gsub('_at', '').to_sym if new_field.nil?

      define_method(new_field) do
        if default_value && new_record?
          true
        else
          send("#{date_field}?")
        end
      end

      define_method("#{new_field}?") do
        send(new_field)
      end

      define_method("#{new_field}_changed?") do
        send("#{date_field}_changed?")
      end

      define_method("#{new_field}=") do |value|
        if value == "1" || value == true
          send("#{date_field}=", Time.now)
        elsif value == "0" || value == false || value.blank?
          send("#{date_field}=", nil)
        end
      end

      define_method("toggle_#{new_field}") do
        new_value = send("#{new_field}?") ? false : true
        send("#{new_field}=", new_value)
      end

      define_method("toggle_#{new_field}!") do
        send("toggle_#{new_field}")
        update_column(date_field, send(date_field))
      end
    end
  end

end
