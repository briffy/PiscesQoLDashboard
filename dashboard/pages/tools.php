<h1>Pisces P100 Outdoor Miner Dashboard - Tools</h1>

<div id="tools_buttons">
	<ul>
		<?php
		$fastsync = trim(shell_exec("cat /var/dashboard/statuses/fastsync"));
		if($fastsync == 'false')
		{
			echo '<li id="fast_sync_button">';
			echo '<a href="#" onclick="FastSync();" title="Fast Sync">';
		}
		else
		{
			echo '<li id="fast_sync_button_disabled">';
			echo '<a href="#" title="Fast Sync in progress">';
		}
		?>
		<span class="icon-loop2"></span>
		<span class="button_title">Fast Sync</span>
		</a>
		</li>

		<li id="password_reset_button">
			<a href="#" onclick="ResetPasswordPrompt();" title="Reset Password">
				<span class="icon-key"></span>
				<span class="button_title">Reset Password</span>
			</a>
		</li>

		<li id="set_wireless_button">
				<a href="#" onclick="SetWirelessPrompt();" title="Set WiFi">
				<span class="icon-wifi"></span>
				<span class="button_title">Set WiFi</span>
			</a>
		</li>
	</ul>
</div>
