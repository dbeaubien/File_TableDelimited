//%attributes = {"invisible":true,"preemptive":"capable"}
  // STR_isISODate (srcText) : isDate
  // STR_isISODate (text) : boolean
  // 
  // DESCRIPTION
  //   Returns true is the passed date starts with
  //   "YYYY-MM-DD" date format. Any time information is ignored.

C_TEXT:C284($1;$srcText)
C_BOOLEAN:C305($0;$isFormattedCorrectly)

$isFormattedCorrectly:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$srcText:=$1
	
	If (Length:C16($srcText)>=10)
		$srcText:=Substring:C12($srcText;1;10)  // Reduce to just the date part (in case there is more)
		
		C_COLLECTION:C1488($dateStringParts)
		$dateStringParts:=Split string:C1554($srcText;"-")
		If ($dateStringParts.length=3)
			C_TEXT:C284($theMonthAsStr;$theDayAsStr;$theYearAsStr)
			$theYearAsStr:=$dateStringParts[0]
			$theMonthAsStr:=$dateStringParts[1]
			$theDayAsStr:=$dateStringParts[2]
			
			If (STR_isIntegerNumber ($theYearAsStr) & STR_isIntegerNumber ($theMonthAsStr) & STR_isIntegerNumber ($theDayAsStr))
				C_DATE:C307($vd_theDate)
				$vd_theDate:=Add to date:C393(!00-00-00!;Num:C11($theYearAsStr);Num:C11($theMonthAsStr);Num:C11($theDayAsStr))
				If (Date2String ($vd_theDate;"yyyy-mm-dd")=$srcText)  // makes sure that the date is valid
					$isFormattedCorrectly:=True:C214
				End if 
			End if 
		End if 
		
	Else 
		$isFormattedCorrectly:=False:C215  // no date so it is not good
	End if 
End if 
$0:=$isFormattedCorrectly