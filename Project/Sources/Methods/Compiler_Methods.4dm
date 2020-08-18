//%attributes = {"invisible":true}
C_BOOLEAN:C305(STR_IsOneOf ;$0)
C_TEXT:C284(STR_IsOneOf ;${2})
C_TEXT:C284(STR_IsOneOf ;$1)
C_OBJECT:C1216(FileImporter_DeclareColumn ;$1)
C_TEXT:C284(FileImporter_DeclareColumn ;$2)
C_TEXT:C284(FileImporter_DeclareColumn ;$3)
C_LONGINT:C283(FileImporter_DeclareColumn ;$4)
C_OBJECT:C1216(FileImporter_New ;$0)
C_TEXT:C284(FileImporter_New ;$1)
C_COLLECTION:C1488(FileImporter_Load2Collection ;$0)
C_OBJECT:C1216(FileImporter_Load2Collection ;$1)

  //OnErr_GetLastError
C_LONGINT:C283(OnErr_GetLastError ;$0)

  //PTR_IsArray
C_BOOLEAN:C305(PTR_IsArray ;$0)
C_POINTER:C301(PTR_IsArray ;$1)
C_POINTER:C301(Array_SetSize ;${2})
C_LONGINT:C283(Array_SetSize ;$1)

  //OnErr_GetLastErrorMessages
C_TEXT:C284(OnErr_GetLastErrorMessages ;$0)

  //OnErr_Install_Handler
C_TEXT:C284(OnErr_Install_Handler ;$1)

  //STR_isDate
C_BOOLEAN:C305(STR_isDate ;$0)
C_TEXT:C284(STR_isDate ;$1)

  //STR_isDate_GetDate
C_DATE:C307(STR_isDate_GetDate ;$0)
C_TEXT:C284(STR_isDate_GetDate ;$1)

  //STR_isISODate
C_BOOLEAN:C305(STR_isISODate ;$0)
C_TEXT:C284(STR_isISODate ;$1)

  //Date2String
C_TEXT:C284(Date2String ;$0)
C_DATE:C307(Date2String ;$1)
C_TEXT:C284(Date2String ;$2)

  //STR_isIntegerNumber
C_BOOLEAN:C305(STR_isIntegerNumber ;$0)
C_TEXT:C284(STR_isIntegerNumber ;$1)

  //String2Date
C_DATE:C307(String2Date ;$0)
C_TEXT:C284(String2Date ;$1)
C_TEXT:C284(String2Date ;$2)

  //NUM_GetMaxLong
C_LONGINT:C283(NUM_GetMaxLong ;$0)
C_LONGINT:C283(NUM_GetMaxLong ;$1)
C_LONGINT:C283(NUM_GetMaxLong ;$2)

  //_Test_Testable_Processor
C_OBJECT:C1216(_Test_Testable_Processor ;$1)

  //_Test_Testable_FetchData
C_OBJECT:C1216(_Test_Testable_FetchData ;$0)
C_TEXT:C284(_Test_Testable_FetchData ;$1)