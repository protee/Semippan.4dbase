//%attributes = {"lang":"en","preemptive":"incapable"}
// *****
// *
// Method: y_host_record_newRead_P
// By Olivier Grimbert — Protée sarl
// on 28/12/2023 18:50:00
//
// Description:
//
// Date        Init  Description
// ===================================================================
// 28/12/2023   OG   Initial version.
// *
// *****

#DECLARE($vJ_params : Object)->$isOk : Boolean
var $c4E_entity : 4D:C1709.Entity
var $c4ES_selection : 4D:C1709.EntitySelection
var $is_editing; $is_new; $is_moveAtStart; $is_transaction; $is_lock; $is_lock_optimistic : Boolean
var $vL_process_current; $vL_table; $vL_position; $vL_form; $vL_winRef; $vL_index : Integer
var $vL_width; $vL_height; $vL_duration : Integer
var $vJ_form_prefs; $vJ_screen_form; $vJ_settings : Object
var $vP_table : Pointer
var $vT_form; $vT_action; $vT_table; $vT_screen_form : Text

READ ONLY:C145(*)
//$vJ_params.is_new:=False
$vL_process_current:=$vJ_params.l_pid

$vJ_settings:=zen__storage_prefs().j_settings
$vL_duration:=$vJ_settings.l_tempo
$is_moveAtStart:=$vL_duration<10

$vT_form:=$vJ_params.t_form
$vT_table:=$vJ_params.t_table
$vL_table:=$vJ_params.l_table
$vJ_params.is_dup:=False:C215
$vP_table:=Table:C252($vL_table)
If (x_check_form_exists($vT_form; $vP_table))
	$vL_position:=$vJ_params.l_position
	If ($vL_position>0)
		$c4E_entity:=$vJ_params.c4ES[$vL_position-1]
		$vJ_params.c4E:=$c4E_entity
		
		$vL_form:=$vJ_params.l_form
		$vL_form:=$vL_form#0 ? $vL_form : Plain form window:K39:10
		
		$vT_screen_form:=$vT_table+"_record"
		$vJ_screen_form:=wox_window_form_vJ($vT_screen_form)
		$vJ_params._j_form:=$vJ_screen_form
		x_get_form_wh($vP_table; $vT_form; ->$vL_width; ->$vL_height)
		$vJ_form_prefs:=wox_window_form_pull_wh($vJ_screen_form; $vL_width; $vL_height)
		$vJ_params.j_prefs:=$vJ_form_prefs
		$vL_winRef:=x_window_open($vP_table; $vT_form; $vL_form; $vJ_form_prefs; $is_moveAtStart)
		wox_window_lock($vL_winRef)
		cs:C1710.wox.SOUNDS.me.play_listIn()
		
		$vJ_params.l_winRef_record:=$vL_winRef
		$is_editing:=$vJ_params.is_editing
		$is_transaction:=$vJ_params.is_transaction
		$is_lock_optimistic:=zen__storage_prefs().is_lock_optimistic
		
		Repeat 
			If ($is_transaction)
				zen__ds().startTransaction()  // Transaction !
			End if 
			$vJ_params.t_action:=""
			$is_lock:=$is_editing && Not:C34($is_lock_optimistic)
			If ($is_lock)
				zen_entity_lock($c4E_entity)
			End if 
			zen_record_synch($c4E_entity)
			DIALOG:C40($vP_table->; $vT_form; $vJ_params)
			zen_entity_unlock($c4E_entity)  // Even if un-necessary
			$isOk:=$isOk || (OK=1)
			$vT_action:=$vJ_params.t_action
			// *****
			// *
			Case of 
				: ($vT_action="first")
					$c4E_entity:=$vJ_params.c4ES.first()
					$vJ_params.c4E:=$c4E_entity
					
				: ($vT_action="previous")
					$c4ES_selection:=$vJ_params.c4ES
					$c4E_entity:=$vJ_params.c4E
					$vL_index:=$c4E_entity.indexOf($c4ES_selection)
					$c4E_entity:=$c4ES_selection[$vL_index-1]
					$vJ_params.c4E:=$c4E_entity
					
				: ($vT_action="next")
					$c4ES_selection:=$vJ_params.c4ES
					$c4E_entity:=$vJ_params.c4E
					$vL_index:=$c4E_entity.indexOf($c4ES_selection)
					$c4E_entity:=$c4ES_selection[$vL_index+1]
					$vJ_params.c4E:=$c4E_entity
					
				: ($vT_action="last")
					$c4E_entity:=$vJ_params.c4ES.last()
					$vJ_params.c4E:=$c4E_entity
					
				: ($vT_action="editing")
					$is_new:=$vJ_params.is_new
					If (Not:C34($is_new))
						$is_editing:=Not:C34($vJ_params.is_editing)
						$vJ_params.is_editing:=$is_editing
						$c4ES_selection:=$vJ_params.c4ES
						$c4E_entity:=$vJ_params.c4E
						$vL_index:=$c4E_entity.indexOf($c4ES_selection)
						$c4E_entity:=$c4ES_selection[$vL_index]
						$vJ_params.c4E:=$c4E_entity
					End if 
					
				: ($vT_action="popup.@")
					$vT_action:=Replace string:C233($vT_action; "popup."; "")
					zen_record_popup($vJ_params; $vT_action)
					
			End case 
			x_get_window_wh($vL_winRef; ->$vL_width; ->$vL_height; $vJ_params)
		Until ($vT_action="")
		
		wox_window_form_push_wh($vJ_screen_form; $vL_width; $vL_height)
		CLOSE WINDOW:C154($vL_winRef)
		wox_window_release($vL_winRef)
		cs:C1710.wox.SOUNDS.me.play_listOut()
	End if 
Else 
	cs:C1710.wox.SOUNDS.me.play_beep()
End if 
POST OUTSIDE CALL:C329($vL_process_current)

