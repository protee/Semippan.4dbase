//%attributes = {"preemptive":"incapable"}

// ***** HOST EXAMPLE
// *
var $vL_form; $vL_refwin : Integer
var $vJ_prefs_app; $vJ_form : Object
var $vT_program_name; $vT_userProfile; $vT_fileName; $vT_refMenu_mainBar; $vT_form : Text

READ ONLY:C145(*)
MESSAGES OFF:C175

// ***** Get the program name
$vJ_prefs_app:=app__storage_prefs()
$vT_program_name:=$vJ_prefs_app.t_name

// ***** Get the file and menu
$vT_userProfile:=zen__storage_profile.t_profile
$vT_fileName:="menus"
$vT_refMenu_mainBar:=zen_menu_main($vT_userProfile; $vT_fileName; $vT_program_name)
If ($vT_refMenu_mainBar#"")
	SET MENU BAR:C67($vT_refMenu_mainBar)
	RELEASE MENU:C978($vT_refMenu_mainBar)
End if 
// *
// *****


// ***** Startup screen demo
// *
$vT_form:="m_start_screen"
//$vL_form:=Plain form window
$vL_form:=Plain form window:K39:10
$vL_refwin:=Open form window:C675($vT_form; $vL_form; On the left:K39:2; At the top:K39:5)
$vJ_form:=New object:C1471
$vJ_form.j_app:=$vJ_prefs_app
DIALOG:C40($vT_form; $vJ_form)
// *
// *****

