module FormatTime

  FORMATTING_OPTIONS = {

    # Date related options
    :date_options => {
      'YY' => '%Y',
      'CC' => '%C',
      'yy' => '%y',
      'mm' => '%m',
      'BB' => '%B',
      'bb' => '%b',
      'hh' => '%h',
      'dd' => '%d',
      'ee' => '%e',
      'jj' => '%j'
    },

    # Time related options
    :time_options => {
      'HH' => '%H',
      'kk' => '%k',
      'II' => '%I',
      'll' => '%l',
      'PP' => '%P',
      'pp' => '%p',
      'MM' => '%M',
      'SS' => '%S',
      'LL' => '%L',
      'NN' => '%N',
      '3N' => '%3N',
      '6N' => '%6N',
      '9N' => '%9N',
      '12N' => '%12N'
    },

    # Time zone related Options
    :time_zone_options => {
      'zz' => '%z',
      '1z' => '%:z',
      '2z' => '%::z',
      '3z' => '%:::z',
      'ZZ' => '%Z'
    },

    # Weekday related options
    :weekday_options => {
      'AA' => '%A',
      'aa' => '%a',
      'uu' => '%u',
      'ww' => '%w',
      'GG' => '%G',
      'gg' => '%g',
      'VV' => '%V',
      'UU' => '%U',
      'WW' => '%W'
    },

    # Seconds related opions
    :seconds_options => {
      'ss' => '%s',
      'QQ' => '%Q'
    },

    # Literal string related options
    :literal_string_options => {
      'nn' => '%n',
      'tt' => '%t'
    },

    # Combination Options
    :combination_options => {
      'cc' => '%c',
      'DD' => '%D',
      'FF' => '%F',
      'vv' => '%v',
      'xx' => '%x',
      'XX' => '%X',
      'rr' => '%r',
      'RR' => '%R',
      'TT' => '%T'
    }
  }

  def get_strftime_string(name, *args)
    separator = args[0] || '/'
    time_seperator = args[1].is_a?(String) ? args[1] : ':'
    multiple_separator =  args[-1] || false
    options = name.split('_')
    options.shift

    invalid_options = options - FORMATTING_OPTIONS.values.inject(:merge).keys
    raise ::ArgumentError, "Options #{invalid_options.join(', ')} are invalid." unless invalid_options.empty?

    strf_options = options.collect{ |option| FORMATTING_OPTIONS.values.inject(:merge)[option] }

    # multiple_separator ? strf_options.zip(separator.chars).flatten.compact.join : strf_options.join(separator)

    if multiple_separator
      return strf_options.zip(separator.chars).flatten.compact.join
    else
      strf_options = strf_options.map{ |option|
        FORMATTING_OPTIONS[:time_options].values.include?(option) ? "#{option}#{time_seperator}" : "#{option}#{separator}"
      }
      return (strf_options.length > 3 ? strf_options.insert(3, " ").join.split("#{separator} ").join(" ") : strf_options.join )[0..-2]
    end
  end
end