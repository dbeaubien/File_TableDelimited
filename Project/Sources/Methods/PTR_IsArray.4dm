//%attributes = {"invisible":true,"preemptive":"capable"}
  // PTR_IsArray (pointer) : isArray
  // PTR_IsArray (pointer) : boolean
  //
  // DESCRIPTION
  //   Returns true if the passed pointer is a pointer to
  //   an array.
  //
C_POINTER($1;$ptr)
C_BOOLEAN($0;$isArray)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (02/25/2020)
  // ----------------------------------------------------

$isArray:=False
If (Asserted(Count parameters=1))
$ptr:=$1

Case of 
: (Type($ptr)#Is pointer)

: (Is nil pointer($ptr))

Else 
$isArray:=True

C_LONGINT($type)
$type:=Type($ptr->)
Case of 
: ($type=Blob array)
: ($type=Boolean array)
: ($type=Date array)
: ($type=Integer array)
: ($type=LongInt array)
: ($type=Object array)
: ($type=Picture array)
: ($type=Pointer array)
: ($type=Real array)
: ($type=Text array)
: ($type=Time array)
Else 
$isArray:=False
End case 
End case 

End if 
$0:=$isArray