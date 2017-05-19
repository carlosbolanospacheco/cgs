module Filtrable
  extend ActiveSupport::Concern

  module ClassMethods
    def filtrar(filter_params)
      results = where(nil)
      filter_params.each do |key, value|
        results = results.public_send(key, value) if value.present? && !value.eql?('0')
      end
      results
    end
  end
end
