  //%attributes = {"invisible":true,"preemptive":"capable","lang":"en"} comment added and reserved by 4D.
  // OnErr_GENERIC_Minimal ()
  //
  // DESCRIPTION
  //   The simplest error handler. No external logging.
  //
  // ----------------------------------------------------
  // HISTORY
  //   Mod by: Dani Beaubien (9/9/13) - Enhanced the information that is coming out
  //   Mod by: Dani Beaubien (2020-02-14) - Added gErrorTextArr
  // ----------------------------------------------------

ARRAY TEXT(gErrorTextArr;0)
C_LONGINT(gError)
gError:=Error

C_TEXT($t_alertText)
$t_alertText:="error "+String(ERROR)
$t_alertText:=" ** ERR ** --> "+Error method+" line #"+String(Error line)+"- "+$t_alertText+". Check On Err log for more detail"
APPEND TO ARRAY(gErrorTextArr;$t_alertText)

ARRAY LONGINT($al_err_code;0)
ARRAY TEXT($as_component;0)
ARRAY TEXT($as_error;0)
GET LAST ERROR STACK($al_err_code;$as_component;$as_error)
C_LONGINT($i)
For ($i;1;Size of array($al_err_code))
APPEND TO ARRAY(gErrorTextArr;"     #"+String($i)+"/"+String(Size of array($al_err_code))+" ERROR: "+String($al_err_code{$i})+"; MESSAGE: \""+$as_error{$i}+"\"")
End for 
