module Puppet::Parser::Functions
  newfunction(
    :create_resources_autofs,
    :doc => <<-EODOC
       Converts a hash for autofs::loader and creates autofs::include and autofs::mount resources.
    EODOC
  ) do |args|

    Puppet::Parser::Functions.autoloader.load(:create_resources) unless Puppet::Parser::Functions.autoloader.loaded?(:create_resources)

    if args.empty?
      raise Puppet::ParseError, 'You must supply a non empty argument.'
    end
    tree = args.shift

    autofs_includes = {}
    autofs_mounts = {}

    # this will remove the shares parameter from the hash
    # and create autofs::mounts from the definitions there
    tree.each do |incl, params|
      if params.is_a?(Hash)
        shares = params.delete('shares') || {}
        autofs_includes[incl] = params
        shares.each do |m,p|
          # override the map to the parent autofs::include
          p['map'] = incl
          autofs_mounts[m] = p
        end
      end
    end

    function_create_resources(['autofs::include', autofs_includes])
    function_create_resources(['autofs::mount', autofs_mounts])
  end
end
