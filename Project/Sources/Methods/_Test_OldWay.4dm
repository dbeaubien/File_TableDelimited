//%attributes = {}


C_TEXT:C284($importFilePath)
$importFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Test_Files"+Folder separator:K24:12+"Sample2000.txt"  // Tab-delimited

If (File_DoesExist ($importFilePath))
	C_TEXT:C284($fileContents;$eol)
	$fileContents:=Document to text:C1236($importFilePath)
	$eol:=Choose:C955(Is macOS:C1572;"\r";"\r\n")  // CR for Mac, CRLF for Windows as per https://doc.4d.com/4Dv18/4D/18/Document-to-text.301-4504522.en.html
	
	C_COLLECTION:C1488($fileLinesCollection)
	$fileLinesCollection:=Split string:C1554($fileContents;$eol)
	
	C_COLLECTION:C1488($importCollection)
	$importCollection:=New collection:C1472
	
	C_TEXT:C284($oneLine)
	ARRAY TEXT:C222($at_lineDelimited;0)
	C_BOOLEAN:C305($headerRowProcessed)
	C_COLLECTION:C1488($linesPartsCollection)
	C_OBJECT:C1216($rowObj)
	C_LONGINT:C283($pos_serialNo;$pos_company;$pos_employee;$pos_description;$pos_numDaysTakenOnLeave)
	For each ($oneLine;$fileLinesCollection)
		$linesPartsCollection:=Split string:C1554($oneLine;"\t")
		
		If (Not:C34($headerRowProcessed))
			$headerRowProcessed:=True:C214
			$pos_serialNo:=$linesPartsCollection.indexOf("Serial Number")
			$pos_company:=$linesPartsCollection.indexOf("Company Name")
			$pos_employee:=$linesPartsCollection.indexOf("Employee Markme")
			$pos_description:=$linesPartsCollection.indexOf("Description")
			$pos_numDaysTakenOnLeave:=$linesPartsCollection.indexOf("Leave")
			
		Else 
			$rowObj:=New object:C1471
			$rowObj.serialNo:=Choose:C955($pos_serialNo>=0;Num:C11($linesPartsCollection[$pos_serialNo]);Null:C1517)
			$rowObj.company:=Choose:C955($pos_company>=0;$linesPartsCollection[$pos_company];Null:C1517)
			$rowObj.employee:=Choose:C955($pos_employee>=0;$linesPartsCollection[$pos_employee];Null:C1517)
			$rowObj.description:=Choose:C955($pos_description>=0;$linesPartsCollection[$pos_description];Null:C1517)
			$rowObj.numDaysTakenOnLeave:=Choose:C955($pos_numDaysTakenOnLeave>=0;Num:C11($linesPartsCollection[$pos_numDaysTakenOnLeave]);Null:C1517)
			$importCollection.push($rowObj)
		End if 
	End for each 
	
	
	C_COLLECTION:C1488($companies)
	$companies:=$importCollection.distinct("company")
	
	C_OBJECT:C1216($rowObject)
	For each ($rowObject;$importCollection)
		
		
	End for each 
	
	
Else 
	ALERT:C41("Test File not found!")
End if 