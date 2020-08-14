  //%attributes = {"invisible":true,"preemptive":"capable","lang":"en"} comment added and reserved by 4D.
  // OnErr_GetLastErrorMessages () : errorMessages
  //
  // DESCRIPTION
  //   Returns the text of the last error encountered.
  //
C_TEXT($0)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (2020-02-14)
  // ----------------------------------------------------

$0:=""

C_LONGINT($i)
For ($i;1;Size of array(gErrorTextArr))
If ($i#1)
$0:=$0+Char(Carriage return)
End if 
$0:=$0+gErrorTextArr{$i}
End for 
