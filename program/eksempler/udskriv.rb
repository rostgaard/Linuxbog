#!/usr/local/bin/ruby
#
# Ruby
# af Peter Stubbe <stubbe@bitnisse.dk>
# $Id$
#
# Afvikling:
#  ./udskriv.rb [fil]+

for fnr in 0..(ARGV.length-1)
  fnavn=ARGV[fnr]
  if not FileTest.exists?(fnavn)
    puts "Filen #{fnavn} findes ikke!"
  else
    fil=File.open(fnavn, "r")
    fil.each{|line| puts "#{fil.lineno}\t#{line}"}
  end
end
while STDIN.readchar.chr!="Q"
end
