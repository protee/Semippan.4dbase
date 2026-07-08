//%attributes = {}

#DECLARE($c4E_entity : 4D:C1709.Entity; $vJ_widget : Object)->$is_touched : Boolean
var $is_active; $is_display : Boolean
var $vC_al_onOff_colors : Collection
var $vL_colors; $vL_event_code : Integer
var $vT_label; $vT_property : Text

$c4E_entity:=$c4E_entity#Null:C1517 ? $c4E_entity : Form:C1466.cE_SETS
$vL_event_code:=$vJ_widget#Null:C1517 ? On Activate:K2:9 : Form event code:C388
$vJ_widget:=$vJ_widget#Null:C1517 ? $vJ_widget : Self:C308->
$vT_property:="isActive"
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget.l_position:=1
		$vJ_widget.r_coef_h:=0.4
		$vJ_widget.r_font_coef:=0.6
		//$vJ_widget.l_opacity:=70
		$vJ_widget.resize()
		
	: ($vL_event_code=On Activate:K2:9)
		If (Form:C1466.is_new)
			$c4E_entity[$vT_property]:=True:C214
		End if 
		$is_active:=$c4E_entity[$vT_property]
		$is_display:=True:C214
		
	: ($vL_event_code=k_OnDataChange)
		If (Form:C1466.is_editing)
			$is_active:=Not:C34($c4E_entity[$vT_property])
			$c4E_entity[$vT_property]:=$is_active
			$is_touched:=True:C214
			$is_display:=True:C214
		Else 
			wox_sounds_play_beep()
		End if 
		
End case 

If ($is_display)
	$vC_al_onOff_colors:=app__storage_stuff.al_onOff_colors
	$vL_colors:=$vC_al_onOff_colors[Num:C11($is_active)]
	$vT_label:=$is_active ? "✓" : ""  //"╳╳✖✕✗"
	$vJ_widget.l_colors:=$vL_colors
	$vJ_widget.t_value:=$vT_label
	$vJ_widget.redraw()
End if 

