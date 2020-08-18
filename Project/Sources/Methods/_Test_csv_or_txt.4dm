//%attributes = {}

C_TEXT:C284($importFilePath)
$importFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Test_Files"+Folder separator:K24:12+"Sample2000.csv"
$importFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Test_Files"+Folder separator:K24:12+"Sample2000.txt"  // Tab-delimited
If (File_DoesExist ($importFilePath))
	C_OBJECT:C1216($importObj)
	$importObj:=FileImporter_New ($importFilePath)
	FileImporter_DeclareColumn ($importObj;"Serial Number";"serialNo";Is longint:K8:6)
	FileImporter_DeclareColumn ($importObj;"Company Name";"company";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"Employee Markme";"employee";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"Description";"description";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"Leave";"numDaysTakenOnLeave";Is longint:K8:6)
	
	C_COLLECTION:C1488($importCollection)
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
		C_COLLECTION:C1488($companies)
		$companies:=$importCollection.distinct("company")
		
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