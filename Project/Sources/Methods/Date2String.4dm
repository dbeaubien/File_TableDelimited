//%attributes = {"invisible":true,"preemptive":"capable"}
  // Method: Date2String ( date {; formatStr} ) : formated date as string
  // Method: Date2String ( date {; text} ) : text
  //
  //   Supported formats: mm, m1, month, mon, dd, d1, day, dayShort, yyyy, yy
  //   Defaults to "mm/dd/yyyy".
  //   If a date of !00/00/00! is passed then a blank string is returned.
If (False)
  // ===============================================================
  // ---- PARAMETERS AND RESULTS ----
  //   $1 [in]: date to format
  //   $2 [optional in]: format to convert date to
  //   $0 [out]: formated date as string
  // ---- DESCRIPTION ----
  //   This method converts the date into a string as dictated by the
  //   optional format string. If the format string is not specified then
  //   it defaults to "mm/dd/yyyy".
  //
  //   If a date of !00/00/00! is passed then a blank string is returned.
  //
  //   The following is the text that is converted by the format string
  //   "mm" is converted to a two digit month
  //   "dd" is converted to a two digit day
  //   "yyyy" is converted to a four digit year
  //   "yy" is converted to a two digit year
  //   "month" is converted to the full month name
  //   "mon" is converted to an abbreviated month name
  //   "day" is converted to the full day name
  // ---- CHANGE HISTORY ----
  //   1999/02/28   DB   Created
  //   2000/03/21   DB   Modified to include the new header formating
  // ===============================================================
End if 
  //#Start method

C_DATE($1;$date2Convert)
C_TEXT($2;$0;$dateString)
C_LONGINT($Day;$Month;$Year;$WeekDay)
$date2Convert:=$1
If (Count parameters>=2)
$dateString:=$2
End if 

If ($dateString="")
$dateString:="mm/dd/yyyy"
End if 

If ($date2Convert=!00-00-00!)  // return blank string if date !00/00/00!
$dateString:=""

Else 
$Day:=Day of($date2Convert)
$Month:=Month of($date2Convert)
$Year:=Year of($date2Convert)
$WeekDay:=Day number($date2Convert)

C_TEXT($DayStr;$DayStr2;$MonthStr;$MonthStr2)
$DayStr:=String($Day)
$DayStr2:=String($Day;"00")
$MonthStr:=String($Month;"00")
$MonthStr2:=String($Month)

  // Put the year in the string
$dateString:=Replace string($dateString;"yyyy";String($Year))
$dateString:=Replace string($dateString;"yy";String(Mod($Year;100);"00"))

  // Put the Month in the string
$dateString:=Replace string($dateString;"mm";$MonthStr)
$dateString:=Replace string($dateString;"m1";$MonthStr2)
Case of 
: ($Month=1)
$dateString:=Replace string($dateString;"Month";"January")
$dateString:=Replace string($dateString;"Mon";"Jan")
: ($Month=2)
$dateString:=Replace string($dateString;"Month";"February")
$dateString:=Replace string($dateString;"Mon";"Feb")
: ($Month=3)
$dateString:=Replace string($dateString;"Month";"March")
$dateString:=Replace string($dateString;"Mon";"Mar")
: ($Month=4)
$dateString:=Replace string($dateString;"Month";"April")
$dateString:=Replace string($dateString;"Mon";"Apr")
: ($Month=5)
$dateString:=Replace string($dateString;"Month";"May")
$dateString:=Replace string($dateString;"Mon";"May")
: ($Month=6)
$dateString:=Replace string($dateString;"Month";"June")
$dateString:=Replace string($dateString;"Mon";"Jun")
: ($Month=7)
$dateString:=Replace string($dateString;"Month";"July")
$dateString:=Replace string($dateString;"Mon";"Jul")
: ($Month=8)
$dateString:=Replace string($dateString;"Month";"August")
$dateString:=Replace string($dateString;"Mon";"Aug")
: ($Month=9)
$dateString:=Replace string($dateString;"Month";"September")
$dateString:=Replace string($dateString;"Mon";"Sep")
: ($Month=10)
$dateString:=Replace string($dateString;"Month";"October")
$dateString:=Replace string($dateString;"Mon";"Oct")
: ($Month=11)
$dateString:=Replace string($dateString;"Month";"November")
$dateString:=Replace string($dateString;"Mon";"Nov")
: ($Month=12)
$dateString:=Replace string($dateString;"Month";"December")
$dateString:=Replace string($dateString;"Mon";"Dec")
End case 

Case of 
: ($WeekDay=1)
$dateString:=Replace string($dateString;"dayShort";"Sun")
$dateString:=Replace string($dateString;"day";"Sunday")
: ($WeekDay=2)
$dateString:=Replace string($dateString;"dayShort";"Mon")
$dateString:=Replace string($dateString;"day";"Monday")
: ($WeekDay=3)
$dateString:=Replace string($dateString;"dayShort";"Tue")
$dateString:=Replace string($dateString;"day";"Tuesday")
: ($WeekDay=4)
$dateString:=Replace string($dateString;"dayShort";"Wed")
$dateString:=Replace string($dateString;"day";"Wednesday")
: ($WeekDay=5)
$dateString:=Replace string($dateString;"dayShort";"Thu")
$dateString:=Replace string($dateString;"day";"Thursday")
: ($WeekDay=6)
$dateString:=Replace string($dateString;"dayShort";"Fri")
$dateString:=Replace string($dateString;"day";"Friday")
: ($WeekDay=7)
$dateString:=Replace string($dateString;"dayShort";"Sat")
$dateString:=Replace string($dateString;"day";"Saturday")
End case 

  // Put the day in the string
$dateString:=Replace string($dateString;"d1";$DayStr)
$dateString:=Replace string($dateString;"dd";$DayStr2)

End if 

$0:=$dateString

  //#End method