//%attributes = {"preemptive":"incapable"}

#DECLARE($vL_form_input : Integer)->$vL_form : Integer

If (Count parameters:C259<1)
	$vL_form:=Is macOS:C1572 ? Sheet form window:K39:12 : Plain form window:K39:10
	
Else 
	$vL_form:=Is macOS:C1572 ? Sheet form window:K39:12 : $vL_form_input
End if 

