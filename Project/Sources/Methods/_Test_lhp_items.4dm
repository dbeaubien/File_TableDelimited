//%attributes = {}

C_TEXT:C284($importFilePath)
$importFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"sample files"+Folder separator:K24:12+"lhp_items.csv"
If (File_DoesExist ($importFilePath))
	C_OBJECT:C1216($importObj)
	$importObj:=FileImporter_New ($importFilePath)
	FileImporter_DeclareColumn ($importObj;"Key";"key";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"Description";"description";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"MSRP";"msrp";Is real:K8:4)
	FileImporter_DeclareColumn ($importObj;"Wholesale";"wholesalePrice";Is real:K8:4)
	FileImporter_DeclareColumn ($importObj;"Cost";"actualCost";Is real:K8:4)
	
	C_COLLECTION:C1488($importCollection)
	$importCollection:=FileImporter_Load2Collection ($importObj)
	If ($importObj.status="success")
		
/* At this point, $importCollection is a collection of objects with this structure
{
 "key":"022AR",
 "description":"Burner/C1A,C1B & DFC1 Models",
 "msrp":107,
 "wholesalePrice":53.50,
 "actualCost":55.11
}
*/
		
		C_OBJECT:C1216($rowObject)
		For each ($rowObject;$importCollection)
			
			  // ...  do what ever processing of the row represented by $rowObject ...
			
		End for each 
		
	Else 
		ALERT:C41("Failed with error \""+$importObj.errorMessage+"\".")
	End if 
	
Else 
	ALERT:C41("Test File not found!")
End if 