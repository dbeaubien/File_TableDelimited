//%attributes = {}

C_TEXT:C284($importFilePath)
$importFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Test_Files"+Folder separator:K24:12+"Sample2000.csv"
$importFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Test_Files"+Folder separator:K24:12+"Sample2000.txt"  // Tab-delimited

C_OBJECT:C1216($importObj)
$importObj:=_Test_Testable_FetchData ($importFilePath)
If ($importObj.status="success")
	_Test_Testable_Processor ($importObj)
Else 
	ALERT:C41("Import "+$importObj.status+" with message \""+$importObj.errorMessage+"\"")
End if 
