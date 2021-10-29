<?php
$info['PeerList'] = trim(file_get_contents("/var/dashboard/statuses/peerlist"));
$uri = "https://explorer.helium.com/hotspots/".$info['PubKey'];


$pattern= "/\/ip4\/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)[^|]+\|(\/p2p\/[^\|]+)\|([^\|]+)/i";
preg_match_all($pattern, $info['PeerList'], $results);

$info['PeerList'] = [];

$x = 0;
foreach($results[3] as $key => $value)
{
	$info['PeerList'][$x]['ip'] = $results[1][$key];
	$info['PeerList'][$x]['name'] = $value;
	$info['PeerList'][$x]['p2p'] = $results[2][$key];
	$x++;
}
?>
<h1>Pisces P100 Outdoor Miner Dashboard - Information</h1>

<iframe
style="width: 100%; border-radius: 10px; box-shadow: 2px 2px 10px rgba(0,0,0,0.5);"
height="650"
frameborder="0" style="border:0"
src="<?php echo $uri; ?>" allowfullscreen>
</iframe>

<div id="peer_list">
<h2>Peer List</h2>
<table>
<tr>
<th>Remote IP</th>
<th>Name</th>
<th>P2P Address</th>
</tr>
<?php
foreach($info['PeerList'] as $result)
{
echo '<tr>';
echo '<td>'.$result['ip'].'</td>';
echo '<td>'.$result['name'].'</td>';
echo '<td>'.$result['p2p'].'</td>';
echo '</tr>';
}
?>
</tbody>
</table>
</div>
