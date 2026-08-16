
Class extends ZENH_EXTRAS

Class constructor($vL_winRef : Integer)
	Super:C1705($vL_winRef)
	This:C1470.t_path:="tables_extras/"
	This:C1470.l_label:=-1
	
	
	// ***** EXTRAS DEFINITION
	// *
Function get_aj_extra_btns($vC_aj_extra_btns : Collection)
	var $vJ_extra_btn : Object
	
	// ***** Selections
	// *
	$vJ_extra_btn:=This:C1470.extra_btn_new($vC_aj_extra_btns; "imgColor, set selection…"; -1; "pict_imgColor"; "imgColor")
	
	// ***** Actions
	// *
	$vJ_extra_btn:=This:C1470.extra_btn_new($vC_aj_extra_btns; "imgStroke, set selection…"; -1; "pict_imgStroke"; "imgStroke")
	// *
	// *****
	
	
	
	// *****
	// *
Function extras_mng($vT_table : Text; $vT_menu : Text; $c4ES_selection_in : 4D:C1709.EntitySelection; $c4ES_selected : 4D:C1709.EntitySelection; $is_local : Boolean)->$c4ES_selection : 4D:C1709.EntitySelection
	
	Case of 
		: ($vT_menu="imgColor")
			$c4ES_selection:=This:C1470._records_parse($vT_menu; $c4ES_selection_in; $c4ES_selected)
			
			
		: ($vT_menu="imgStroke")
			$c4ES_selection:=This:C1470._records_parse($vT_menu; $c4ES_selection_in; $c4ES_selected)
	End case 
	
	
Function _records_parse($vT_menu : Text; $c4ES_selection_in : 4D:C1709.EntitySelection; $c4ES_selected : 4D:C1709.EntitySelection)->$c4ES_selection : 4D:C1709.EntitySelection
	var $isOk : Boolean
	var $cE_PICTURES : cs:C1710.PICTURESEntity
	var $cES_PICTURES_in : cs:C1710.PICTURESSelection
	var $vL_value; $tt : Integer
	var $vJ_menu : Object
	var $vT_prefix; $vT_refMenu; $vT_answerMenu; $vT_subtitle : Text
	$cES_PICTURES_in:=zen_choice_selection($c4ES_selection_in; $c4ES_selected)
	If ($cES_PICTURES_in#Null:C1517)
		$vJ_menu:=sem__storage_menuBtns()["m_"+$vT_menu]
		$vT_prefix:="menuBtn"
		$vT_refMenu:=waz_menuBtn_menu($vT_prefix; $vJ_menu)
		$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
		RELEASE MENU:C978($vT_refMenu)
		$isOk:=($vT_answerMenu#"")
		If ($isOk)
			$vT_answerMenu:=Replace string:C233($vT_answerMenu; $vT_prefix+"."; "")
			$vL_value:=Num:C11($vT_answerMenu)
			$tt:=$cES_PICTURES_in.length
			$vT_subtitle:="Set "+$vT_menu+" of "+wox_str_pluralise($tt; "PICTURE"; "PICTURES")
			If (waz_io_confirm_popup("Are you sure?"; "alert"; $vT_subtitle))
				For each ($cE_PICTURES; $cES_PICTURES_in)
					$cE_PICTURES[$vT_menu]:=$vL_value
					zen_entity_save($cE_PICTURES)
				End for each 
				$c4ES_selection:=$cES_PICTURES_in
			End if 
		End if 
	End if 
	// *
	// *****
	
	