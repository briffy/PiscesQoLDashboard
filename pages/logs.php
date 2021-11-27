<?php
$logs['miner'] = shell_exec('tail -100 /home/pi/hnt/miner/log/console.log | tac');
$logs['witnesses'] = shell_exec('tac /home/pi/hnt/miner/log/console.log | grep -i witness');
$logs['errors'] = shell_exec('tail -100 /home/pi/hnt/miner/log/error.log | tac');
?>
<h1>Pisces P100 Outdoor Miner Dashboard - Information</h1>


<div class="log_container">
	<h2>Miner Logs</h2>
	<div class="wrapper"><textarea class="log_output" wrap="off"><?php echo $logs['miner']; ?></textarea></div>
</div>

<div class="log_container">
	<h2>Witness Logs</h2>
	<div class="wrapper"><textarea class="log_output" wrap="off"><?php echo $logs['witnesses']; ?></textarea></div>
</div>

<div class="log_container">
	<h2>Error Logs</h2>
	<div class="wrapper"><textarea class="log_output" wrap="off"><?php echo $logs['errors']; ?></textarea></div>
</div>
