module UPS
  autoload :SERVICES,              'ups/services'

  autoload :Version,               'ups/version'
  autoload :Connection,            'ups/connection'
  autoload :Exceptions,            'ups/exceptions'

  autoload :Data,                  'ups/data'
  module Data
<<<<<<< HEAD
    autoload :US_STATES,                 'ups/data/us_states'
    autoload :CANADIAN_STATES,           'ups/data/canadian_states'
    autoload :IE_COUNTIES,               'ups/data/ie_counties'
    autoload :IE_COUNTY_PREFIXES,        'ups/data/ie_county_prefixes'
    autoload :US_SERVICE_CODES,          'ups/data/service_codes'
    autoload :CA_SERVICE_CODES,          'ups/data/service_codes'
    autoload :CA_DOMESTIC_SERVICE_CODES, 'ups/data/service_codes'
    autoload :EU_SERVICE_CODES,          'ups/data/service_codes'
    autoload :MX_SERVICE_CODES,          'ups/data/service_codes'
    autoload :PL_SERVICE_CODES,          'ups/data/service_codes'
    autoload :PR_SERVICE_CODES,          'ups/data/service_codes'
    autoload :OTHERS_SERVICE_CODES,      'ups/data/service_codes'
    autoload :ALL_SERVICE_CODES,         'ups/data/service_codes'
    autoload :PACKAGING,                 'ups/data/packagings'
  end

  module Parsers
    autoload :ParserBase,          'ups/parsers/parser_base'
    autoload :RatesParser,         'ups/parsers/rates_parser'
    autoload :ShipConfirmParser,   'ups/parsers/ship_confirm_parser'
    autoload :ShipAcceptParser,    'ups/parsers/ship_accept_parser'
  end

  module Builders
    autoload :BuilderBase,                        'ups/builders/builder_base'
    autoload :RateBuilder,                        'ups/builders/rate_builder'
    autoload :AddressBuilder,                     'ups/builders/address_builder'
    autoload :ShipConfirmBuilder,                 'ups/builders/ship_confirm_builder'
    autoload :InternationalInvoiceBuilder,        'ups/builders/international_invoice_builder'
    autoload :InternationalInvoiceProductBuilder, 'ups/builders/international_invoice_product_builder'
    autoload :ShipAcceptBuilder,                  'ups/builders/ship_accept_builder'
    autoload :OrganisationBuilder,                'ups/builders/organisation_builder'
    autoload :ShipperBuilder,                     'ups/builders/shipper_builder'
    autoload :ItemizedPaymentInformationBuilder,  'ups/builders/itemized_payment_information_builder'
    autoload :ShipmentChargeBuilder,              'ups/builders/shipment_charge_builder'
    autoload :DeliveryConfirmationBuilder,        'ups/builders/delivery_confirmation_builder'
    autoload :PaymentInformationBuilder,          'ups/builders/payment_information_builder'
  end
end
