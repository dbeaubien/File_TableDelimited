//%attributes = {"invisible":true,"preemptive":"capable"}
  // STR_isIntegerNumber (NumAsStr) : IsInteger
  // STR_isIntegerNumber (text) : boolean
  // 
  // DESCRIPTION
  //   Returns true is the string passed is an integer.
  //
C_TEXT:C284($1;$vt_srcText)
C_BOOLEAN:C305($0;$vb_isFormattedCorrectly)

$vb_isFormattedCorrectly:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$vt_srcText:=$1
	
	C_LONGINT:C283($i)
	C_TEXT:C284($vt_curChar)
	$vb_isFormattedCorrectly:=True:C214  // assume all is good
	For ($i;1;Length:C16($vt_srcText))
		$vt_curChar:=$vt_srcText[[$i]]
		Case of 
			: ($vt_curChar="-") & ($i=1)  // ignore these
			: ($vt_curChar=",")  // ignore these
			: ($vt_curChar="0")
			: ($vt_curChar="1")
			: ($vt_curChar="2")
			: ($vt_curChar="3")
			: ($vt_curChar="4")
			: ($vt_curChar="5")
			: ($vt_curChar="6")
			: ($vt_curChar="7")
			: ($vt_curChar="8")
			: ($vt_curChar="9")
			Else 
				$vb_isFormattedCorrectly:=False:C215
				$i:=1000000  // break our loop
		End case 
	End for 
	
End if 
$0:=$vb_isFormattedCorrectly