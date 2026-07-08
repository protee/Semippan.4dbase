//%attributes = {}

#DECLARE($vT_host_filters : Text)->$vL_height : Integer
var $vL_width : Integer
var $vT_on_err_call_old : Text

//$vT_error_old:=wox_error_call_set("sem_error_none") // Seems not possible !
//FORM GET PROPERTIES($vT_host_filters; $vL_width; $vL_height)
//wox_error_call_restore($vT_error_old)

$vT_on_err_call_old:=Method called on error:C704()
ON ERR CALL:C155("zenh_error_none")  // NOT wox_error_none
FORM GET PROPERTIES:C674($vT_host_filters; $vL_width; $vL_height)
ON ERR CALL:C155($vT_on_err_call_old)

