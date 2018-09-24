module ShippingOptions
  def us_shipper(account_number)
    {
      company_name: 'company name',
      attention_name: 'attention name',
      phone_number: '01792 123456',
      address_line_1: '643 E 97th St',
      city: 'Cleveland',
      state: 'OH',
      postal_code: '44108-1209',
      country: 'US',
      shipper_number: account_number
    }
  end

  def us_ship_to(account_number)
    {
      company_name: 'company name',
      attention_name: 'attention name',
      phone_number: '01792 123456',
      address_line_1: '643 E 97th St',
      city: 'Cleveland',
      state: 'OH',
      postal_code: '44108-1209',
      country: 'US'
    }
  end

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

  def us_package
    {
      weight: '0.5',
      unit: 'LBS',
      dimensions: {
        length: 40.0,
        width: 30.0,
        height: 20.0,
        unit: 'IN'
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
