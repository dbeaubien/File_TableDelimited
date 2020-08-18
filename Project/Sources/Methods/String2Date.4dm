//%attributes = {"invisible":true,"preemptive":"capable"}
  // String2Date (dateString; expectedFormat) : convertedDate
  // String2Date (text; text) : date
  // 
  // DESCRIPTION
  //   A generic method for converting a date string into an actual date
  //
C_TEXT:C284($1;$dateStr)
C_TEXT:C284($2;$dateFormat)
C_DATE:C307($0;$vd_theDate)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (12/31/05)
  //   Mod: DB (12/13/2011) - Support "MON"
  //   Mod: DB (01/24/2014) - Totally rewritten to support single digit numbers. Support 1/2/3 as a valid date.
  // ----------------------------------------------------

$vd_theDate:=!00-00-00!
If (Asserted:C1132(Count parameters:C259=2))
	$dateStr:=$1
	$dateFormat:=$2
	
	ARRAY LONGINT:C221($al_extractedNos;3)
	ARRAY TEXT:C222($at_formatType;0)
	ARRAY LONGINT:C221($al_formatPos;0)
	ARRAY LONGINT:C221($al_formatLen;0)
	
	  // Get the position in the format string of the year
	C_LONGINT:C283($yearPos;$yearLen)
	C_TEXT:C284($yearFormatStr)
	If (True:C214)
		$yearPos:=Position:C15("yyyy";$dateFormat)
		$yearLen:=4
		$yearFormatStr:="yyyy"
		If ($yearPos<=0)
			$yearPos:=Position:C15("yy";$dateFormat)
			$yearLen:=2
			$yearFormatStr:="yy"
			If ($yearPos<=0)
				$yearPos:=-1
				$yearLen:=0
				$yearFormatStr:=""
			End if 
		End if 
	End if 
	APPEND TO ARRAY:C911($at_formatType;"y")  // represents year (temp)
	APPEND TO ARRAY:C911($al_formatPos;$yearPos)
	APPEND TO ARRAY:C911($al_formatLen;$yearLen)
	
	
	  // Get the position in the format string of the month
	C_LONGINT:C283($monthPos;$monthLen)
	C_TEXT:C284($monthFormatStr)
	If (True:C214)
		$monthPos:=Position:C15("mm";$dateFormat)
		$monthLen:=2
		$monthFormatStr:="mm"
		If ($monthPos<=0)
			$monthPos:=Position:C15("mon";$dateFormat)
			$monthLen:=3
			$monthFormatStr:="mon"
			If ($monthPos<=0)
				$monthPos:=-1
				$monthLen:=0
				$monthFormatStr:=""
			End if 
		End if 
	End if 
	APPEND TO ARRAY:C911($at_formatType;"m")  // represents month (temp)
	APPEND TO ARRAY:C911($al_formatPos;$monthPos)
	APPEND TO ARRAY:C911($al_formatLen;$monthLen)
	
	
	  // Get the position in the format string of the month
	C_LONGINT:C283($dayPos;$dayLen)
	C_TEXT:C284($dayFormatStr)
	If (True:C214)
		$dayPos:=Position:C15("dd";$dateFormat)
		$dayLen:=2
		$dayFormatStr:="dd"
		If ($dayPos<=0)
			$dayPos:=-1
			$dayLen:=0
			$dayFormatStr:=""
		End if 
	End if 
	APPEND TO ARRAY:C911($at_formatType;"d")  // represents day (temp)
	APPEND TO ARRAY:C911($al_formatPos;$dayPos)
	APPEND TO ARRAY:C911($al_formatLen;$dayLen)
	
	
	C_LONGINT:C283($YearArrayElement)
	C_LONGINT:C283($MonthArrayElement)
	C_LONGINT:C283($DayArrayElement)
	SORT ARRAY:C229($al_formatPos;$al_formatLen;$at_formatType;>)
	$YearArrayElement:=Find in array:C230($at_formatType;"y")
	$MonthArrayElement:=Find in array:C230($at_formatType;"m")
	$DayArrayElement:=Find in array:C230($at_formatType;"d")
	
	
	C_LONGINT:C283($i;$offset)
	$offset:=0
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
			
			C_TEXT:C284($tmpStr;$tmpStr2)
			C_LONGINT:C283($month)
			$tmpStr:=Substring:C12($dateStr;$al_formatPos{$i}+$offset)
			If ($al_formatLen{$i}<Length:C16($tmpStr))
				$tmpStr2:=Substring:C12($tmpStr;1;$al_formatLen{$i})
				If ($i=$MonthArrayElement) & ($monthFormatStr="mon")  // Month is the only variant
					Case of 
						: ($tmpStr2="Jan")
							$month:=1
						: ($tmpStr2="Feb")
							$month:=2
						: ($tmpStr2="Mar")
							$month:=3
						: ($tmpStr2="Apr")
							$month:=4
						: ($tmpStr2="May")
							$month:=5
						: ($tmpStr2="Jun")
							$month:=6
						: ($tmpStr2="Jul")
							$month:=7
						: ($tmpStr2="Aug")
							$month:=8
						: ($tmpStr2="Sep")
							$month:=9
						: ($tmpStr2="Oct")
							$month:=10
						: ($tmpStr2="Nov")
							$month:=11
						: ($tmpStr2="Dec")
							$month:=12
						Else 
							$month:=Month of:C24(Current date:C33)
					End case 
					$al_extractedNos{$i}:=$month
					
				Else 
					If (STR_isIntegerNumber ($tmpStr2))
						$al_extractedNos{$i}:=Num:C11($tmpStr2)
					Else 
						  // Check to see if we where given a 1 digit number
						
						$tmpStr2:=Substring:C12($tmpStr2;1;Length:C16($tmpStr2)-1)
						$offset:=$offset-1
						If (STR_isIntegerNumber ($tmpStr2))
							$al_extractedNos{$i}:=Num:C11($tmpStr2)
						End if 
					End if 
					
				End if 
				
			Else 
				$al_extractedNos{$i}:=Num:C11($tmpStr)
			End if 
			
			
		End if 
		
	End for 
	
	C_LONGINT:C283($year;$day)
	$year:=$al_extractedNos{$YearArrayElement}
	If ($year<100)  // did we get a 2 digit year?
		$year:=$year+2000
	End if 
	$month:=$al_extractedNos{$MonthArrayElement}
	$day:=$al_extractedNos{$DayArrayElement}
	
	
	  // Convert to a date
	$vd_theDate:=Add to date:C393(!00-00-00!;$year;$month;$day)
	
End if 
$0:=$vd_theDate