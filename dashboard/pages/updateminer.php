<?php
$info['latest_miner_version'] = file_get_contents(trim('/var/dashboard/statuses/latest_miner_version'));
$info['current_miner_version'] = file_get_contents(trim('/var/dashboard/statuses/current_miner_version'));
$info['service'] = file_get_contents(trim('/var/dashboard/services/miner-update'));
if($_GET['start'])
{
	$info['service'] = trim(file_get_contents('/var/dashboard/services/miner-update'));
	echo $info['service'];
	if($info['service'] == 'stopped')
	{
		$file = fopen('/var/dashboard/services/miner-update', 'w');
		fwrite($file, 'start');
		fclose($file);

		$file = fopen('/var/dashboard/logs/miner-update.log', 'w');
		fwrite($file, '');
		fclose($file);

	}
}
?>
<h1>Update Miner Docker</h1>
<textarea id="log_output" disabled>
<?php
echo 'Updating from: '.$info['current_miner_version'];
echo 'Updating to: '.$info['latest_miner_version'];
echo "\nAwaiting start...";
?>
</textarea>
<div id="updatecontrols">
	<a title="Start" id="StartUpdateButton" href="#" onclick="StartMinerUpdate()">Start</a>
</div>

