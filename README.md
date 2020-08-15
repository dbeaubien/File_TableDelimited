# File_TableDelimited
### A modern Component for Reading Delimited Text Files

The applications we write sometimes need to import and process information from tab-delimited/csv files. The code needed to open, validate and prepare the file for processing is quite similar in each case is usually duplicated with each file importer. It gets even more complicated when handling the positions that that columns might appear in.

This component lets you hide away the complexity of loading the delimited file into an object with named attributes that align with the columns in the file.

## Features
- Files can be tab-delimited, comma delimited, comma delimited with a custom separator
- Columns can be in any order
- Data within each column can be type casted
- Columns can be optional or required
- Handle any EOL (e.g. CR, LF, CRLF)

## Requirements
- 4D v18 is required.
- Files must contain tabular data.
- Requires the [FileFolder_Utils](https://github.com/4D-Open-Source/FileFolder_Utils) component

## Installation and Use
Copy the `File_TableDelimited.4dbase` into the Components folder of your application. It is suggested that you compile the component before installing it into your own projects.

## Examples
Example #1 - Load a file, get a list of unique companies from the file and then get ready to process the contents
```
C_TEXT($importFilePath)
$importFilePath:=Get 4D folder(Current resources folder)+"Test_Files"+Folder separator+"Sample2000.csv"
If (File_DoesExist ($importFilePath))
	C_OBJECT($importObj)
	$importObj:=FileImporter_New ($importFilePath)
	FileImporter_DeclareColumn ($importObj;"Serial Number";"serialNo";Is longint)
	FileImporter_DeclareColumn ($importObj;"Company Name";"company";Is text)
	FileImporter_DeclareColumn ($importObj;"Employee Markme";"employee";Is text)
	FileImporter_DeclareColumn ($importObj;"Description";"description";Is text)
	FileImporter_DeclareColumn ($importObj;"Leave";"numDaysTakenOnLeave";Is longint)
	
	C_COLLECTION($importCollection)
	$importCollection:=FileImporter_Load2Collection ($importObj)
	If ($importObj.status="success")
		
 		/* At this point, $importCollection is a collection of objects with this structure
			{
			 "serialNo":9788189999599,
			 "company":"TALES OF SHIVA",
			 "employee":"Mark",
			 "description":"mark",
			 "numDaysTakenOnLeave":0
			}
		*/

                // Get a unique collection of the company names from the file.
		C_COLLECTION($companies)
		$companies:=$importCollection.distinct("company")
		
		C_OBJECT($rowObject)
		For each ($rowObject;$importCollection)
			
			...  do what ever processing of the row represented by $rowObject ...
			
		End for each 
		
	Else 
		ALERT("Failed with error \""+$importObj.errorMessage+"\".")
	End if 
	
Else 
	ALERT("Test File not found!")
End if
```

Example #2 - Load a file, get the columns in various 4D data formats
```
C_TEXT($importFilePath)
$importFilePath:=Get 4D folder(Current resources folder)+"Test_Files"+Folder separator+"Student_Report.csv"
If (File_DoesExist ($importFilePath))
	
	C_OBJECT($importObj)
	$importObj:=FileImporter_New ($importFilePath)
	
	FileImporter_DeclareColumn ($importObj;"Internal Student ID";"id";Is longint)  // importer will convert to a longint
	FileImporter_DeclareColumn ($importObj;"First Name";"firstName";Is text)
	FileImporter_DeclareColumn ($importObj;"Middle Name";"middleName";Is text)
	FileImporter_DeclareColumn ($importObj;"Last Name";"lastName";Is text)
	FileImporter_DeclareColumn ($importObj;"Birthdate";"dob";Is date)
	FileImporter_DeclareColumn ($importObj;"One Time Consent Date";"consentDate";Is date)  // importer will convert to a date
	FileImporter_DeclareColumn ($importObj;"One Time Consent Y/N";"consentGiven";Is boolean)  // importer will convert to a boolean
	
	FileImporter_DeclareColumn ($importObj;"Not in File";"NIF";Is longint)  // column is not in file, so appears as a NULL in the results objects
	FileImporter_DeclareColumn ($importObj;"Birthdate";"dob_AsStr";Is text)  // also fetch the birthdate as the raw string
	FileImporter_DeclareColumn ($importObj;"One Time Consent Y/N";"consentGiven_AsStr";Is text)
	
	C_COLLECTION($importCollection)
	$importCollection:=FileImporter_Load2Collection ($importObj)
	If ($importObj.status="success")
		/* At this point, $importCollection is a collection of objects with this structure
			{
			 "id": 25655,
			 "firstName": "Rachel",
			 "middleName": "Renee",
			 "lastName": "Aaron",
			 "dob": "2011-07-10",
			 "consentDate": "2019-05-06",
			 "consentGiven": true,
			 "NIF": null,
			 "dob_AsStr": "07/10/2011",
			 "consentGiven_AsStr": "Yes"
			}
		*/

		C_OBJECT($rowObject)
		For each ($rowObject;$importCollection)
			
			// ...  do what ever processing of the row represented by $rowObject ...

		End for each 
		
	Else 
		ALERT("Failed with error \""+$importObj.errorMessage+"\".")
	End if 
	
Else 
	ALERT("Test File not found!")
End if  
```


## Shared Methods
### FileImporter\_New (pathToImportFile:c_text) returns importObject:c_object
Creates and initalizes an import object. Used with "FileImporter\_DeclareColumn" and "FileImporter\_Load2Collection".


### FileImporter\_DeclareColumn (importObject:c\_object, headerLabel:c\_text, objectAttribute:c\_object, type:c\_longint)
Adds the declared column definition to the import object.
- `headerLabel` is the column header for the column being imported
- `objectAttribute` is the attribute name that will be used when importing the data (see exmaple)
- `type` is a 4D data type. E.g. `Is text`
- If a 4D data type of `Is boolean` is used, then values of "Yes", "Y" and "True" will result in true values.
- If a 4D data type of `Is Real`is used, then the value will be number in the json object.
- If a 4D data type of `Is date` is used, then the value will be converted to a date. The following formats are supported: m/dd/yyyy, mm/d/yyyy, mm/dd/yyyy, and yyyy-mm-dd.
- 4D data type of `Is object` is not supported

### FileImporter\_Load2Collection (importObject:c\_object) returns importedRowCollection:c\_collection
Peform the import based on the defined columns. A collection of imported rows is returned.
