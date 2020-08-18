//%attributes = {}
  // _Test_Testable_FetchData (importFilePath) : importObj
  //
  // DESCRIPTION
  //   Loads the specified file and returns the import object.

C_TEXT:C284($1;$importFilePath)
C_OBJECT:C1216($0;$importObj)

ASSERT:C1129(Count parameters:C259=1)
$importFilePath:=$1

$importObj:=FileImporter_New ($importFilePath)
FileImporter_DeclareColumn ($importObj;"Serial Number";"serialNo";Is longint:K8:6)
FileImporter_DeclareColumn ($importObj;"Company Name";"company";Is text:K8:3)
FileImporter_DeclareColumn ($importObj;"Employee Markme";"employee";Is text:K8:3)
FileImporter_DeclareColumn ($importObj;"Description";"description";Is text:K8:3)
FileImporter_DeclareColumn ($importObj;"Leave";"numDaysTakenOnLeave";Is longint:K8:6)

C_COLLECTION:C1488($importCollection)
$importCollection:=FileImporter_Load2Collection ($importObj)

$0:=$importObj