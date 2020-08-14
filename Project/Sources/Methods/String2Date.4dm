//%attributes = {"invisible":true,"preemptive":"capable"}
  // String2Date (dateString; expectedFormat) : convertedDate
  // String2Date (text; text) : date
  // 
  // DESCRIPTION
  //   A generic method for converting a date string into an actual date
  //
C_TEXT:C284($1;$vt_dateStr)
C_TEXT:C284($2;$vt_dateFormat)
C_DATE:C307($0;$vd_theDate)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (12/31/05)
  //   Mod: DB (12/13/2011) - Support "MON"
  //   Mod: DB (01/24/2014) - Totally rewritten to support single digit numbers. Support 1/2/3 as a valid date.
  // ----------------------------------------------------

$vd_theDate:=!00-00-00!
If (Asserted:C1132(Count parameters:C259=2))
	$vt_dateStr:=$1
	$vt_dateFormat:=$2
	
	ARRAY LONGINT:C221($al_extractedNos;3)
	ARRAY TEXT:C222($at_formatType;0)
	ARRAY LONGINT:C221($al_formatPos;0)
	ARRAY LONGINT:C221($al_formatLen;0)
	
	  // Get the position in the format string of the year
	C_LONGINT:C283($vl_yearPos;$vl_yearLen)
	C_TEXT:C284($vt_yearFormatStr)
	If (True:C214)
		$vl_yearPos:=Position:C15("yyyy";$vt_dateFormat)
		$vl_yearLen:=4
		$vt_yearFormatStr:="yyyy"
		If ($vl_yearPos<=0)
			$vl_yearPos:=Position:C15("yy";$vt_dateFormat)
			$vl_yearLen:=2
			$vt_yearFormatStr:="yy"
			If ($vl_yearPos<=0)
				$vl_yearPos:=-1
				$vl_yearLen:=0
				$vt_yearFormatStr:=""
			End if 
		End if 
	End if 
	APPEND TO ARRAY:C911($at_formatType;"y")  // represents year (temp)
	APPEND TO ARRAY:C911($al_formatPos;$vl_yearPos)
	APPEND TO ARRAY:C911($al_formatLen;$vl_yearLen)
	
	
	  // Get the position in the format string of the month
	C_LONGINT:C283($vl_monthPos;$vl_monthLen)
	C_TEXT:C284($vt_monthFormatStr)
	If (True:C214)
		$vl_monthPos:=Position:C15("mm";$vt_dateFormat)
		$vl_monthLen:=2
		$vt_monthFormatStr:="mm"
		If ($vl_monthPos<=0)
			$vl_monthPos:=Position:C15("mon";$vt_dateFormat)
			$vl_monthLen:=3
			$vt_monthFormatStr:="mon"
			If ($vl_monthPos<=0)
				$vl_monthPos:=-1
				$vl_monthLen:=0
				$vt_monthFormatStr:=""
			End if 
		End if 
	End if 
	APPEND TO ARRAY:C911($at_formatType;"m")  // represents month (temp)
	APPEND TO ARRAY:C911($al_formatPos;$vl_monthPos)
	APPEND TO ARRAY:C911($al_formatLen;$vl_monthLen)
	
	
	  // Get the position in the format string of the month
	C_LONGINT:C283($vl_dayPos;$vl_dayLen)
	C_TEXT:C284($vt_dayFormatStr)
	If (True:C214)
		$vl_dayPos:=Position:C15("dd";$vt_dateFormat)
		$vl_dayLen:=2
		$vt_dayFormatStr:="dd"
		If ($vl_dayPos<=0)
			$vl_dayPos:=-1
			$vl_dayLen:=0
			$vt_dayFormatStr:=""
		End if 
	End if 
	APPEND TO ARRAY:C911($at_formatType;"d")  // represents day (temp)
	APPEND TO ARRAY:C911($al_formatPos;$vl_dayPos)
	APPEND TO ARRAY:C911($al_formatLen;$vl_dayLen)
	
	
	C_LONGINT:C283($vl_YearArrayElement)
	C_LONGINT:C283($vl_MonthArrayElement)
	C_LONGINT:C283($vl_DayArrayElement)
	SORT ARRAY:C229($al_formatPos;$al_formatLen;$at_formatType;>)
	$vl_YearArrayElement:=Find in array:C230($at_formatType;"y")
	$vl_MonthArrayElement:=Find in array:C230($at_formatType;"m")
	$vl_DayArrayElement:=Find in array:C230($at_formatType;"d")
	
	
	C_LONGINT:C283($i;$vl_offset)
	$vl_offset:=0
	For ($i;1;3)
		
		If ($al_formatLen{$i}=0)
			Case of 
				: ($at_formatType{$i}="d")
					$al_extractedNos{$i}:=Day of:C23(Current date:C33)
				: ($at_formatType{$i}="m")
					$al_extractedNos{$i}:=Month of:C24(Current date:C33)
				: ($at_formatType{$i}="y")
					$al_extractedNos{$i}:=Year of:C25(Current date:C33)
			End case 
			
		Else 
			
			C_TEXT:C284($vt_tmpStr;$vt_tmpStr2)
			C_LONGINT:C283($vl_month)
			$vt_tmpStr:=Substring:C12($vt_dateStr;$al_formatPos{$i}+$vl_offset)
			If ($al_formatLen{$i}<Length:C16($vt_tmpStr))
				$vt_tmpStr2:=Substring:C12($vt_tmpStr;1;$al_formatLen{$i})
				If ($i=$vl_MonthArrayElement) & ($vt_monthFormatStr="mon")  // Month is the only variant
					Case of 
						: ($vt_tmpStr2="Jan")
							$vl_month:=1
						: ($vt_tmpStr2="Feb")
							$vl_month:=2
						: ($vt_tmpStr2="Mar")
							$vl_month:=3
						: ($vt_tmpStr2="Apr")
							$vl_month:=4
						: ($vt_tmpStr2="May")
							$vl_month:=5
						: ($vt_tmpStr2="Jun")
							$vl_month:=6
						: ($vt_tmpStr2="Jul")
							$vl_month:=7
						: ($vt_tmpStr2="Aug")
							$vl_month:=8
						: ($vt_tmpStr2="Sep")
							$vl_month:=9
						: ($vt_tmpStr2="Oct")
							$vl_month:=10
						: ($vt_tmpStr2="Nov")
							$vl_month:=11
						: ($vt_tmpStr2="Dec")
							$vl_month:=12
						Else 
							$vl_month:=Month of:C24(Current date:C33)
					End case 
					$al_extractedNos{$i}:=$vl_month
					
				Else 
					If (STR_isIntegerNumber ($vt_tmpStr2))
						$al_extractedNos{$i}:=Num:C11($vt_tmpStr2)
					Else 
						  // Check to see if we where given a 1 digit number
						
						$vt_tmpStr2:=Substring:C12($vt_tmpStr2;1;Length:C16($vt_tmpStr2)-1)
						$vl_offset:=$vl_offset-1
						If (STR_isIntegerNumber ($vt_tmpStr2))
							$al_extractedNos{$i}:=Num:C11($vt_tmpStr2)
						End if 
					End if 
					
				End if 
				
			Else 
				$al_extractedNos{$i}:=Num:C11($vt_tmpStr)
			End if 
			
			
		End if 
		
	End for 
	
	C_LONGINT:C283($vl_year;$vl_day)
	$vl_year:=$al_extractedNos{$vl_YearArrayElement}
	If ($vl_year<100)  // did we get a 2 digit year?
		$vl_year:=$vl_year+2000
	End if 
	$vl_month:=$al_extractedNos{$vl_MonthArrayElement}
	$vl_day:=$al_extractedNos{$vl_DayArrayElement}
	
	
	  // Convert to a date
	$vd_theDate:=Add to date:C393(!00-00-00!;$vl_year;$vl_month;$vl_day)
	
End if 
$0:=$vd_theDate