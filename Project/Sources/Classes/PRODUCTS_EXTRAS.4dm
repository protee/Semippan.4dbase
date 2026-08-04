
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
	$vJ_extra_btn:=This:C1470.extra_btn_new($vC_aj_extra_btns; "Export Summary…"; -1; "export"; "summary")
	
	// *
	// *****
	
	
	
	// *****
	// *
Function extras_mng($vT_table : Text; $vT_menu : Text; $c4ES_selection_in : 4D:C1709.EntitySelection; $c4ES_selected : 4D:C1709.EntitySelection; $is_local : Boolean)->$c4ES_selection : 4D:C1709.EntitySelection
	
	Case of 
		: ($vT_menu="summary")
			$c4ES_selection:=This:C1470._products_summary($c4ES_selection_in; $c4ES_selected)
			
			
	End case 
	
	
Function _products_summary($c4ES_selection_in : 4D:C1709.EntitySelection; $c4ES_selected : 4D:C1709.EntitySelection)->$c4ES_selection : 4D:C1709.EntitySelection
	var $tt : Integer
	var $vJ_summary; $vJ_product : Object
	var $vT_subtitle; $vT_file; $vT_label; $vT_title : Text
	var $c4Fi_products : 4D:C1709.File
	var $c4Fo_target : 4D:C1709.Folder
	var $vC_aj_products : Collection
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	$c4ES_selection_in:=zen_choice_selection($c4ES_selection_in; $c4ES_selected)
	If ($c4ES_selection_in#Null:C1517)
		$tt:=$c4ES_selection_in.length
		$vT_subtitle:="Export "+wox_str_pluralise($tt; "PRODUCT")
		If (waz_io_confirm_popup("Are you sure?"; "alert"; $vT_subtitle))
			$vJ_summary:=New object:C1471()
			$vC_aj_products:=New collection:C1472()
			$vJ_summary.aj_products:=$vC_aj_products
			For each ($cE_PRODUCTS; $c4ES_selection_in)
				$vJ_product:=New object:C1471()
				$vC_aj_products.push($vJ_product)
				$vT_label:=$cE_PRODUCTS.label
				$vT_title:=$cE_PRODUCTS.title
				$vJ_product.t_label:=$vT_label
				$vJ_product.t_title:=$vT_title
				//$vJ_product.t_header:=$vT_label+" – "+$vT_title
				$vJ_product.t_subtitle:=$cE_PRODUCTS.subtitle
				$vJ_product.t_mantra:=$cE_PRODUCTS.mantra
				$vJ_product.t_tagline:=$cE_PRODUCTS.tagline
			End for each 
			$c4Fo_target:=Folder:C1567(fk desktop folder:K87:19)
			$vT_file:="products.json"
			$c4Fi_products:=$c4Fo_target.file($vT_file)
			$c4Fi_products.setText(JSON Stringify:C1217($vJ_summary; *))
			$c4ES_selection:=$c4ES_selection_in
		End if 
	End if 
	// *
	// *****
	
	