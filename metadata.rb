#
# Author:: Matthew Francis-Landau <mathew@balancedpayments.com>
# Author:: Andrew Imam <andrew@balancedpayments.com>
# Author:: Noah Kantrowitz <noah@coderanger.net>
#
# Copyright 2013, Balanced, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name 'balanced-dns'
version '0.1.5'

maintainer 'Mathew Francis-Landau'
maintainer_email 'matthew@balancedpayments.com'
license 'Apache 2.0'
description 'Updates DNS entries for Balanced servers'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends 'route53', '~> 0.4.0'
depends 'balanced-citadel', '~> 1.0'
