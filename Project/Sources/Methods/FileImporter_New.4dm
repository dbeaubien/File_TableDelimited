//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // FileImporter_New (pathToImportFile) : importObject
  // FileImporter_New (text) : object
  //
  // DESCRIPTION
  //   Creates and initalizes an import object.
  //   Used with "FileImporter_DeclareColumn"
  //   and "FileImporter_Load2Collection".
  //
C_TEXT:C284($1;$pathToImportFile)
C_OBJECT:C1216($0;$importObject)

$importObject:=New object:C1471
If (Asserted:C1132(Count parameters:C259=1))
	$pathToImportFile:=$1
	
	$importObject.importFilePath:=$pathToImportFile
	$importObject.columnDefinitions:=New collection:C1472
	$importObject.importedData:=New collection:C1472
	$importObject.status:=""
	$importObject.errorMessage:=""
	
End if 
$0:=$importObject