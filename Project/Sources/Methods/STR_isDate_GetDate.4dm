//%attributes = {"invisible":true,"preemptive":"capable"}
  // STR_isDate_GetDate (srcText) : date
  // STR_isDate_GetDate (text) : date
  // 
  // DESCRIPTION
  //   Returns true is the passed date matches the
  //   "MM/DD/YYYY" or "MM/DD/YY" date format.

C_TEXT:C284($1;$srcText)
C_DATE:C307($0;$vd_theDate)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (2020-02-14)
  // ----------------------------------------------------

$vd_theDate:=!00-00-00!
If (Asserted:C1132(Count parameters:C259=1))
	$srcText:=$1
	
	C_BOOLEAN:C305($isFormattedCorrectly)
	$isFormattedCorrectly:=False:C215
	
	If (Length:C16($srcText)>=6)
		
		If ($srcText[[2]]="/")  // guessing that it is m/dd/yyyy?
			$srcText:="0"+$srcText
		End if 
		
		If ($srcText[[5]]="/")  // guessing that it is mm/d/yyyy?
			$srcText:=Substring:C12($srcText;1;3)+"0"+Substring:C12($srcText;4)
		End if 
		
		If (Length:C16($srcText)=8)  // expecting this format MM/DD/YYYY
			If ($srcText[[3]]="/") & ($srcText[[6]]="/")
				C_TEXT:C284($theMonth;$theDay;$theYear)
				$theMonth:=Substring:C12($srcText;1;2)
				$theDay:=Substring:C12($srcText;4;2)
				$theYear:=Substring:C12($srcText;7;2)
				
				If (STR_isIntegerNumber ($theMonth) & STR_isIntegerNumber ($theDay) & STR_isIntegerNumber ($theYear))  // Ensure there is a "real" number
					C_LONGINT:C283($month;$day;$year)
					$month:=Num:C11($theMonth)
					$day:=Num:C11($theDay)
					$year:=Num:C11($theYear)
					
					If ($month>0) & ($day>0)
						If ($year>40)
							$year:=$year+1900
						Else 
							$year:=$year+2000
						End if 
						
						C_DATE:C307($vd_theDate)
						$vd_theDate:=Add to date:C393(!00-00-00!;$year;$month;$day)
						If (Date2String ($vd_theDate;"mm/dd/yy")=$srcText)  // makes sure that the date is valid (eg not 2/31/2001)
							$isFormattedCorrectly:=True:C214
						End if 
					End if 
				End if 
			End if 
		End if 
		
		
		If (Length:C16($srcText)=10)  // expecting this format MM/DD/YYYY
			If ($srcText[[3]]="/") & ($srcText[[6]]="/")
				$theMonth:=Substring:C12($srcText;1;2)
				$theDay:=Substring:C12($srcText;4;2)
				$theYear:=Substring:C12($srcText;7;4)
				
				If (STR_isIntegerNumber ($theMonth) & STR_isIntegerNumber ($theDay) & STR_isIntegerNumber ($theYear))
					$vd_theDate:=Add to date:C393(!00-00-00!;Num:C11($theYear);Num:C11($theMonth);Num:C11($theDay))
					If (Date2String ($vd_theDate;"mm/dd/yyyy")=$srcText)  // makes sure that the date is valid (eg not 2/31/2001)
						$isFormattedCorrectly:=True:C214
					End if 
				End if 
			End if 
		End if 
		
	End if 
	
	If (Not:C34($isFormattedCorrectly))
		$vd_theDate:=!00-00-00!
	End if 
End if   // ASSERT
$0:=$vd_theDate