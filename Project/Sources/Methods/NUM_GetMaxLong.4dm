//%attributes = {"invisible":true,"preemptive":"capable"}
  // NUM_GetMaxLongint (long1; long2): maxLong
  // NUM_GetMaxLongint (long; long): long
  // 
  // DESCRIPTION
  //   Returns the larger of the two Longints

C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($0)

If (Asserted:C1132(Count parameters:C259=2))
	
	If ($1>$2)
		$0:=$1
	Else 
		$0:=$2
	End if 
	
End if   // ASSERT
