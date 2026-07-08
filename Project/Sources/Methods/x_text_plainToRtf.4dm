//%attributes = {}

#DECLARE($vT_text : Text)->$vT_answer : Text

$vT_answer:=$vT_text
$vT_answer:=Replace string:C233($vT_answer; "&"; "&amp;")
$vT_answer:=Replace string:C233($vT_answer; "<"; "&lt;")
$vT_answer:=Replace string:C233($vT_answer; ">"; "&gt;")

