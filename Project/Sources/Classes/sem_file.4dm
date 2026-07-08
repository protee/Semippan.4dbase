
Class extends ZEN__WIDGETS
property t_value : Text
property is_editing : Boolean


Class constructor
	// ***** Parameters
	// *
	Super:C1705("j_file")
	This:C1470.t_value:=""
	// *
	// *****
	
	
	// *****
	// *
Function _widget_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	$vJ_formEvent:=FORM Event:C1606
	$vL_event_code:=$vJ_formEvent.code
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Bound Variable Change:K2:52)
			This:C1470._update_all()
			
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
					
				: ($vT_objectName="bt_pathExist")
					This:C1470._fileExist()
					
				: ($vT_objectName="bt_show")
					This:C1470._show()
					
				: ($vT_objectName="bt_ogBoxes")
					This:C1470._ogBoxes()
					
			End case 
			
	End case 
	// *
	// *****
	
	
	
	// MARK: - Manager
	
Function _update_all()
	This:C1470._resize()
	This:C1470._redraw()
	
	
	// *****
	// *
Function _resize()
	var $vL_width; $vL_height : Integer
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($vL_width; $vL_height)
	$vT_tip:=This:C1470.t_tip
	If ($vT_tip#"")
		OBJECT SET HELP TIP:C1181(*; "ot_file"; $vT_tip)
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _redraw()
	//var $vL_value : Integer
	//$vL_value:=This.l_value
	var $vT_value : Text
	$vT_value:=This:C1470._ext_read_t()
	OBJECT SET VALUE:C1742("ot_file"; $vT_value)
	This:C1470._activate_btns($vT_value)
	
	
Function _activate_btns($vT_value : Text)
	var $c4Fi_file : 4D:C1709.File
	var $is_editing; $is_exists : Boolean
	var $vC_at_btn : Collection
	var $vP_bt_exists : Pointer
	var $vT_btn : Text
	
	$is_editing:=This:C1470.is_editing
	$c4Fi_file:=Try(File:C1566($vT_value))
	$is_exists:=$c4Fi_file#Null:C1517 ? $c4Fi_file.exists : False:C215
	$vP_bt_exists:=OBJECT Get pointer:C1124(Object named:K67:5; "bt_exists")
	OBJECT SET ENABLED:C1123($vP_bt_exists->; $is_exists && $is_editing)
	x_btn_toggleSet($vP_bt_exists; Num:C11($is_exists))
	
	$vC_at_btn:=New collection:C1472("bt_show"; "bt_ogBoxes")
	For each ($vT_btn; $vC_at_btn)
		OBJECT SET ENABLED:C1123(*; $vT_btn; $is_exists)
	End for each 
	// *
	// *****
	
	
	// *****
	// *
Function _on_file_chge()->$vL_answer : Integer
	var $c4Fi_file : 4D:C1709.File
	var $vL_event_code : Integer
	var $vT_value; $vT_file : Text
	
	$vL_event_code:=Form event code:C388
	Case of 
		: ($vL_event_code=On Data Change:K2:15)
			$vT_value:=OBJECT Get value:C1743("ot_file")
			$c4Fi_file:=Try(File:C1566($vT_value))
			$vT_file:=$c4Fi_file#Null:C1517 ? $c4Fi_file.path : ""
			This:C1470._ext_write_t($vT_file)
			This:C1470._redraw()
			
		: ($vL_event_code=On Drag Over:K2:13)
			$vL_answer:=Num:C11(Not:C34(This:C1470.is_editing))
			
		: ($vL_event_code=On Drop:K2:12)
			$vT_file:=Get file from pasteboard:C976(1)
			If ($vT_file#"")
				$c4Fi_file:=Try(File:C1566($vT_file; fk platform path:K87:2))
				$vT_file:=$c4Fi_file#Null:C1517 ? $c4Fi_file.path : ""
				This:C1470._ext_write_t($c4Fi_file.path)
				This:C1470._redraw()
			End if 
			
	End case 
	// *
	// *****
	
Function _fileExist()
	var $c4Fi_file : 4D:C1709.File
	var $vT_value; $vT_file : Text
	If (Form:C1466.is_editing)
		$vT_value:=This:C1470._ext_read_t()
		$c4Fi_file:=Try(File:C1566($vT_value))
		$vT_file:=$c4Fi_file#Null:C1517 ? $c4Fi_file.path : ""
		$vT_file:=Select document:C905(Localized string:C991("projectChooseImportPath"); $vT_file)
		If (OK=1)
			$c4Fi_file:=File:C1566($vT_file; fk platform path:K87:2)
			This:C1470._ext_write_t($c4Fi_file.path)
			This:C1470._redraw()
		End if 
	End if 
	
	
Function _show()
	var $c4Fi_file : 4D:C1709.File
	var $vT_value : Text
	$vT_value:=This:C1470._ext_read_t()
	$c4Fi_file:=Try(File:C1566($vT_value))
	If ($c4Fi_file#Null:C1517) && ($c4Fi_file.exists)
		SHOW ON DISK:C922($c4Fi_file.platformPath)
	End if 
	
	
Function _ogBoxes()
	var $c4Fi_file : 4D:C1709.File
	var $vJ_widget : Object
	var $vT_value : Text
	$vT_value:=This:C1470._ext_read_t()
	$c4Fi_file:=Try(File:C1566($vT_value))
	If ($c4Fi_file#Null:C1517) && ($c4Fi_file.exists)
		$vJ_widget:=New object:C1471
		$vJ_widget.t_root_path:=$c4Fi_file.parent.path
		$vJ_widget.t_sub_path:=""
		$vJ_widget.t_root:=""
		$vJ_widget.t_process:="_path_file"
		$vJ_widget.t_pref_name:="File"
		$vJ_widget.is_editing:=True:C214
		$vJ_widget.t_title:="File: "+$c4Fi_file.name
		wob_open($vJ_widget)
	End if 
	
	