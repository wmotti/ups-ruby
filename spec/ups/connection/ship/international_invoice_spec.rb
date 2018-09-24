require 'spec_helper'
require 'tempfile'
require 'support/shipping_options'

describe UPS::Connection do
  include ShippingOptions

  let(:server) { UPS::Connection.new(test_mode: true) }

  describe "if requesting a shipment" do

    subject do
      server.ship do |shipment_builder|
        @account_number = ENV['UPS_IT_ACCOUNT_NUMBER']
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper(@account_number)
        shipment_builder.add_ship_from shipper(@account_number)
        shipment_builder.add_ship_to ship_to
        shipment_builder.add_sold_to sold_to
        shipment_builder.add_package package
        shipment_builder.add_payment_information @account_number
        shipment_builder.add_service '07'
        shipment_builder.add_description 'Description'
        shipment_builder.add_shipment_service_options(international_invoice: invoice_form)
      end
    end

    it "should do what ever it takes to get that shipment shipped!" do
      subject.wont_equal false
      subject.success?.must_equal true
    end

    it "should return the label data" do
      subject.label_graphic_image.must_be_kind_of File
      subject.label_html_image.must_be_kind_of File
      subject.label_graphic_extension.must_equal '.gif'

      subject.graphic_image.must_be_kind_of File
      subject.html_image.must_be_kind_of File
      subject.graphic_extension.must_equal '.gif'
    end

    it "should return the requested customs form data" do
      subject.form_graphic_image.must_be_kind_of File
      subject.form_graphic_extension.must_equal '.pdf'
    end

    it "should return the tracking number" do
      subject.tracking_number.must_match(/1Z#{@account_number}\d{10}/)
    end
  end
end
