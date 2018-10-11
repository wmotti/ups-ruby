require 'ox'

module UPS
  module Builders
    # The {ShipConfirmBuilder} class builds UPS XML ShipConfirm Objects.
    #
    # @author Paul Trippett
    # @since 0.1.0
    # @attr [String] name The Containing XML Element Name
    # @attr [Hash] opts The Organization and Address Parts
    class ShipConfirmBuilder < BuilderBase
      include Ox

      # Initializes a new {ShipConfirmBuilder} object
      #
      def initialize
        super 'ShipmentConfirmRequest'

        add_request 'ShipConfirm', 'validate'
      end

      # Adds a LabelSpecification section to the XML document being built
      # according to user inputs
      #
      # @return [void]
      def add_label_specification(format, size)
        root << Element.new('LabelSpecification').tap do |label_spec|
          label_spec << label_print_method(format)
          label_spec << label_image_format(format)
          label_spec << label_stock_size(size)
          label_spec << http_user_agent if gif?(format)
        end
      end

      # Adds a InternationalForms section to the XML document being built
      # according to user inputs
      #
      # @return [void]
      def add_international_invoice(opts = {})
        shipment_root << Element.new('ShipmentServiceOptions').tap do |shipment_service_options|
          shipment_service_options << InternationalInvoiceBuilder.new('InternationalForms', opts).to_xml
        end
      end

      # Adds a Service section to the XML document being built
      #
      # @param [String] service_code The Service code for the choosen Shipping
      #   method
      # @param [optional, String] service_description A description for the
      #   choosen Shipping Method
      # @return [void]
      def add_service(origin, destination, service)
        service_code = service_code(origin, destination, service)
        shipment_root << code_description('Service', service_code, service)
      end

      def service_code(origin, destination, service)
        if ! %w[US CA EU MX PL PR].include?(origin) && UPS::Data::EU_COUNTRIES.has_key?(origin)
          origin = 'EU'
        end
        case origin
        when 'US'
          UPS::Data::US_SERVICE_CODES
        when 'CA'
          if destination == 'CA'
            UPS::Data::CA_DOMESTIC_SERVICE_CODES
          else
            UPS::Data::CA_SERVICE_CODES
          end
        when 'EU'
          UPS::Data::EU_SERVICE_CODES
        when 'MX'
          UPS::Data::MX_SERVICE_CODES
        when 'PL'
          UPS::Data::PL_SERVICE_CODES
        when 'PR'
          UPS::Data::PR_SERVICE_CODES
        else
          UPS::Data::OTHERS_SERVICE_CODES
        end.merge!(UPS::Data::ALL_SERVICE_CODES).fetch service do
          raise UPS::Exceptions::UnavailableServiceException.new "Unavailable service #{service} from #{origin} to #{destination}"
        end
      end

      # Adds Description to XML document being built
      #
      # @param [String] description The description for goods being sent
      #
      # @return [void]
      def add_description(description)
        shipment_root << element_with_value('Description', description)
      end

      # Adds ReferenceNumber to the XML document being built
      #
      # @param [Hash] opts A Hash of data to build the requested section
      # @option opts [String] :code Code
      # @option opts [String] :value Value
      #
      # @return [void]
      def add_reference_number(opts = {})
        shipment_root << reference_number(opts[:code], opts[:value])
      end

      private

      def gif?(string)
        string.downcase == 'gif'
      end

      def http_user_agent
        element_with_value('HTTPUserAgent', version_string)
      end

      def version_string
        "RubyUPS/#{UPS::Version::STRING}"
      end

      def label_print_method(format)
        code_description 'LabelPrintMethod', "#{format}", "#{format} file"
      end

      def label_image_format(format)
        code_description 'LabelImageFormat', "#{format}", "#{format}"
      end

      def label_stock_size(size)
        multi_valued('LabelStockSize',
                     'Height' => size[:height].to_s,
                     'Width' => size[:width].to_s)
      end

      def reference_number(code, value)
        multi_valued('ReferenceNumber',
                     'Code' => code.to_s,
                     'Value' => value.to_s)
      end
    end
  end
end
