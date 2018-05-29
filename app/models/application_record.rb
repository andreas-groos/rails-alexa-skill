class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def sanitize(x)
    ActiveRecord::Base.connection.quote x
  end

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || "is not an email")
      end
    end
  end
end
