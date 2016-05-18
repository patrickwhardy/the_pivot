
  Geocoder.configure(
    :timeout      => 3,           # geocoding service timeout (secs)
    :lookup       => :google,     # name of geocoding service (symbol)
    :language     => :en,         # ISO-639 language code
    :units     => :mi,       # :km for kilometers or :mi for miles
    :distances => :linear    # :spherical or :linear
  )
