<?php
	$file = fopen('/var/dashboard/statuses/reboot', 'w');
	fwrite($file, "true\n");
?>
