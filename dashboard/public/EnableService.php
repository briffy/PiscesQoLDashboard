<?php

$action = strip_tags(htmlentities($_GET['action']));

switch($action)
{
	case 'PF':
		$file = fopen('/var/dashboard/services/PF', 'w');
		fwrite($file, "start\n");
	break;

	case 'BT':
		$file = fopen('/var/dashboard/services/BT', 'w');
		fwrite($file, "start\n");
	break;

	case 'miner':
		$file = fopen('/var/dashboard/services/miner', 'w');
		fwrite($file, "start\n");
	break;

	case 'GPS':
		$file = fopen('/var/dashboard/services/GPS', 'w');
		fwrite($file, "start\n");
	break;

	case 'WiFi':
		$file = fopen('/var/dashboard/services/wifi', 'w');
		fwrite($file, "start\n");
	break;
}
?> 
