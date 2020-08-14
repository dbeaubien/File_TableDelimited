
  // Must be non compiled and not as a component
If (Not:C34(Is compiled mode:C492)) & (Structure file:C489(*)=Structure file:C489)
	
	ARRAY TEXT:C222($at_components;0)
	COMPONENT LIST:C1001($at_components)
	If (Find in array:C230($at_components;"Mainfest Generator")>0)
		EXECUTE METHOD:C1007("Manifest_SetAuthor";*;"Dani Beaubien")
		EXECUTE METHOD:C1007("Manifest_SetBuildDate";*;Current date:C33)
		EXECUTE METHOD:C1007("Manifest_SetURL";*;"https://github.com/4D-Open-Source/File_TableDelimited")
		EXECUTE METHOD:C1007("Manifest_SetCopyright";*;"Open Source")
		EXECUTE METHOD:C1007("Manifest_SetVersion";*;"Build "+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33));True:C214)
	End if 
	
End if 