#!/usr/bin/ruby

step = 2
resource = STDIN.read

prefix_length = resource.match(/^(\s*)/)[0].length

header_regex = Regexp.new(/^\s*(\S+)\s+\{\s+(.+["']):\s+/)

# clean up whitespace
resource.strip!

matched = resource.match( header_regex )

# remove what we know about so we can split the attributes
resource.sub!( header_regex, '')

attribs = Hash.new
resource.scan(/(.+?)=>\s*(.+?),/).each { |k,v| attribs[k.strip] = v.strip }

longest_key = attribs.keys.max_by{|a| a.length}

indent = prefix_length + step

####################### print the resource back out # template this
printf("%s%s { %s:\n", ( ' ' * prefix_length), matched[1], matched[2])

attribs.sort.each do |k,v|

  printf("%s", ( ' ' * indent ))
  print k.ljust(longest_key.length)
  printf " => "
  print v
  printf(",\n")

end

printf("%s}\n", ( ' ' * prefix_length))
