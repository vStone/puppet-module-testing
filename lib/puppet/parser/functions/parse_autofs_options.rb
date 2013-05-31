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
      options.each do |opt|
        if opt =~ /([^=]+)(=(.+))?/
          key = $1
          if key.empty?
            function_warning(["Missing key in option #{opt}"])
          elsif $2.nil?
            hash[key] = nil
          else
            hash[key] = $3
          end
        end
      end
      return hash
    end

    # by now, it should be a hash or it would have been returned.
    unless options.is_a?(Hash)
      raise Puppet::ParseError, "Unsupported argument type: #{args.class}."
    end
    # sanitize the hash.
    options.keys.each do |k|
      unless options[k].nil?
        if options[k].empty? or options[k].strip.empty?
          options[k] = nil
        end
      end
    end
    options
  end # newfunction
end # module Puppet::Parser::Functions
