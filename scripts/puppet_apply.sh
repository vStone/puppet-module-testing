#!/bin/bash
boxname="${1-unknown}"

###############################################################################
#  _    _
# | |_ (_)___ _ _ __ _
# | ' \| / -_) '_/ _` |
# |_||_|_\___|_| \__,_|
#
# hieradata folder exists?
[ -d /etc/puppet/hieradata ] || mkdir -pv /etc/puppet/hieradata

# copy the hiera configuration file
[ -f /vagrant/hiera/hiera.yaml ] && cp -v /vagrant/hiera/hiera.yaml /etc/puppet/hiera.yaml

# sync the data
rsync -alrcWt --del --progress \
  --exclude=.git* /vagrant/hiera/data/ /etc/puppet/hieradata


###############################################################################
#                           _
#  _ __ _  _ _ __ _ __  ___| |_
# | '_ \ || | '_ \ '_ \/ -_)  _|
# | .__/\_,_| .__/ .__/\___|\__|
# |_|       |_|  |_|
#
# create the environment folder
[ -d /etc/puppet/environments/production ] || mkdir -pv /etc/puppet/environments/production

# graphs dir (debugging dependencies++)
[ -d /vagrant/graphs/${boxname} ] || mkdir -pv /vagrant/graphs/${boxname}

# sync the data
rsync -alrcWt --del --progress \
  --exclude=.git* /vagrant/puppet/ /etc/puppet/environments/production


###############################################################################
#                      _
#  _____ _____ __ _  _| |_ ___
# / -_) \ / -_) _| || |  _/ -_)
# \___/_\_\___\__|\_,_|\__\___|
#
exec puppet apply \
  --environment production \
  --verbose --debug --trace \
  --graph --graphdir /vagrant/graphs/$boxname \
  --modulepath '$confdir/environments/$environment/modules' \
  /etc/puppet/environments/production/manifests/site.pp
