
Class extends ZEN__RECORD

Class constructor
	Super:C1705()
	This:C1470.record_load_upd()
	
	//Function form_modify()
	//Super.form_modify($vC_at_objects_nc)
	
Function record_load_upd()
	Super:C1706.record_load_upd()
	This:C1470.l_timer:=1
	//If (Form.is_new)
	//$c4E:=Form.c4E
	//$c4E.isActive:=True
	////This.widgets_upd()
	//End if 
	This:C1470.sem_folder_upd()
	
	
	//Function widgets_upd()
	//var $vC_at_widgets : Collection
	//var $vJ_widget : Object
	//var $vT_widget : Text
	//$vC_at_widgets:=New collection()
	//$vC_at_widgets.push("waz_isActive")  //; "woc_colors")
	//For each ($vT_widget; $vC_at_widgets)
	//$vJ_widget:=OBJECT Get value($vT_widget)
	//$vJ_widget.redraw()
	//End for each 
	
	
Function record_checkout()->$isOk : Boolean
	var $c4E_entity : 4D:C1709.Entity
	var $vJ_okValidate : Object
	$c4E_entity:=Form:C1466.c4E
	$vJ_okValidate:=zen_okValidate_init
	zen_okValidate_check($vJ_okValidate; ($c4E_entity.isExternalPath && ($c4E_entity.label="")); False:C215; "Fill in label!")
	$isOk:=zen_okValidate_checkout($vJ_okValidate)
	
	
Function record_touched($c4E_record : 4D:C1709.Entity)->$is_touched : Boolean
	$is_touched:=Form:C1466.is_touched
	If (Not:C34($is_touched))
		$is_touched:=$c4E_record.touched()
	End if 
	
	
Function do_touched()
	Form:C1466.is_touched:=True:C214
	
	
	//Function record_save($c4E_entity : 4D.Entity)
	//Super.record_save($c4E_entity)
	
	// *
	// *****
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	$vL_event_code:=Form event code:C388
	
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Close Box:K2:21)
			This:C1470.zen_record_events("closeBox")
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="field_isOVW")
					This:C1470.sem_folder_upd()
					
				: ($vT_objectName="field_isMyPath@")
					This:C1470.sem_folder_upd()
					
			End case 
			
			//: ($vL_event_code=On Double Clicked)
			//Case of 
			//: ($vT_objectName="oO_svg")
			//This._copy_PP($vT_objectName)
			
			//: ($vT_objectName="oO_svg1")
			//This._copy_PP($vT_objectName)
			//End case 
			
			
			//: ($vL_event_code=On Timer)
			//This.timer()
			
			
			
			//: ($vL_event_code=On Double Clicked)
			
			//: ($vL_event_code=On Data Change)
			
			//: ($vL_event_code=On Double Clicked)
			
	End case 
	// *
	// *****
	
	
	
Function get_path($c4E : 4D:C1709.Entity)->$c4Fo_database : 4D:C1709.Folder
	If ($c4E#Null:C1517)
		If ($c4E.isMyPath)
			$c4Fo_database:=Folder:C1567(fk database folder:K87:14)
		Else 
			If ($c4E.path#"")
				$c4Fo_database:=Folder:C1567($c4E.path)
			End if 
		End if 
	End if 
	
	
Function get_path_calculated()->$c4Fo_database : 4D:C1709.Folder
	var $c4E : 4D:C1709.Entity
	var $is_externalPath : Boolean
	$c4E:=Form:C1466.c4E
	$is_externalPath:=$c4E.isExternalPath
	If ($is_externalPath)
		$c4Fo_database:=This:C1470.get_path($c4E)
	Else 
		$c4E:=$c4E.PATHS_PRODUCTS
		$c4Fo_database:=This:C1470.get_path($c4E)
	End if 
	
	
	
Function sem_folder_upd()
	var $isOk; $is_visible : Boolean
	var $c4E : 4D:C1709.Entity
	var $vJ_sem_folder : Object
	var $vT_sem_folder; $vT_myPath : Text
	
	$c4E:=Form:C1466.c4E
	$is_visible:=$c4E.isExternalPath
	$vT_sem_folder:="sem_folder"
	$vT_myPath:="myPath"
	OBJECT SET VISIBLE:C603(*; "@_ovw"; $is_visible)
	OBJECT SET VISIBLE:C603(*; $vT_sem_folder; $is_visible)
	OBJECT SET VISIBLE:C603(*; $vT_myPath; $is_visible)
	If ($is_visible)
		$isOk:=Not:C34($c4E.isMyPath) && Form:C1466.is_editing
		$vJ_sem_folder:=OBJECT Get value:C1743("sem_folder")
		$vJ_sem_folder.is_editing:=$isOk
		$vJ_sem_folder.redraw()
		OBJECT SET VISIBLE:C603(*; $vT_myPath; $c4E.isMyPath)
		OBJECT SET VALUE:C1742($vT_myPath; Folder:C1567(fk database folder:K87:14).path)
	End if 
	
	
Function is_myPath_upd()
	var $c4E : 4D:C1709.Entity
	var $vT_path : Text
	$c4E:=Form:C1466.c4E
	$vT_path:=$c4E.path
	$vT_path:=Folder:C1567($vT_path; fk platform path:K87:2).path
	$c4E.isMyPath:=($vT_path=(Folder:C1567(fk database folder:K87:14).path))
	This:C1470.sem_folder_upd()
	
	