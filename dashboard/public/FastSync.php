<?php
	$file = fopen('/var/dashboard/statuses/fastsync', 'w');
	fwrite($file, "true\n");
?>
