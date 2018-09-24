require 'spec_helper'
require 'tempfile'
require 'support/shipping_options'

describe UPS::Connection do
  include ShippingOptions

  let(:server) { UPS::Connection.new(test_mode: true) }

  describe "if requesting a shipment with label links" do

    subject do
      server.ship do |shipment_builder|
        @shipper_account_number = ENV['UPS_IT_ACCOUNT_NUMBER']
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper(@shipper_account_number)
        shipment_builder.add_ship_from shipper(@shipper_account_number)
        shipment_builder.add_ship_to ship_to
        shipment_builder.add_sold_to sold_to
        shipment_builder.add_package package
        shipment_builder.add_payment_information @shipper_account_number
        shipment_builder.add_service '07'
        shipment_builder.add_description 'Description'
        shipment_builder.add_shipment_service_options(label_links: true)
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

    it "should return the requested label links" do
      subject.label_url.must_be_a_valid_UPS_label_url
      subject.local_language_label_url.must_be_a_valid_UPS_label_url
    end

    it "should return the tracking number" do
      subject.tracking_number.must_match(/1Z#{@shipper_account_number}\d{10}/)
    end
  end

  describe "if requesting a return shipment with label links" do

    subject do
      server.ship do |shipment_builder|
        @shipper_account_number = ENV['UPS_IT_ACCOUNT_NUMBER']
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper(@shipper_account_number)
        shipment_builder.add_ship_from shipper(@shipper_account_number)
        shipment_builder.add_ship_to ship_to
        shipment_builder.add_sold_to sold_to
        shipment_builder.add_package package
        shipment_builder.add_payment_information @shipper_account_number
        shipment_builder.add_service '07'
        shipment_builder.add_return_service('9', 'UPS Print Return Label (PRL)')
        shipment_builder.add_description 'Description'
        shipment_builder.add_shipment_service_options(label_links: true)
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

    it "should return the requested label links" do
      subject.label_url.must_be_a_valid_UPS_label_url
      subject.local_language_label_url.must_be_a_valid_UPS_label_url
      subject.receipt_url.must_be_a_valid_UPS_receipt_url
      subject.local_language_receipt_url.must_be_a_valid_UPS_receipt_url
    end

    it "should return the tracking number" do
      subject.tracking_number.must_match(/1Z#{@shipper_account_number}\d{10}/)
    end
  end
end
