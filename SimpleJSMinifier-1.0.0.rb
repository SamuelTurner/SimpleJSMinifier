# SimpleJSMinifier
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
# limitations under the License. *

# Load main file using the first arg passed in
path = ARGV.first
file = File.new(path, "r")

# Declare a few variables and arrays
js = ""
imports_regex = /\/\* @import\((.*?)\) \*\//
imports = Array.new

# Iterate through each line of the file
file.each do |line|

	# Add the file to the js string
	js << line.to_s

	# Add any imports to the import array
	if line.match(imports_regex)
		imports << line.match(imports_regex).to_s
	end

end

# Replace each import with the contents of the file they point to
imports.each do |import|
	# Extract the import path
	import_path = import
	import_path = import_path.gsub("/* @import(", "")
	import_path = import_path.gsub(") */", "")

	# Import the file
	file = File.new(import_path, "r")
	import_file = ""

	file.each do |line|
		import_file << line.to_s
	end

	js = js.gsub(import, import_file)
end

# Remove block comments
js = js.gsub(/\/\*[^*]*\*+(?:[^*\/][^*]*\*+)*\//, "")

# Remove inline comments
js = js.gsub(/\s\/\/(.*)/, "")

# Reduce whitespace
js = js.gsub(/\s+/, " ")

# Use the original filename to build a new filename
filename = path.split("\\").last.gsub(".js", "")
filename = filename + ".min.js"

# Write out the file
output = File.open(filename, "w")
output << js
output.close

puts "Minifying complete"