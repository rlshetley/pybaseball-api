name 'baseball_api'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures baseball_api'
long_description 'Installs/Configures baseball_api'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/baseball_api/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/baseball_api'

depends 'mysql', '~> 8.0'
depends 'chef_nginx', '~> 6.1.1'
depends 'poise-python', '~> 1.6.0'
depends 'zipfile', '~> 0.2.0'
