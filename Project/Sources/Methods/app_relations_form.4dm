//%attributes = {}

#DECLARE($is_process : Boolean)
var $vC_aj_TablesClass : Collection
var $vL_no_process : Integer
var $vT_method_name : Text

If ($is_process)
	READ ONLY:C145(*)
	$vC_aj_TablesClass:=app__storage_stuff.aj_TablesClass  // => put in zen
	zen_relations_form($vC_aj_TablesClass)
	
Else 
	$vT_method_name:=Current method name:C684()
	$vL_no_process:=Process number:C372("$"+$vT_method_name)
	If ($vL_no_process=0)
		BRING TO FRONT:C326(New process:C317($vT_method_name; 0; "$"+$vT_method_name; True:C214; *))
	Else 
		BRING TO FRONT:C326($vL_no_process)
	End if 
End if 

