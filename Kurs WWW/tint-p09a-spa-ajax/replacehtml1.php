<?php
header( "Cache-Control: max-age=-1" );
$count=rand( 5, 15 );
$output="<div>Liczby:</div><ul>";
for ( $i=0; $i<$count; $i++ )
{
	$output.="<li>".($i+1)."</li>";
}
$output.="</ul>";
echo $output;
?>