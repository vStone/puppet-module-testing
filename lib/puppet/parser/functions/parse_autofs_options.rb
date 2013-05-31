module Puppet::Parser::Functions
  newfunction(
    :parse_autofs_options,
    :type => :rvalue,
    :doc => <<-EODOC
       Convert a string or array with autofs options to a hash.
    EODOC
  ) do |args|
    if args.empty?
      raise Puppet::ParseError, 'You must supply a non empty argument.'
    end
    options = args.shift

    # strip leading - if there is one from a string and split it.
    options = options.gsub(/^-/,'').split(',') if options.is_a?(String)

    # convert an array to a hash.
    if options.is_a?(Array)
      hash = {}
      return hash
    end

    # by now, it should be a hash or it would have been returned.
    unless options.is_a?(Hash)
      raise Puppet::ParseError, "Unsupported argument type: #{args.class}."
    end

    # return the hash
    options
  end # newfunction
end # module Puppet::Parser::Functions
