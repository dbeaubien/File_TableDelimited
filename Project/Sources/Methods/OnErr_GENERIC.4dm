//%attributes = {"invisible":true,"preemptive":"capable","folder":"DEV","lang":"en"}
  // OnErr_GENERIC ()
  //
  // DESCRIPTION
  //   The simplest error handler. Information is sent to the log.
  //
  // ----------------------------------------------------
  // HISTORY
  //   Mod by: Dani Beaubien (9/9/13) - Enhanced the information that is coming out
  //   Mod by: Dani Beaubien (2020-02-14) - Added gErrorTextArr
  // ----------------------------------------------------

ARRAY TEXT:C222(gErrorTextArr;0)
OnErr_GENERIC_Minimal 

  //C_LONGINT($i)
  //For ($i;1;Size of array(gErrorTextArr))
  //If ($i=1)
  //Log_ERR_CRITICAL(gErrorTextArr{$i}+" Check On Err log for more detail.")
  //End if 
  //LogNamed_AppendToFile("On Err Trigger";gErrorTextArr{$i})
  //End for 

If (gError=-10518) & (Not:C34(Is compiled mode:C492(*)))  // assertion error
	ALERT:C41("ASSERT ERROR: Occurred. Check logs.")
End if 