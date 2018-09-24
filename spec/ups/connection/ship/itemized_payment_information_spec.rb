require 'spec_helper'
require 'tempfile'
require 'support/shipping_options'

describe UPS::Connection do
  include ShippingOptions

  let(:server) { UPS::Connection.new(test_mode: true) }

  describe "if requesting a shipment with free domicile" do

    subject do
      server.ship do |shipment_builder|
        @account_number = ENV['UPS_IT_ACCOUNT_NUMBER']
        shipper = shipper(@account_number)
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper
        shipment_builder.add_ship_from shipper
        shipment_builder.add_ship_to ship_to
        shipment_builder.add_sold_to sold_to
        shipment_builder.add_package package
        shipment_charges = [
          transportation_charges(@account_number, :shipper),
          duties_and_taxes_charges(@account_number, :shipper)
        ]
        shipment_builder.add_itemized_payment_information(shipment_charges: shipment_charges)
        shipment_builder.add_service shipper[:country], ship_to[:country], 'Express'
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

  describe "if requesting a shipment billed to receiver" do

    subject do
      server.ship do |shipment_builder|
        @shipper_account_number = ENV['UPS_ALT_IT_ACCOUNT_NUMBER']
        @payer_account_number = ENV['UPS_IT_ACCOUNT_NUMBER']
        shipper = shipper(@shipper_account_number)
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper
        shipment_builder.add_ship_from shipper
        shipment_builder.add_ship_to shipper(@payer_account_number)
        shipment_builder.add_sold_to sold_to
        shipment_builder.add_package package
        shipment_charges = [
          transportation_charges(@payer_account_number, :receiver),
          duties_and_taxes_charges(@payer_account_number, :receiver)
        ]
        shipment_builder.add_itemized_payment_information(shipment_charges: shipment_charges)
        shipment_builder.add_service shipper[:country], ship_to[:country], 'Express'
        shipment_builder.add_description 'Description'
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

    it "should return the tracking number" do
      subject.tracking_number.must_match(/1Z#{@shipper_account_number}\d{10}/)
    end
  end

  describe "if requesting a shipment billed to third party shipper" do

    subject do
      server.ship do |shipment_builder|
        @shipper_account_number = ENV['UPS_ALT_IT_ACCOUNT_NUMBER']
        @payer_account_number = ENV['UPS_IT_ACCOUNT_NUMBER']
        shipper = shipper(@shipper_account_number)
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper
        shipment_builder.add_ship_from shipper
        shipment_builder.add_ship_to ship_to
        shipment_builder.add_sold_to sold_to
        shipment_builder.add_package package
        shipment_charges = [
          transportation_charges(@payer_account_number, :third_party_shipper),
          duties_and_taxes_charges(@payer_account_number, :third_party_shipper)
        ]
        shipment_builder.add_itemized_payment_information(shipment_charges: shipment_charges)
        shipment_builder.add_service shipper[:country], ship_to[:country], 'Express'
        shipment_builder.add_description 'Description'
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

    it "should return the tracking number" do
      subject.tracking_number.must_match(/1Z#{@shipper_account_number}\d{10}/)
    end
  end

  describe "if requesting a shipment billed to consignee" do

    subject do
      server.ship do |shipment_builder|
        @account_number = ENV['UPS_US_ACCOUNT_NUMBER']
        shipper = us_shipper(@account_number)
        recipient = us_ship_to(@account_number)
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper
        shipment_builder.add_ship_from shipper
        shipment_builder.add_ship_to recipient
        shipment_builder.add_sold_to sold_to
        shipment_builder.add_package us_package
        shipment_charges = [
          transportation_charges(@account_number, :consignee_billed),
          duties_and_taxes_charges(@account_number, :consignee_billed)
        ]
        shipment_builder.add_itemized_payment_information(shipment_charges: shipment_charges)
        shipment_builder.add_service shipper[:country], recipient[:country], 'Ground'
        shipment_builder.add_description 'Description'
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

    it "should return the tracking number" do
      subject.tracking_number.must_match(/1Z#{@account_number}\d{10}/)
    end
  end
end
