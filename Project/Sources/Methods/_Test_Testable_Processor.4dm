//%attributes = {}
  // _Test_Testable_Processor (importObj) 
  //
  // DESCRIPTION
  //   Processes the data contained within the import object.

C_OBJECT:C1216($1;$importObj)

ASSERT:C1129(Count parameters:C259=1)
$importObj:=$1

If ($importObj.status="success")
	C_COLLECTION:C1488($importCollection)
	$importCollection:=$importObj.importedData
	
/* At this point, $importCollection is a collection of objects with this structure
{
 "serialNo":9788189999599,
 "company":"TALES OF SHIVA",
 "employee":"Mark",
 "description":"mark",
 "numDaysTakenOnLeave":0
}
*/
	
	C_OBJECT:C1216($rowObject)
	For each ($rowObject;$importCollection)
		
		  // ...  do what ever processing of the row represented by $rowObject ...
		
	End for each 
	
End if 