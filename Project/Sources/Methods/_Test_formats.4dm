//%attributes = {}


C_TEXT:C284($importFilePath)
$importFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Test_Files"+Folder separator:K24:12+"Student_Report.csv"
If (File_DoesExist ($importFilePath))
	
	C_OBJECT:C1216($importObj)
	$importObj:=FileImporter_New ($importFilePath)
	
	FileImporter_DeclareColumn ($importObj;"Internal Student ID";"id";Is longint:K8:6)
	FileImporter_DeclareColumn ($importObj;"First Name";"firstName";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"Middle Name";"middleName";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"Last Name";"lastName";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"Birthdate";"dob";Is date:K8:7)
	FileImporter_DeclareColumn ($importObj;"One Time Consent Date";"consentDate";Is date:K8:7)
	FileImporter_DeclareColumn ($importObj;"One Time Consent Y/N";"consentGiven";Is boolean:K8:9)
	
	FileImporter_DeclareColumn ($importObj;"Not in File";"NIF";Is longint:K8:6)
	FileImporter_DeclareColumn ($importObj;"Birthdate";"dob_AsStr";Is text:K8:3)
	FileImporter_DeclareColumn ($importObj;"One Time Consent Y/N";"consentGiven_AsStr";Is text:K8:3)
	
	C_COLLECTION:C1488($importCollection)
	$importCollection:=FileImporter_Load2Collection ($importObj)
	If ($importObj.status="success")
		
		C_COLLECTION:C1488($lastNamesCol;$firstNameCol)
		$lastNamesCol:=$importCollection.distinct("lastName")
		$firstNameCol:=$importCollection.distinct("firstName")
		
		C_OBJECT:C1216($rowObject)
		For each ($rowObject;$importCollection)
			
			
		End for each 
		
	Else 
		ALERT:C41("Failed with error \""+$importObj.errorMessage+"\".")
	End if 
	
Else 
	ALERT:C41("Test File not found!")
End if 