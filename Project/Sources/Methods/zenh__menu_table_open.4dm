//%attributes = {}

var $vL_menu; $vL_menu_bar; $vL_menu_item : Integer
$vL_menu:=Menu selected:C152
$vL_menu_bar:=$vL_menu\65536
$vL_menu_item:=$vL_menu%65536
var $vT_view : Text
GET MENU ITEM PROPERTY:C972($vL_menu_bar; $vL_menu_item; "t_view"; $vT_view)  // “” if not exists
var $vT_parameter : Text
$vT_parameter:=Get selected menu item parameter:C1005

zen_table_open($vT_parameter; $vT_view)
