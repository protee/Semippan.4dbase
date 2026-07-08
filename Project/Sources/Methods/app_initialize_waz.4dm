//%attributes = {"lang":"en","preemptive":"incapable"}
// *****
// *
// Method: wazh_initialize
// Olivier Grimbert — Protée sarl — 27/08/2024 13:20:01
//
// Description:
//
// Date       | Who | Comment
// 27/08/2024 | OG  | Updated
// *
// *****


// ***** waz_Bazar IO colors
// *
var $vJ_widgets_waz : Object
$vJ_widgets_waz:=waz__storage_widgets()


// ***** Progress
// *
//$vL_colors:=woc_sp_colors_from_text("[rale:104][rale:98]")
//$vL_colors_icon:=woc_sp_colors_from_text("[rale:102][rale:99]")
//$vL_colors:=woc_sp_colors_from_row("[rale:278][rale:273]")
//$vL_colors_icon:=woc_sp_colors_from_row("[rale:277][rale:274]")

var $c4Fi_icon : 4D:C1709.File
$c4Fi_icon:=Folder:C1567(fk resources folder:K87:11).file("pictures/logo_product.png")
var $vJ_io_progress : Object
$vJ_io_progress:=$vJ_widgets_waz.j_io_progress
Use ($vJ_io_progress)
	zenh_io_colors_from_row($vJ_io_progress; k_MDcolorsIdx_lime; True:C214)
	$vJ_io_progress.v_icon:=$c4Fi_icon
	$vJ_io_progress.l_ticks_close:=0
End use 

//var $vT_barber_uid : Text
//$vT_barber_uid:=waz_progress_new("Barber1!"; "Coucou les potes, ça roule ?"; False)
//DELAY PROCESS(Current process; 60)
// *
// *****


// ***** alertConfirmMore
// *
//$vL_colors:=woc_sp_colors_from_text("[rale:278][rale:273]")
//$vL_colors_icon:=woc_sp_colors_from_text("[rale:277][rale:274]")
Use ($vJ_widgets_waz)
	var $vJ_io_alert; $vJ_io_confirm; $vJ_io_more; $vJ_io_request : Object
	$vJ_io_alert:=$vJ_widgets_waz.j_io_alert
	$vJ_io_alert.r_img_coef:=0.7
	zenh_io_colors_from_row($vJ_io_alert; k_MDcolorsIdx_amber)
	
	$vJ_io_confirm:=$vJ_widgets_waz.j_io_confirm
	$vJ_io_confirm.r_img_coef:=0.7
	zenh_io_colors_from_row($vJ_io_confirm; k_MDcolorsIdx_deepPurple)
	
	$vJ_io_more:=$vJ_widgets_waz.j_io_more
	$vJ_io_more.r_img_coef:=0.7
	zenh_io_colors_from_row($vJ_io_more; k_MDcolorsIdx_brown)
	
	$vJ_io_request:=$vJ_widgets_waz.j_io_request
	$vJ_io_request.r_img_coef:=0.7
	zenh_io_colors_from_row($vJ_io_request; k_MDcolorsIdx_lightGreen)
End use 


//$vT_text:="COUCOU"
//waz_io_alert($vT_text)
//waz_io_confirm($vT_text)
//waz_io_more($vT_text)
//waz_io_request_vP(->$vT_text; "COUCOU")

//waz_progress_quit($vT_barber_uid)
// *
// *****


// ***** waz widgets
// *
var $vJ_widget : Object
var $vT_filter_date; $vT_filter_time : Text
//$vT_filter_date:="##/##/####"
//$vT_filter_time:="##:##:##"
$vT_filter_date:=""
$vT_filter_time:=""
Use ($vJ_widgets_waz)
	$vJ_widgets_waz.j_search.l_colors:=woc_sp_colors_from_row(k_MDcolorsIdx_lime; 9; 0)
	$vJ_widgets_waz.j_date.t_filter:=$vT_filter_date
	$vJ_widgets_waz.j_dates.t_filter:=$vT_filter_date
	$vJ_widgets_waz.j_time.t_filter:=$vT_filter_time
	$vJ_widgets_waz.j_times.t_filter:=$vT_filter_time
	$vJ_widget:=$vJ_widgets_waz.j_datetime
	$vJ_widget.t_filter_date:=$vT_filter_date
	$vJ_widget.t_filter_time:=$vT_filter_time
	
	$vJ_widget:=$vJ_widgets_waz.j_switch
	$vJ_widget.aj_colors[1].l_back:=woc_sp_colors_from_row(k_MDcolorsIdx_lightGreen; 3; 4)
	
	$vJ_widget:=$vJ_widgets_waz.j_menuBtn
	$vJ_widget.l_click:=1  // Click label on
	
End use 
// *
// *****
