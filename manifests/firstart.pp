class cloudpassage::firstart {

  exec { 'cloudpassage first start':
    command     => "service cphalod start --api-key=${cloudpassage::data::apikey} --tag=${cloudpassage::data::tags}",
    logoutput   => on_failure,
    refreshonly => true,
  }

}
