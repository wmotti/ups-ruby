require 'ox'

module UPS
  module Builders
    # The {ItemizedPaymentInformationBuilder} class builds UPS XML PaymentInformation Object.
    #
    # @author Walter Mottinelli
    # @since 0.9.7
    # @attr [String] name The Containing XML Element Name
    # @attr [Hash] opts The PaymentInformation Parts
    class ItemizedPaymentInformationBuilder < BuilderBase
      include Ox

      attr_accessor :name, :opts

      # Initializes a new {ItemizedPaymentInformationBuilder} object
      #
      # @param [Hash] opts The Organization and Address Parts
      # @option opts [String] :company_name Company Name
      # @option opts [String] :phone_number Phone Number
      # @option opts [String] :address_line_1 Address Line 1
      # @option opts [String] :city City
      # @option opts [String] :state State
      # @option opts [String] :postal_code Zip or Postal Code
      # @option opts [String] :country Country
      def initialize(name, opts = {})
        self.name = name
        self.opts = opts
      end

      # Returns an XML representation of a UPS Payment Information
      #
      # @return [Ox::Element] XML representation of the current object
      def to_xml
        Element.new(name).tap do |itemized_payment_information|
          shipment_charges.each do |shipment_charge|
            itemized_payment_information << shipment_charge
          end
        end
      end

      def shipment_charges
        opts[:shipment_charges].map do |charge_opts|
          shipment_charge_container(charge_opts)
        end
      end

      def shipment_charge_container(opts = {})
        ShipmentChargeBuilder.new('ShipmentCharge', opts).to_xml
      end
    end
  end
end
