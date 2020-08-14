//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // FileImporter_DeclareColumn (importObject, headerLabel, objectAttribute, type)
  // FileImporter_DeclareColumn (object, text, text, longint)
  //
  // DESCRIPTION
  //   Adds the declared column definition to the import object.
  //
C_OBJECT:C1216($1;$importObject)
C_TEXT:C284($2;$headerLabel)
C_TEXT:C284($3;$objectAttribute)
C_LONGINT:C283($4;$type)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (08/22/2019)
  // ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=4))
	$importObject:=$1
	$headerLabel:=$2
	$objectAttribute:=$3
	$type:=$4
	
	Case of   // test if defined
		: (Undefined:C82($importObject))
		: ($importObject=Null:C1517)
		: ($importObject.importFilePath="")
		Else 
			C_OBJECT:C1216($columnDefnObj)
			$columnDefnObj:=New object:C1471
			$columnDefnObj.headerLabel:=$headerLabel
			$columnDefnObj.objectAttributeName:=$objectAttribute
			$columnDefnObj.valueType:=$type
			$columnDefnObj.columnPosition:=-1
			
			$importObject.columnDefinitions.push($columnDefnObj)
	End case 
	
End if 