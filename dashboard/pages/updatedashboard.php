<?php
$info['latest_dashboard_version'] = trim(file_get_contents('/var/dashboard/update'));
$info['service'] = trim(file_get_contents('/var/dashboard/services/dashboard-update'));
if($_GET['start'])
{
	$info['service'] = trim(file_get_contents('/var/dashboard/services/dashboard-update'));

	if($info['service'] == 'stopped')
	{
		$file = fopen('/var/dashboard/services/dashboard-update', 'w');
		fwrite($file, 'start');
		fclose($file);

		$file = fopen('/var/dashboard/logs/dashboard-update.log', 'w');
		fwrite($file, '');
		fclose($file);

	}
}
?>
<h1>Update Dashboard</h1>
<textarea id="log_output" disabled>
<?php
echo 'Updating from: '.$info['Version']."\n";
echo 'Updating to: '.$info['latest_dashboard_version'];
echo "\nAwaiting start...";
?>
</textarea>
<a title="Start" id="StartUpdateButton" href="#" onclick="StartDashboardUpdate()">Start</a>

