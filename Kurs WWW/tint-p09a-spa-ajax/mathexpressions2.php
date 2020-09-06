<?php
header( "Cache-Control: max-age=-1" );
echo $_POST["left"]+$_POST["right"];
?>