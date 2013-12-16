name             'balanced-dns'
maintainer       'Balanced'
maintainer_email 'matthew@balancedpayments.com'
license          'All rights reserved'
description      'Installs/Configures balanced-hostname'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'


depends          'route53', '~> 0.4.0'

depends          'balanced-citadel', '~> 0.1.0'
