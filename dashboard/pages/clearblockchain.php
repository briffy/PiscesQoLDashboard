<?php
$info['service'] = trim(file_get_contents('/var/dashboard/services/clear-blockchain'));
if($_GET['start'])
{
	$info['service'] = trim(file_get_contents('/var/dashboard/services/clear-blockchain'));

	if($info['service'] == 'stopped')
	{
		$file = fopen('/var/dashboard/services/clear-blockchain', 'w');
		fwrite($file, 'start');
		fclose($file);

		$file = fopen('/var/dashboard/logs/clear-blockchain.log', 'w');
		fwrite($file, '');
		fclose($file);

	}
}
?>
<h1>Clear BlockChain Data</h1>
<textarea id="log_output" disabled>
<?php
echo "Awaiting start...";
?>
</textarea>
<div id="updatecontrols">
	<a title="Start" id="StartBlockChainButton" href="#" onclick="StartBlockChainClear()">Start</a>
</div>

