  //%attributes = {"invisible":true,"preemptive":"capable","lang":"en"} comment added and reserved by 4D.
  // OnErr_Install_Handler ({errorHandlerMethodName})
  // OnErr_Install_Handler ({text})
  //
  // DESCRIPTION
  //   If a errorHandlerMethodName is specified, then the
  //   "ON ERR CALL" method is called with that value.
  //
  //   If no parms are passed, then the previous handler
  //   is restored.
  //
C_TEXT($1;$errorHandlerMethodName)  // optional
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (11/02/2018)
  //   Mod by: Dani Beaubien (02/24/2020) - Convert to collections, do some extra testing
  // ----------------------------------------------------

If (Asserted(Count parameters<=1))
If (Count parameters=1)
$errorHandlerMethodName:=$1
End if 

C_COLLECTION(_OnErr_MethodStack)
If (_OnErr_MethodStack=Null)
_OnErr_MethodStack:=New collection
End if 

Case of 
: ($errorHandlerMethodName#"")  // add new one to the stack
OnErr_ClearError 
_OnErr_MethodStack.push(Method called on error)

: (_OnErr_MethodStack.length>0)  // remove top item from stack, get the previous one
$errorHandlerMethodName:=_OnErr_MethodStack.pop()

End case 

ON ERR CALL($errorHandlerMethodName)
End if 