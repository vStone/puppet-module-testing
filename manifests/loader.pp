# == Class: autofs::loader
#
# Loads autofs::mounts from hiera.
#
# === Deep merge notes:
#
# If you want this kind of structures (see below) to be merged,
# you will need to make sure you have the deep_merge gem installed
# and add this to your hiera configuration file (/etc/puppet/hiera.yaml)
#
#     :merge_behavior: deeper
#
# See http://docs.puppetlabs.com/hiera/1/configuring.html#mergebehavior for
# more information.
#
# === Structure
#
# autofs::mounts should be formatted like this:
#
#   ---
#   autofs::mounts:
#     include_title:
#       purge: false
#       mount: /data
#       shares:
#         foo:
#           host: foobar.example.com
#           location: /foodata
#
#         bar:
#           host: foobar.example.com
#           location: /bardata
#
#
class autofs::loader {

  $tree = hiera_hash('autofs::mounts', {})
  create_resources_autofs($tree)

}
