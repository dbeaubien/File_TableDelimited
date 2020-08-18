//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // FileImporter_Load2Collection (importObject) : importedRowCollection
  // FileImporter_Load2Collection (object) : collection
  //
  // DESCRIPTION
  //   Peform the import based on the defined columns.
  //   A collection of imported rows is returned.
  //
C_OBJECT:C1216($1;$importObj)
C_COLLECTION:C1488($0;$importedRowCollection)

$importedRowCollection:=New collection:C1472
If (Asserted:C1132(Count parameters:C259=1))
	$importObj:=$1
	
	  // Get our file type
	C_TEXT:C284($importFileFormat)
	If (File_IsCSV ($importObj.importFilePath))
		$importFileFormat:="CSV"
	End if 
	If (File_IsTabDelimited ($importObj.importFilePath))
		$importFileFormat:="TSV"
	End if 
	
	
	Case of 
		: (Not:C34(File_DoesExist ($importObj.importFilePath)))
			$importObj.status:="failed"
			$importObj.errorMessage:="File does not exist"
			
		: ($importFileFormat="")
			$importObj.status:="failed"
			$importObj.errorMessage:="File format is not supported. Only CSV and Tab-Delimited is supported."
			
		Else 
			
			C_TIME:C306($fileRef)
			$fileRef:=Open document:C264($importObj.importFilePath;Read mode:K24:5)
			If (OK=1)
				FileBuffer_Init ($fileRef)
				
				C_TEXT:C284($eol)
				$eol:=FileBuffer_TellMeTheEOL 
				
				  // Clear any previously imported data
				$importObj.importedData:=$importedRowCollection
				$importObj.fileHeaderColumns:=New collection:C1472
				
				If (True:C214)  // Load the header row and determine positions of each column in the collection
					ARRAY TEXT:C222($columnValuesArr;0)
					If ($importFileFormat="CSV")
						FileBuffer_FetchCSVLine ($eol;->$columnValuesArr)
					End if 
					If ($importFileFormat="TSV")
						FileBuffer_FetchTabDelimitedLne ($eol;->$columnValuesArr)
					End if 
					ARRAY TO COLLECTION:C1563($importObj.fileHeaderColumns;$columnValuesArr)
					
					C_OBJECT:C1216($column)
					C_LONGINT:C283($numColumns)
					For each ($column;$importObj.columnDefinitions)
						$column.columnPosition:=Find in array:C230($columnValuesArr;$column.headerLabel)
						$numColumns:=NUM_GetMaxLong ($numColumns;$column.columnPosition)
					End for each 
				End if 
				
				While (Not:C34(FileBuffer_EOF ))
					  // Load one line and put into an array for easier processing
					If ($importFileFormat="CSV")
						FileBuffer_FetchCSVLine ($eol;->$columnValuesArr)
					End if 
					If ($importFileFormat="TSV")
						FileBuffer_FetchTabDelimitedLne ($eol;->$columnValuesArr)
					End if 
					If ($numColumns>Size of array:C274($columnValuesArr))  // ensure our array matches the # of columns we have defined
						Array_SetSize ($numColumns;->$columnValuesArr)
					End if 
					
					C_OBJECT:C1216($rowObject)
					$rowObject:=New object:C1471
					For each ($column;$importObj.columnDefinitions)
						Case of 
							: ($column.columnPosition<=0)  // skip over since column was not found
								$rowObject[$column.objectAttributeName]:=Null:C1517
								
							: ($column.valueType=Is boolean:K8:9)
								$rowObject[$column.objectAttributeName]:=STR_IsOneOf ($columnValuesArr{$column.columnPosition};"Yes";"Y";"True";"1")
								
							: ($column.valueType=Is real:K8:4)
								$rowObject[$column.objectAttributeName]:=Num:C11($columnValuesArr{$column.columnPosition})
								
							: ($column.valueType=Is longint:K8:6)
								$rowObject[$column.objectAttributeName]:=Int:C8(Num:C11($columnValuesArr{$column.columnPosition}))
								
							: ($column.valueType=Is date:K8:7) & (STR_isDate ($columnValuesArr{$column.columnPosition}))
								$rowObject[$column.objectAttributeName]:=STR_isDate_GetDate ($columnValuesArr{$column.columnPosition})
								
							: ($column.valueType=Is date:K8:7) & (STR_isISODate ($columnValuesArr{$column.columnPosition}))
								$rowObject[$column.objectAttributeName]:=String2Date ($columnValuesArr{$column.columnPosition};"yyyy-mm-dd")
								
							Else 
								$rowObject[$column.objectAttributeName]:=$columnValuesArr{$column.columnPosition}
						End case 
					End for each 
					$importedRowCollection.push($rowObject)
				End while 
				
				$importObj.status:="success"
				
				CLOSE DOCUMENT:C267($fileRef)
			End if 
	End case 
	
End if 
$0:=$importedRowCollection