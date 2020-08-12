# File_TableDelimited
### A modern Component for Reading Delimited Text Files

The applications we write sometimes need to import and process information from tab-delimited/csv files. The code needed to open, validate and prepare the file for processing is quite similar in each case is usually duplicated with each file importer. It gets even more complicated when handling the positions that that columns might appear in.

This component lets you hide away the complexity of loading the delimited file into an object with named attributes that align with the columns in the file.

## Features
- The file can be tab-delmited, comma delimited, comma delimted with a custom separator
- The columns can be in any order
- The data within the columns is type casted
- Columns can be optional or required
- Handle any EOL (e.g. CR, LF, CRLF)

## Requirements
- 4D v18 is required.
- Files must contain tabular data.

## Installation and Use
Copy the `File_TableDelimited.4dbase` into the Components folder of your application. It is suggested that you compile the component before installing it into your own projects.

## Examples
Example #1
```
to be filled in	 
```

Example #2
```
to be filled in	
```

## Shared Methods
### tbd ( object; path; value )
blaa blaa
