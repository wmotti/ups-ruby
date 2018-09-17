require 'insensitive_hash'

module UPS
  module Data
    US_SERVICE_CODES = {
      'Standard' => '11',
      'Worldwide Expedited' => '08',
      'Worldwide Express' => '07',
      'Worldwide Express Plus' => '54',
      'Worldwide Saver' => '65',
      '2nd Day Air' => '02',
      '2nd Day Air A.M.' => '59',
      '3 Day Select' => '12',
      'Expedited Mail Innovations' => 'M4',
      'First-Class Mail' => 'M2',
      'Ground'=> '03',
      'Next Day Air' => '01',
      'Next Day Air Early' => '14',
      'Next Day Air Saver' => '13',
      'Priority Mail' => 'M3',
    }.insensitive

    CA_SERVICE_CODES = {
      '3 Day Select' => '12',
      'Express Saver' => '65',
      'Standard' => '11',
      'Worldwide Expedited' => '08',
      'Worldwide Express' => '07',
      'Worldwide Express Plus' => '54',
      'Express Early' => '54',
    }.insensitive

    CA_DOMESTIC_SERVICE_CODES = {
      'Expedited' => '02',
      'Express Saver' => '13',
      'Access Point Economy' => '70',
      'Express' => '01',
      'Express Early' => '14',
      'Standard' => '11',
    }.insensitive

    EU_SERVICE_CODES = {
      'Access Point Economy' => '70',
      'Expedited' => '08',
      'Express' => '07',
      'Standard' => '11',
      'Worldwide Express Plus' => '54',
      'Worldwide Saver' => '65',
      'Express®12:00' => '74',
    }.insensitive

    MX_SERVICE_CODES = {
      'Access Point Economy' => '70',
      'Expedited' => '08',
      'Express' => '07',
      'Express Plus' => '54',
      'Standard' => '11',
      'Worldwide Saver' => '65'
    }.insensitive

    PL_SERVICE_CODES = {
      'Access Point Economy' => '70',
      'Expedited' => '08',
      'Express' => '07',
      'Express Plus' => '54',
      'Express Saver' => '65',
      'Standard' => '11',
      'Today Dedicated Courier' => '83',
      'Today Express' => '85',
      'Today Express Saver' => '86',
      'Today Standard' => '82'
    }.insensitive

    PR_SERVICE_CODES = {
      '2nd Day Air' => '02',
      'Ground' => '03',
      'Next Day Air' => '01',
      'Next Day Air Early' => '14',
      'Worldwide Expedited' => '08',
      'Worldwide Express' => '07',
      'Worldwide Express Plus' => '54',
      'Worldwide Saver' => '65'
    }.insensitive

    OTHERS_SERVICE_CODES = {
      'Express' => '07',
      'Standard' => '11',
      'Worldwide Expedited' => '08',
      'Worldwide Express Plus' => '54',
      'Worldwide Saver' => '65'
    }.insensitive

    ALL_SERVICE_CODES = {
      'Worldwide Express Freight' => '96',
      'Priority Mail Innovations' => 'M5',
      'Economy Mail Innovations' => 'M6',
      'Worldwide Express Freight Mid-day' => '71',
    }.insensitive
  end
end
