//%attributes = {"preemptive":"incapable"}

#DECLARE($vJ_widget_init : Object)->$is_onLoad : Boolean

var $vP_vJ_widget : Pointer
$vP_vJ_widget:=OBJECT Get pointer:C1124(Object subform container:K67:4)
$is_onLoad:=OB Is empty:C1297($vP_vJ_widget->)
If ($is_onLoad)
	//$vP_vJ_widget->:=OB Copy($vJ_widget_init)
	$vP_vJ_widget->:=$vJ_widget_init
	CALL SUBFORM CONTAINER:C1086(-On Load:K2:1)  //usefull if widget not in page 1 main form
End if 

