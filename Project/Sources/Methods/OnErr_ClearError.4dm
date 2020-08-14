  //%attributes = {"invisible":true,"preemptive":"capable","folder":"DEV","lang":"en"} comment added and reserved by 4D.
  // OnErr_Clear ()
  // 
  // DESCRIPTION
  //   Clears the internal error var
  //
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (09/13/2016)
  // ----------------------------------------------------

ARRAY TEXT(gErrorTextArr;0)
C_LONGINT(gError)
gError:=0