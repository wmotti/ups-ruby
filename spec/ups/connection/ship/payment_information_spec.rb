require 'spec_helper'
require 'tempfile'
require 'support/shipping_options'

describe UPS::Connection do
  include ShippingOptions

  let(:server) { UPS::Connection.new(test_mode: true) }

  describe "if requesting a shipment with third party shipper payment" do

    subject do
      server.ship do |shipment_builder|
        @account_number = ENV['UPS_ALT_IT_ACCOUNT_NUMBER']
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper(@account_number)
        shipment_builder.add_ship_from shipper(@account_number)
        shipment_builder.add_ship_to ship_to
        shipment_builder.add_package package
        paymebnt_information_options = {
          billing_actor: :third_party_shipper,
          billing_account_number: ENV['UPS_IT_ACCOUNT_NUMBER'],
          billing_postal_code: '20126',
          billing_country_code: 'IT'
        }
        shipment_builder.add_payment_information paymebnt_information_options
        shipment_builder.add_service '07'
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

  describe "if requesting a shipment with freight collect receiver payment" do

    subject do
      server.ship do |shipment_builder|
        @account_number = ENV['UPS_ALT_IT_ACCOUNT_NUMBER']
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper shipper(@account_number)
        shipment_builder.add_ship_from shipper(@account_number)
        shipment_builder.add_ship_to shipper(@account_number)
        shipment_builder.add_package package
        payment_information_options = {
          billing_actor: :receiver,
          billing_account_number: ENV['UPS_IT_ACCOUNT_NUMBER'],
          billing_postal_code: '20126'
        }
        shipment_builder.add_payment_information payment_information_options
        shipment_builder.add_service '07'
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

  describe "if requesting a shipment with consignee billed payment" do

    subject do
      server.ship do |shipment_builder|
        @account_number = ENV['UPS_US_ACCOUNT_NUMBER']
        shipment_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        shipment_builder.add_shipper us_shipper(@account_number)
        shipment_builder.add_ship_from us_shipper(@account_number)
        shipment_builder.add_ship_to us_ship_to(@account_number)
        shipment_builder.add_package us_package
        shipment_builder.add_payment_information(billing_actor: :consignee_billed)
        shipment_builder.add_service '03'
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
