module ShippingOptions
  def shipper
    {
      company_name: 'Veeqo Limited',
      attention_name: 'Walter White',
      phone_number: '01792 123456',
      address_line_1: '11 Wind Street',
      city: 'Swansea',
      state: 'Wales',
      postal_code: 'SA1 1DA',
      country: 'GB',
      shipper_number: ENV['UPS_ACCOUNT_NUMBER']
    }
  end

  def ship_to
    {
      company_name: 'Google Inc.',
      attention_name: 'Sergie Bryn',
      phone_number: '0207 031 3000',
      address_line_1: '1 St Giles High Street',
      city: 'London',
      state: 'England',
      postal_code: 'WC2H 8AG',
      country: 'GB'
    }
  end

  def package
    {
      packaging: 'Customer Supplied Package',
      weight: '0.5',
      unit: 'KGS',
      dimensions: {
        length: 40.0,
        width: 30.0,
        height: 20.0,
        unit: 'CM'
      }
    }
  end

  def reference_number
    {
      code: 'IK',
      value: '1234567890'
    }
  end

  def invoice_form
    {
      invoice_number: '#P-1234',
      invoice_date: '20170816',
      reason_for_export: '',
      currency_code: 'USD',
      products: [
        {
          description: 'White coffee mug',
          number: '1',
          value: '14.02',
          dimensions_unit: 'CM',
          part_number: 'MUG-01-WHITE',
          commodity_code: '1234',
          origin_country_code: 'US'
        },
        {
          description: 'Red coffee mug',
          number: '1',
          value: '14.05',
          dimensions_unit: 'CM',
          part_number: 'MUG-01-RED',
          commodity_code: '5678',
          origin_country_code: 'US'
        }
      ]
    }
  end
end
