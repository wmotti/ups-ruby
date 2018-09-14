require 'ox'

module UPS
  module Builders
    # The {ShipmentChargeBuilder} class builds UPS XML International invoice Produt Objects.
    #
    # @author Walter Mottinelli
    # @since 0.9.7
    # @attr [String] name The Containing XML Element Name
    # @attr [Hash] opts The shipment charge parts
    class ShipmentChargeBuilder < BuilderBase
      include Ox

      attr_accessor :name, :opts

      def initialize(name, opts = {})
        self.name = name
        self.opts = opts
      end

      def type
        type = case opts[:type]
               when :transportation
                 '01'
               when :duties_and_taxes
                 '02'
               end
        element_with_value 'Type', type
      end

      # Returns an XML representation of the current object
      #
      # @return [Ox::Element] XML representation of the current object
      def to_xml
        Element.new(name).tap do |shipment_charge|
          shipment_charge << type
          shipment_charge << case opts[:billed_actor]
          when :shipper
            Element.new('BillShipper').tap do |bill_shipper|
              bill_shipper << element_with_value('AccountNumber', opts[:billed_account_number])
            end
          when :receiver
            Element.new('BillReceiver').tap do |bill_receiver|
              bill_receiver << element_with_value('AccountNumber', opts[:billed_account_number])
            end
          when :third_party_shipper, :third_party_consignee
            Element.new('BillThirdParty').tap do |bill_third_party|
              bill_third_party << Element.new("bill_#{opts[:billed_actor]}".split('_').map{|e| e.capitalize}.join).tap do |bill_third_party_actor|
                bill_third_party_actor << element_with_value('AccountNumber', opts[:billed_account_number])
                bill_third_party_actor << Element.new('ThirdParty').tap do |third_party|
                  third_party << Element.new('Address').tap do |address|
                    address << element_with_value('PostalCode', opts[:postal_code]) if opts[:postal_code]
                    address << element_with_value('CountryCode', opts[:country_code])
                  end
                end
              end
            end
          when :consignee_billed
            Element.new('ConsigneeBilled')
          end
        end
      end
    end
  end
end
