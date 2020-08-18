//%attributes = {"invisible":true,"preemptive":"capable"}
  // STR_isDate (srcText) : isDate
  // STR_isDate (text) : boolean
  // 
  // DESCRIPTION
  //   Returns true is the passed date matches the
  //   "MM/DD/YYYY" or "MM/DD/YY" date format.

C_TEXT:C284($1;$srcText)
C_BOOLEAN:C305($0;$isFormattedCorrectly)

$isFormattedCorrectly:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$srcText:=$1
	
	$isFormattedCorrectly:=(STR_isDate_GetDate ($srcText)#!00-00-00!)
End if 
$0:=$isFormattedCorrectly