### SimpleJSMinifier ###

# http://samuel-turner.co.uk/
#
# Copyright 2013 Samuel Turner
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



### Load some dependencies ###
require 'net/http'



### Declare some variables/arrays ###

# String to store the JS in
js = ""

# Regex to match any imports found in the main js file
imports_regex = /\/\* @import\((.*?)\) \*\//

# Array to store any import statements in
imports = Array.new



### Do stuff ###

# Let the user know script has started, as it usually takes a few seconds to run
puts "\nCombining and minifying started...\n"

# Load main file using the first arg passed in
path = ARGV.first
file = File.new(path, "r")
file.each do |line|
	js << line

	# Add any import statements to the import array
	if line.match(imports_regex)
		imports << $1
	end
end

# Replace each import statement with the contents of the file they point to
imports.each do |import|
	import_file = ""
	file = File.new(import, "r")

	file.each do |line|
		import_file << line
	end

	js = js.gsub("/* @import(" + import + ") */", import_file)
end

# Send the JS off to javascript-minifier.com's API for minifying
url = URI.parse('http://javascript-minifier.com/raw')
resp = Net::HTTP.post_form(url, { 'input' => js })
js = resp.body

# Use the original filename to build a new filename
filename = path.split("\\").last.gsub(".js", "")
filename = filename + ".min.js"

# Write out the file
output = File.open(filename, "w")
output << js
output.close

# Let the user know the process is complete
puts "Minifying complete\n"