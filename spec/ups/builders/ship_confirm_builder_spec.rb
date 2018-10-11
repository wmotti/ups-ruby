require 'spec_helper'

class UPS::Builders::TestShipConfirmBuilder < Minitest::Test
  include SchemaPath
  include ShippingOptions

  def test_validates_against_xsd
    ship_confirm_builder = UPS::Builders::ShipConfirmBuilder.new do |builder|
      builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
      builder.add_shipper shipper(ENV['UPS_IT_ACCOUNT_NUMBER'])
      builder.add_ship_to ship_to
      builder.add_ship_from shipper(ENV['UPS_IT_ACCOUNT_NUMBER'])
      builder.add_package package
      builder.add_label_specification 'gif', { height: '100', width: '100' }
      builder.add_shipment_service_options(international_invoice: invoice_form)
      builder.add_description 'Los Pollo Hermanos'
      builder.add_reference_number reference_number
      builder.add_insurance_charge '5.00'
    end
    assert_passes_validation schema_path('ShipConfirmRequest.xsd'), ship_confirm_builder.to_xml
  end

  def test_raises_an_exception_for_invalid_service
    UPS::Builders::ShipConfirmBuilder.new do |builder|
      assert_raises(UPS::Exceptions::UnavailableServiceException) do
        builder.add_service 'IT', 'RU', 'Next Day Air Early'
      end
    end
  end
end
