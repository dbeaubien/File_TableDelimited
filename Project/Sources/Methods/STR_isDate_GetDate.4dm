//%attributes = {"invisible":true,"preemptive":"capable"}
  // STR_isDate_GetDate (srcText) : date
  // STR_isDate_GetDate (text) : date
  // 
  // DESCRIPTION
  //   Returns true is the passed date matches the
  //   "MM/DD/YYYY" or "MM/DD/YY" date format.

C_TEXT:C284($1;$vt_srcText)
C_DATE:C307($0;$vd_theDate)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (2020-02-14)
  // ----------------------------------------------------

$vd_theDate:=!00-00-00!
If (Asserted:C1132(Count parameters:C259=1))
	$vt_srcText:=$1
	
	C_BOOLEAN:C305($vb_isFormattedCorrectly)
	$vb_isFormattedCorrectly:=False:C215
	
	If (Length:C16($vt_srcText)>=6)
		
		If ($vt_srcText[[2]]="/")  // guessing that it is m/dd/yyyy?
			$vt_srcText:="0"+$vt_srcText
		End if 
		
		If ($vt_srcText[[5]]="/")  // guessing that it is mm/d/yyyy?
			$vt_srcText:=Substring:C12($vt_srcText;1;3)+"0"+Substring:C12($vt_srcText;4)
		End if 
		
		If (Length:C16($vt_srcText)=8)  // expecting this format MM/DD/YYYY
			If ($vt_srcText[[3]]="/") & ($vt_srcText[[6]]="/")
				$vt_theMonth:=Substring:C12($vt_srcText;1;2)
				$vt_theDay:=Substring:C12($vt_srcText;4;2)
				$vt_theYear:=Substring:C12($vt_srcText;7;2)
				
				If (STR_isIntegerNumber ($vt_theMonth) & STR_isIntegerNumber ($vt_theDay) & STR_isIntegerNumber ($vt_theYear))  // Ensure there is a "real" number
					C_LONGINT:C283($vl_theMonth;$vl_theDay;$vl_theYear)
					$vl_theMonth:=Num:C11($vt_theMonth)
					$vl_theDay:=Num:C11($vt_theDay)
					$vl_theYear:=Num:C11($vt_theYear)
					
					If ($vl_theMonth>0) & ($vl_theDay>0)
						If ($vl_theYear>40)
							$vl_theYear:=$vl_theYear+1900
						Else 
							$vl_theYear:=$vl_theYear+2000
						End if 
						
						C_DATE:C307($vd_theDate)
						$vd_theDate:=Add to date:C393(!00-00-00!;$vl_theYear;$vl_theMonth;$vl_theDay)
						If (Date2String ($vd_theDate;"mm/dd/yy")=$vt_srcText)  // makes sure that the date is valid (eg not 2/31/2001)
							$vb_isFormattedCorrectly:=True:C214
						End if 
					End if 
				End if 
			End if 
		End if 
		
		
		C_TEXT:C284($vt_theMonth;$vt_theDay;$vt_theYear)
		If (Length:C16($vt_srcText)=10)  // expecting this format MM/DD/YYYY
			If ($vt_srcText[[3]]="/") & ($vt_srcText[[6]]="/")
				$vt_theMonth:=Substring:C12($vt_srcText;1;2)
				$vt_theDay:=Substring:C12($vt_srcText;4;2)
				$vt_theYear:=Substring:C12($vt_srcText;7;4)
				
				If (STR_isIntegerNumber ($vt_theMonth) & STR_isIntegerNumber ($vt_theDay) & STR_isIntegerNumber ($vt_theYear))
					$vd_theDate:=Add to date:C393(!00-00-00!;Num:C11($vt_theYear);Num:C11($vt_theMonth);Num:C11($vt_theDay))
					If (Date2String ($vd_theDate;"mm/dd/yyyy")=$vt_srcText)  // makes sure that the date is valid (eg not 2/31/2001)
						$vb_isFormattedCorrectly:=True:C214
					End if 
				End if 
			End if 
		End if 
		
	End if 
	
	If (Not:C34($vb_isFormattedCorrectly))
		$vd_theDate:=!00-00-00!
	End if 
End if   // ASSERT
$0:=$vd_theDate