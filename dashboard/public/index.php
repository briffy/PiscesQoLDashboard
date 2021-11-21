<?php
$page = htmlentities(strip_tags($_GET['page']));
$info['AnimalName'] = trim(file_get_contents("/var/dashboard/statuses/animal_name"));
//$info['AnimalName'] = "Randy Pink Unicorn";
$info['PubKey'] = trim(file_get_contents("/var/dashboard/statuses/pubkey"));
//$info['PubKey'] = "112Bjj7KtKdxngpv3oig6iqBEHJ8kMTAZWBQFBcmpiaUCCcFbsc3";
$info['OnlineStatus'] = trim(file_get_contents("/var/dashboard/statuses/online_status"));
$info['CurrentBlockHeight'] = trim(file_get_contents("/var/dashboard/statuses/current_blockheight"));
$infoheight = explode("\t\t", trim(file_get_contents("/var/dashboard/statuses/infoheight")));
$info['MinerBlockHeight'] = $infoheight[1];
$info['SN'] = trim(file_get_contents("/var/dashboard/statuses/sn"));
//$info['SN'] = "10000080081355"
$info['Version'] = trim(file_get_contents("/var/dashboard/version"));
$info['Update'] = trim(file_get_contents("/var/dashboard/update"));
if (empty($info['CurrentBlockHeight']))
{
        $sync = '<li><p style="color:#FE2D00">Helium API Error</p></li><br />';
}
elseif($info['MinerBlockHeight'] >= $info['CurrentBlockHeight'])
{
        $sync = '<li><p style="color:#2BFF97">Fully Synced!</p></li><br />';
}
else
{
        $sync = '<li><p style="color:yellow">Syncing</p></li><br />';
}
?>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/fonts.css" />
<link rel="stylesheet" href="css/hack.css" />
<script src="js/functions.js"></script>
<title>Pisces Miner Dashboard</title>
</head>

<body>
	<header>
		<div id="logo_container">
			<a href="/index.php" title="Home"><img src="images/logo.png" /></a>
		</div>

		<div id="power_container">
			<a href="#" title="Reboot miner" onclick="RebootDevice();"><span class="icon-switch"></span></a>
		</div>

		<br class="clear" />
	</header>

	<div id="main">
		<nav>
			<ul>
				<li <?php if($page == 'home' || $page == '') { echo 'class="active_page"'; } ?>><a href="/index.php" title="Homepage"><span class="icon-home"></span><span class="text">Home</span></a></li>
				<li <?php if($page == 'tools') { echo 'class="active_page"'; } ?>><a href="/?page=tools" title="Tools"><span class="icon-wrench"></span><span class="text">Tools</span></a></li>
				<li <?php if($page == 'info') { echo 'class="active_page"'; } ?>><a href="/?page=info" title="Information"><span class="icon-info"></span><span class="text">Info</span></a></li>
			</ul>

		</nav>

		<section id="content">
			<?php
			switch($page)
			{
				case 'home':
					include('/var/dashboard/pages/home.php');
					break;

				case 'tools':
					include('/var/dashboard/pages/tools.php');
					break;

				case 'info':
					include('/var/dashboard/pages/info.php');
					break;

				case '404':
					include('/var/dashboard/pages/404.php');
					break;

				case 'rebooting':
					include('/var/dashboard/pages/rebooting.php');
					break;
				case 'updateminer':
					include('/var/dashboard/pages/updateminer.php');
					break;

				case 'updatedashboard':
					include('/var/dashboard/pages/updatedashboard.php');
					break;

				case 'clearblockchain':
					include('/var/dashboard/pages/clearblockchain.php');
					break;

				default:
					include('/var/dashboard/pages/home.php');
					break;
			}
			?>
		</section>

		<section id="status_panel">
			<div id="info_height_panel">
				<span class="icon-grid"></span>
				<h3>BlockChain Info</h3>
				<ul id="info_height_data">
					<?php
					echo $sync.'<li>Miner Height: '.$info['MinerBlockHeight'].'</li><li>Live Height: '.$info['CurrentBlockHeight'].'</li><li>Online Status: '.$info['OnlineStatus'].'</li>'; ?>
				</ul>
			</div>

			<div id="public_key_panel">
				<span class="icon-key"></span>
				<h3>Public Key</h3>
				<div id="public_key_data"><?php echo '<a href="https://explorer.helium.com/hotspots/'.$info['PubKey'].'">'.ucwords($info['AnimalName']).'</a>'; ?><br />SN: <?php echo $info['SN']; ?></div>
			</div>
		</section>

		<footer>
            <a href="https://github.com/shrykez/PiscesQoLDashboard">Dashboard</a> Version: <?php echo $info['Version'];
                if($info['Version'] != $info['Update'])
                {
                	echo '<br />Built and designed to near perfection by <span style="color:#5DADE2">Briffy</span><br />Perfected with the Ultimate Super Sick Sync Display by <span style="color:#F1948A">ShrykeZ</span>';
                    //echo ' - <a href="https://github.com/briffy/PiscesQoLDashboard" title="Update Releases">Update Available - '.$info['Update'].'</a>';
                }
            ?>
        </footer>
		<br class="clear" />
	</div>
</body>
</html>
