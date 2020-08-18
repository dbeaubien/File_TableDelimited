//%attributes = {"invisible":true,"preemptive":"capable"}
  // STR_isIntegerNumber (NumAsStr) : IsInteger
  // STR_isIntegerNumber (text) : boolean
  // 
  // DESCRIPTION
  //   Returns true is the string passed is an integer.
  //
C_TEXT:C284($1;$srcText)
C_BOOLEAN:C305($0;$isFormattedCorrectly)

$isFormattedCorrectly:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$srcText:=$1
	
	C_LONGINT:C283($i)
	C_TEXT:C284($curChar)
	$isFormattedCorrectly:=True:C214  // assume all is good
	For ($i;1;Length:C16($srcText))
		$curChar:=$srcText[[$i]]
		Case of 
			: ($curChar="-") & ($i=1)  // ignore these
			: ($curChar=",")  // ignore these
			: ($curChar="0")
			: ($curChar="1")
			: ($curChar="2")
			: ($curChar="3")
			: ($curChar="4")
			: ($curChar="5")
			: ($curChar="6")
			: ($curChar="7")
			: ($curChar="8")
			: ($curChar="9")
			Else 
				$isFormattedCorrectly:=False:C215
				$i:=1000000  // break our loop
		End case 
	End for 
	
End if 
$0:=$isFormattedCorrectly