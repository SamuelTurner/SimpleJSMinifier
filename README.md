# SimpleJSMinifier

I got sick of battling to get the popular JS minifers to work (on windows), so decided to write a script myself.

## Requirements
Ruby (I wrote this on 1.9.3)

## Acknowledgements

Thanks to [@AndyChilton](https://twitter.com/andychilton) for his http://javascript-minifier.com/ API. Made life much easier.

## Basic Usage
Copy the SimpleJSMinifier script to the directory where your root JS file lives, open a command prompt there and run:

	SimpleJSMinifier filename.js

## Compiling JS files
You can also compile JS files into your root, to do so simply add a comment into the root JS file with an import pointing at the file you want to import, like so:
	
	/* @import(folder/filename.js) */

So far, this does not support importing on multiple levels, so you can't have a file importing a file importing a file. Just a file importing a file.

## Changelog

* V1.0.0 - Initial version.
* V1.1.0 - Upgraded to using an API to minify the JS rather than some squiffy regexes.