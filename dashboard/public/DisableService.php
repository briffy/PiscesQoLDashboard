<?php

$action = strip_tags(htmlentities($_GET['action']));

switch($action)
{
	case 'PF':
		$file = fopen('/var/dashboard/services/PF', 'w');
		fwrite($file, "stop\n");
	break;

	case 'BT':
		$file = fopen('/var/dashboard/services/BT', 'w');
		fwrite($file, "stop\n");
	break;

	case 'miner':
		$file = fopen('/var/dashboard/services/miner', 'w');
		fwrite($file, "stop\n");
	break;

	case 'GPS':
		$file = fopen('/var/dashboard/services/GPS', 'w');
		fwrite($file, "stop\n");
	break;

	case 'WiFi':
		$file = fopen('/var/dashboard/services/wifi', 'w');
		fwrite($file, "stop\n");
	break;

	case 'AutoMaintain':
		$file = fopen('/var/dashboard/services/auto-maintain', 'w');
		fwrite($file, "disabled\n");
	break;

	case 'AutoUpdate':
		$file = fopen('/var/dashboard/services/auto-update', 'w');
		fwrite($file, "disabled\n");
	break;
}
?>
