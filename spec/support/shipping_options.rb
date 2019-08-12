module ShippingOptions
  def shipper(account_number)
    {
      company_name: 'Veeqo Limited',
      attention_name: 'Walter White',
      phone_number: '01792 123456',
      address_line_1: '11 Wind Street',
      city: 'Swansea',
      state: 'Wales',
      postal_code: '20126',
      country: 'IT',
      shipper_number: account_number
    }
  end

  def shipper_US(account_number)
    {
      company_name: 'Veeqo Limited',
      attention_name: 'Walter White',
      phone_number: '01792 123456',
      address_line_1: '11 Wind Street',
      city: 'New York',
      state: 'NY',
      postal_code: '10007',
      country: 'US',
      shipper_number: account_number
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
      country: 'GB',
      email_address: 'sergie.bryn@google.com'
    }
  end

  def ship_to_US
    {
      company_name: 'Google Inc.',
      attention_name: 'Sergie Bryn',
      phone_number: '0207 031 3000',
      address_line_1: '777 Brockton Avenue',
      city: 'New York',
      state: 'NY',
      postal_code: '10007',
      country: 'US',
      email_address: 'sergie.bryn@google.com'
    }
  end

  def sold_to
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

  def sold_to_US
    {
      company_name: 'Google Inc.',
      attention_name: 'Sergie Bryn',
      phone_number: '0207 031 3000',
      address_line_1: '1 St Giles High Street',
      city: 'New York',
      state: 'NY',
      postal_code: '10007',
      country: 'US'
    }
  end

  def package
    {
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

  def package_with_delivery_confirmation
    {
      weight: '0.5',
      unit: 'LBS',
      dimensions: {
        length: 40.0,
        width: 30.0,
        height: 20.0,
        unit: 'IN'
      },
      delivery_confirmation: {
        type: 'signature required'
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
      reason_for_export: 'SALE',
      currency_code: 'EUR',
      products: [
        {
          description: 'White coffee mug',
          number: '1',
          value: '14.02',
          dimensions_unit: 'CM',
          part_number: 'MUG-01-WHITE',
          commodity_code: '1234567890',
          origin_country_code: 'US'
        },
        {
          description: 'Red coffee mug',
          number: '1',
          value: '14.05',
          dimensions_unit: 'CM',
          part_number: 'MUG-01-RED',
          commodity_code: '1234567890',
          origin_country_code: 'US'
        }
      ]
    }
  end
end
