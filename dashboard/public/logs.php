<?php
if(isset($_GET['name']))
{
	switch($_GET['name'])
	{
		case 'miner-update':
			echo file_get_contents('/var/dashboard/logs/miner-update.log');
			break;

		case 'dashboard-update':
			echo file_get_contents('/var/dashboard/logs/dashboard-update.log');
			break;

		case 'clear-blockchain':
			echo file_get_contents('/var/dashboard/logs/clear-blockchain.log');
			break;
	}
}
