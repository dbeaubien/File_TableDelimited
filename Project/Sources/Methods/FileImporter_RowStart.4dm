//%attributes = {"shared":true}

// FileImporter_RowStart (importObject, rowStart)
// FileImporter_DeclareColumn (object, longint)
//
// DESCRIPTION
//   sets the row to get the header from
//
C_OBJECT:C1216($1; $importObject)
C_LONGINT:C283($2; $rowStart)

// ----------------------------------------------------
// HISTORY
//   Created by: Guy Algot (03/28/2022)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	$importObject:=$1
	$rowStart:=$2
	
	Case of   // test if defined
		: (Undefined:C82($importObject))
		: ($importObject=Null:C1517)
		: ($importObject.importFilePath="")
		Else 
			$importObject.rowStart:=$rowStart
	End case 
	
End if 