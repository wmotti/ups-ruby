require 'spec_helper'

describe UPS::Connection do
  include ShippingOptions

  let(:server) { UPS::Connection.new(test_mode: true) }

  describe "if requesting rates" do

    subject do
      server.rates do |rate_builder|
        rate_builder.add_access_request ENV['UPS_LICENSE_NUMBER'], ENV['UPS_USER_ID'], ENV['UPS_PASSWORD']
        rate_builder.add_shipper shipper(ENV['UPS_IT_ACCOUNT_NUMBER'])
        rate_builder.add_ship_from shipper(ENV['UPS_IT_ACCOUNT_NUMBER'])
        rate_builder.add_ship_to ship_to
        rate_builder.add_package package
        rate_builder.add_rate_information
      end
    end

    it "should return neotiated rates" do
      expect(subject.rated_shipments).wont_be_empty
      subject.rated_shipments.each {|s| s[:total] = :variable}
      expect(subject.rated_shipments.sort_by {|s| s[:service_code]}).must_equal [
        {
          :service_code=>"11",
          :service_name=>"UPS Standard",
          :warnings=>["Your invoice may vary from the displayed reference rates"],
          :total=>:variable

        },
        {
          :service_code=>"65",
          :service_name=>"UPS Saver",
          :warnings=>["Your invoice may vary from the displayed reference rates"],
          :total=>:variable
        },
        {
          :service_code=>"54",
          :service_name=>"Express Plus",
          :warnings=>["Your invoice may vary from the displayed reference rates"],
          :total=>:variable
        },
        {
          :service_code=>"07",
          :service_name=>"Express",
          :warnings=>["Your invoice may vary from the displayed reference rates"],
          :total=>:variable
        }
      ].sort_by {|s| s[:service_code]}
    end
  end
end
