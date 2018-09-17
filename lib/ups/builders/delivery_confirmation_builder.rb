require 'ox'

module UPS
  module Builders
    # The {DeliveryConfirmationBuilder} class builds UPS XML Delivery Confirmation Objects.
    #
    # @author Walter Mottinelli
    # @since 0.9.7
    # @attr [String] name The Containing XML Element Name
    # @attr [Hash] opts The delivery confirmation parts
    class DeliveryConfirmationBuilder < BuilderBase
      include Ox

      attr_accessor :name, :opts

      def initialize(name, opts = {})
        self.name = name
        self.opts = opts
      end

      def dcis_type(type)
        type_code = {
          signature_required:       '1',
          adult_signature_required: '2'
        }.fetch type
        element_with_value 'DCISType', type_code
      end

      # Returns an XML representation of the current object
      #
      # @return [Ox::Element] XML representation of the current object
      def to_xml
        Element.new(name).tap do |delivery_confirmation|
          delivery_confirmation << dcis_type(opts[:type])
        end
      end
    end
  end
end
