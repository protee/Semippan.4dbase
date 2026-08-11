//%attributes = {"preemptive":"incapable"}
// *****
// *
// Method: zenh_record_add
// Olivier Grimbert — Protée sarl — 18/04/2025 16:34:21
//
// Description:
//
// Date       | Who | Comment
// 18/04/2025 | OG  | Updated
// *
// *****

#DECLARE($vT_table : Text; $vJ_params : Object; $vT_foreignKey : Text; $vV_UID : Variant)->$c4ES_added : 4D:C1709.EntitySelection
var $c4E_entity : 4D:C1709.Entity
var $isOk; $is_moveAtStart; $is_dup; $is_transaction : Boolean
var $vL_form; $vL_winRef; $vL_order; $vL_width; $vL_height; $vL_duration : Integer
var $vP_table : Pointer
var $vT_form; $vT_screen_form : Text
var $c4DC_table : 4D:C1709.DataClass
var $vJ_form_prefs; $vJ_screen_form; $vJ_settings : Object

$vJ_settings:=zen__storage_prefs().j_settings
$vL_duration:=$vJ_settings.l_tempo
$is_moveAtStart:=$vL_duration<10

If ($vJ_params#Null:C1517)
	$vP_table:=Table:C252($vJ_params.l_table)
	If ($vP_table#Null:C1517)
		$vT_form:=$vJ_params.t_form
		If (x_check_form_exists($vT_form; $vP_table))
			
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
			cs:C1710.wox.TUNES.me.play_listIn()
			
			$vJ_params.l_winRef_record:=$vL_winRef
			
			$c4E_entity:=$vJ_params.c4E  // Entity to duplicate ?
			$is_dup:=$c4E_entity#Null:C1517
			$is_transaction:=$vJ_params.is_transaction
			
			$c4DC_table:=zen__ds[$vT_table]
			$c4ES_added:=$c4DC_table.newSelection()
			Repeat   //Boucle pour la saisie en chaine
				If ($is_transaction)
					zen__ds().startTransaction()  // Transaction !
				End if 
				If ($is_dup)
					$is_dup:=False:C215
					$c4E_entity:=zen_entity_tree_duplicate($c4E_entity)  // Given saved
					$c4E_entity.reload()
				Else 
					$c4E_entity:=zen_entity_new($c4DC_table)
					zen_entity_save($c4E_entity)  // For a possible delete after
					$c4E_entity.reload()
					zen_record_synch($c4E_entity)  // Local, Not deep !
				End if 
				If ($vT_foreignKey#"")
					$c4E_entity[$vT_foreignKey]:=$vV_UID
				End if 
				$vJ_params.c4E:=$c4E_entity
				$vL_order:=$vJ_params.l_order  // And calculate next ordered if any
				If ($c4E_entity.order#Null:C1517)
					$c4E_entity.order:=$vL_order  // Update order for new record
				End if 
				DIALOG:C40($vP_table->; $vT_form; $vJ_params)
				$isOk:=(OK=1)
				If ($isOk)
					$c4ES_added.add($c4E_entity)
					$vL_order:=$vL_order=0 ? $vL_order : $vL_order+1
					$vJ_params.l_order:=$vL_order
				End if 
				x_get_window_wh($vL_winRef; ->$vL_width; ->$vL_height; $vJ_params)
			Until (Not:C34($isOk && Shift down:C543))
			
			wox_window_form_push_wh($vJ_screen_form; $vL_width; $vL_height)
			CLOSE WINDOW:C154($vL_winRef)
			wox_window_release($vL_winRef)
			cs:C1710.wox.TUNES.me.play_listOut()
		End if 
	End if 
End if 

