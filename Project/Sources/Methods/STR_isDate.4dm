//%attributes = {"invisible":true,"preemptive":"capable"}
  // STR_isDate (srcText) : isDate
  // STR_isDate (text) : boolean
  // 
  // DESCRIPTION
  //   Returns true is the passed date matches the
  //   "MM/DD/YYYY" or "MM/DD/YY" date format.

C_TEXT:C284($1;$vt_srcText)
C_BOOLEAN:C305($0;$vb_isFormattedCorrectly)

$vb_isFormattedCorrectly:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$vt_srcText:=$1
	
	$vb_isFormattedCorrectly:=(STR_isDate_GetDate ($vt_srcText)#!00-00-00!)
End if 
$0:=$vb_isFormattedCorrectly