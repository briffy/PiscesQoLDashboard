<?php
if($_POST['confirm'])
{
	exec("sudo docker stop miner");
	exec("sudo rm -rf /home/pi/hnt/miner/blockchain.db/*");
	exec("sudo rm -rf /home/pi/hnt/miner/ledger.db/*");
	exec("sudo docker start miner");
	echo 'Blockchain data cleared.';
}
