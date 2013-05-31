fqdn = Facter.fqdn

Facter.add(:ndqf) do
  has_weight 100
  setcode do
    fqdn.split('.').reverse.join('.')
  end
end
