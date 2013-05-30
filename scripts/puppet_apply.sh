#!/bin/bash
boxname="${1-unknown}"

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
