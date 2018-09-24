require 'ox'

module UPS
  module Builders
    # The {PaymentInformationBuilder} class builds UPS XML PaymentInformation Object.
    #
    # @author Walter Mottinelli
    # @since 0.9.7
    # @attr [String] name The Containing XML Element Name
    # @attr [Hash] opts The PaymentInformation Parts
    class PaymentInformationBuilder < BuilderBase
      include Ox

      attr_accessor :name, :opts

      # Initializes a new {PaymentInformationBuilder} object
      #
      # @param [Hash] opts The Payment Information Parts
      # @option opts [String] :billing_actor who pays
      # @option opts [String] :billing_account_number payer UPS account number
      # @option opts [String] :billing_postal_code postal code associated with account number
      # @option opts [String] :billing_country_code country code associated with account number
      def initialize(name, opts = {})
        self.name = name
        self.opts = opts
      end

      # Returns an XML representation of a UPS Payment Information
      #
      # @return [Ox::Element] XML representation of the current object
      def to_xml
        Element.new(name).tap do |payment_information|
          payment_information << case opts[:billing_actor]
          when :shipper
            Element.new('Prepaid').tap do |prepaid|
             prepaid << Element.new('BillShipper').tap do |bill_shipper|
                bill_shipper << element_with_value('AccountNumber', opts[:billing_account_number])
              end
            end
          when :receiver
            Element.new('FreightCollect').tap do |freight_collect|
              freight_collect << Element.new('BillReceiver').tap do |bill_receiver|
                bill_receiver << element_with_value('AccountNumber', opts[:billing_account_number])
                if opts[:billing_postal_code]
                  bill_receiver << Element.new('Address').tap do |address|
                    address << element_with_value('PostalCode', opts[:billing_postal_code])
                  end
                end
              end
            end
          when :third_party_shipper
            Element.new('BillThirdParty').tap do |bill_third_party|
              bill_third_party << Element.new("bill_#{opts[:billing_actor]}".split('_').map{|e| e.capitalize}.join).tap do |bill_third_party_actor|
                bill_third_party_actor << element_with_value('AccountNumber', opts[:billing_account_number])
                bill_third_party_actor << Element.new('ThirdParty').tap do |third_party|
                  third_party << Element.new('Address').tap do |address|
                    address << element_with_value('PostalCode', opts[:billing_postal_code]) if opts[:billing_postal_code]
                    address << element_with_value('CountryCode', opts[:billing_country_code])
                  end
                end
              end
            end
          when :consignee_billed
            Element.new 'ConsigneeBilled'
          end
        end
      end
    end
  end
end
