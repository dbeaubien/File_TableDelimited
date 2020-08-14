//%attributes = {"invisible":true,"preemptive":"capable"}
  // Array_SetSize (desiredSize; arrayPtr ... arrayPtr)
  //
  // DESCRIPTION
  //   Changes the size of one or multiple arrays

C_LONGINT:C283($1;$size;$param)
C_POINTER:C301(${2};$array)

OnErr_Install_Handler ("OnErr_GENERIC")
$size:=$1

C_LONGINT:C283($param)
For ($param;2;Count parameters:C259)
	$array:=${$param}
	ASSERT:C1129(PTR_IsArray ($array);Current method name:C684+" $"+String:C10($param)+" is not an array ptr.")
	
	C_LONGINT:C283($currentSize)
	$currentSize:=Size of array:C274($array->)
	Case of 
		: ($currentSize<$size)
			INSERT IN ARRAY:C227($array->;$currentSize+1;$size-$currentSize)
		: ($currentSize>$size)
			DELETE FROM ARRAY:C228($array->;$size+1;$currentSize-$size)
	End case 
	
End for 

OnErr_Install_Handler 
