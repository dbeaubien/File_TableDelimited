//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileImporter_New (pathToImportFile) : importObject
// FileImporter_New (text) : object
//
// DESCRIPTION
//   Creates and initalizes an import object.
//   Used with "FileImporter_DeclareColumn"
//   and "FileImporter_Load2Collection".
//
#DECLARE($pathToImportFile : Text)->$importObject : Object
ASSERT:C1129(Count parameters:C259=1)

$importObject:=New object:C1471
$importObject.importFilePath:=$pathToImportFile
$importObject.columnDefinitions:=New collection:C1472
$importObject.importedData:=New collection:C1472
$importObject.status:=""
$importObject.errorMessage:=""
$importObject.rowStart:=0