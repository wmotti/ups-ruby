require 'insensitive_hash'

module UPS
  module Data
    REFERENCE_NUMBER_CODES = {
      'Accounts Receivable Customer Account'            => 'AJ',
      'Appopriation Number'                             => 'AT',
      'Bill of Lading Number'                           => 'BM',
      'Collect on Delivery (COD) Number'                => '9V',
      'Dealer Order Number'                             => 'ON',
      'Department Number'                               => 'DP',
      'Food and Drug Administration (FDA) Product Code' => '3Q',
      'Invoice Number'                                  => 'IK',
      'Manifest Key Number'                             => 'MK',
      'Model Number'                                    => 'MJ',
      'Part Number'                                     => 'PM',
      'Production Code'                                 => 'PC',
      'Purchase Order Number'                           => 'PO',
      'Purchase Request Number'                         => 'RQ',
      'Return Authorization Number'                     => 'RZ',
      'Salesperson Number'                              => 'SA',
      'Serial Number'                                   => 'SE',
      'Store Number'                                    => 'ST',
      'Transaction Reference Number'                    => 'TN'
    }.insensitive
  end
end
