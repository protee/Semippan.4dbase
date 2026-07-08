//%attributes = {"lang":"en"}
// *****
// *
// Method: zenh__initialize_btnMenus
// Olivier Grimbert — Protée sarl — 05/04/2025 16:52:12
//
// Description: Initialization of all btnMenus used in host -> Wrapped in ZEN
//
// Date       | Who | Comment
// 05/04/2025 | OG  | Updated
// *
// *****

#DECLARE($vJ_prefs : Object)

var $c4Fu_icon : 4D:C1709.Function
var $vT_path : Text
var $vC_at_lbl; $vC_al_lbl : Collection
var $vJ_menuBtns; $vJ_menu : Object
$vJ_menuBtns:=New shared object:C1526
Use ($vJ_prefs)
	$vJ_prefs.j_menuBtns:=$vJ_menuBtns
End use 

$vT_path:="metier/"
$c4Fu_icon:=Formula:C1597(zenh_SET_MENU_ITEM_ICON)

Use ($vJ_menuBtns)
	
	// ***** m_imgColor btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_imgColor:=$vJ_menu
	$vJ_menu.t_label:="Picture color"
	$vJ_menu.t_tip:="imgColor"
	$vJ_menu.t_key:="imgColor"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("White (#FFF)"; "Black (#000)"; "Grey (#757575)"; "Color"; "Multicolors")
	$vC_al_lbl:=wox_shared_al_lbl_new($vJ_menu; "al_source_rgb")
	$vC_al_lbl.push(0x00FFFFFF; 0x0000; 0x00757575; -1; -1)
	
	
	// ***** m_imgStroke btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_imgStroke:=$vJ_menu
	$vJ_menu.t_label:="Picture stroke"
	$vJ_menu.t_tip:="stroke type"
	$vJ_menu.t_key:="imgStroke"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("Filled"; "Outline"; "Photo")
	
	
	// ***** m_orderMode btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_orderMode:=$vJ_menu
	$vJ_menu.t_label:="Sort and numerotation"
	$vJ_menu.t_key:="orderMode"
	$vJ_menu.l_btn_w:=-24
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("Alpha order"; "Manual order"; "Auto-numbering")
	$vC_al_lbl:=wox_shared_al_lbl_new($vJ_menu)
	$vC_al_lbl.push(0xF4F7; 0xF491; 0xF4BC)
	
	
	// ***** m_outputType btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_outputType:=$vJ_menu
	$vJ_menu.t_label:="Output type"
	$vJ_menu.t_tip:="Output type"
	$vJ_menu.t_key:="outputType"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("Icn"; "BtnH"; "BtnV")
	$vC_al_lbl:=wox_shared_al_lbl_new($vJ_menu)
	$vC_al_lbl.push(0x030FF0AF; 0x080FF03A; 0x030FF04E)
	
	
	
	// ***** m_outputMime btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_outputMime:=$vJ_menu
	$vJ_menu.t_label:="Output Mime"
	$vJ_menu.t_tip:="Output Mime"
	$vJ_menu.t_key:="outputMime"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("png"; "jpg"; "svg")
	$vC_al_lbl:=wox_shared_al_lbl_new($vJ_menu)
	$vC_al_lbl.push(0x7A7D; 0xC0C3; 0x5053)
	
	
	// ***** m_pict_source btnMenu
	// *
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_pict_source:=$vJ_menu
	$vJ_menu.t_label:="Picture source"
	$vJ_menu.t_tip:="Picture source"
	$vJ_menu.t_key:="pict_source"
	$vJ_menu.l_btn_w:=-24
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("Internal"; "PICTURES")
	
	
	// ***** m_4d_type btnMenu
	// *
	$vT_path:="product_types/"
	$vJ_menu:=New shared object:C1526()
	$vJ_menuBtns.m_4d_types:=$vJ_menu
	$vJ_menu.t_label:="Product type"
	$vJ_menu.t_key:="4d_type"
	$vJ_menu.t_path:=$vT_path
	$vJ_menu.fu_icon:=$c4Fu_icon
	$vC_at_lbl:=wox_shared_at_lbl_new($vJ_menu)
	$vC_at_lbl.push("None"; "4D"; "Android"; "Corporate"; "Database"; "Component")
	$vC_at_lbl.push("ogPop"; "ogTools"; "Specific"; "How Do I"; "Test"; "Other")
	
	
	
End use 

