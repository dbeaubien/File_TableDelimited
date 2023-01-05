//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileImporter_RowStart (importObject, rowStart)
//
// DESCRIPTION
//   sets the row to get the header from
//
#DECLARE($importObject : Object; $rowStart : Integer)
// ----------------------------------------------------
// HISTORY
//   Created by: Guy Algot (03/28/2022)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

Case of   // test if defined
	: (Undefined:C82($importObject))
	: ($importObject=Null:C1517)
	: ($importObject.importFilePath="")
	Else 
		$importObject.rowStart:=$rowStart
End case 