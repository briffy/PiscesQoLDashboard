<div id="rebooting_text"><span class="icon-loop2" id="icon"></span><span id="icon_label">Rebooting...</span></div>
<script>
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function Redirect() {
	sleep(40000).then(() => {
		window.location.href = '/index.php';
	});
}

window.online = Redirect();
</script>
