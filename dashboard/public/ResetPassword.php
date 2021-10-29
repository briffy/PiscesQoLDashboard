<?php
$current_users_tmp = explode("\n", file_get_contents("/var/dashboard/.htpasswd"));
$current_users = [];
$x = 0;

$clearTextPassword = trim(htmlentities(strip_tags($_POST['password'])));
$confirmPassword = trim(htmlentities(strip_tags($_POST['confirmpassword'])));

if(($clearTextPassword == $confirmPassword) && $clearTextPassword != "")
{
	function crypt_apr1_md5($plainpasswd)
	{
		$salt = substr(str_shuffle("abcdefghijklmnopqrstuvwxyz0123456789"), 0, 8);
		$len = strlen($plainpasswd);
		$text = $plainpasswd.'$apr1$'.$salt;
		$bin = pack("H32", md5($plainpasswd.$salt.$plainpasswd));
		for($i = $len; $i > 0; $i -= 16)
		{
			$text .= substr($bin, 0, min(16, $i));
		}

		for($i = $len; $i > 0; $i >>= 1)
		{
			$text .= ($i & 1) ? chr(0) : $plainpasswd{0};
		}

		$bin = pack("H32", md5($text));
		for($i = 0; $i < 1000; $i++)
		{
			$new = ($i & 1) ? $plainpasswd : $bin;
			if ($i % 3) $new .= $salt;
			if ($i % 7) $new .= $plainpasswd;
			$new .= ($i & 1) ? $bin : $plainpasswd;
			$bin = pack("H32", md5($new));
		}
		for ($i = 0; $i < 5; $i++)
		{
			$k = $i + 6;
			$j = $i + 12;
			if ($j == 16) $j = 5;
			$tmp = $bin[$i].$bin[$k].$bin[$j].$tmp;
		}

		$tmp = chr(0).chr(0).$bin[11].$tmp;
		$tmp = strtr(strrev(substr(base64_encode($tmp), 2)),
			"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
			"./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz");

		return "$"."apr1"."$".$salt."$".$tmp;
	}

	$password = crypt_apr1_md5($clearTextPassword);

	foreach($current_users_tmp as $key => $value)
	{
		if($value != "")
		{
			$data = explode(":", $value);
			$current_users[$x]['username'] = $data[0];
			$current_users[$x]['password'] = $data[1];
			$x++;
		}

	}

	foreach($current_users as $key => $value)
	{
		if($value['username'] == 'admin')
		{
			$current_users[$key]['password'] = $password;
		}
	}

	$newfile = "";

	foreach($current_users as $key => $value)
	{
		$newfile .= $value['username'].":".$value['password']."\n";
	}

	$htpasswdfile = fopen("/var/dashboard/.htpasswd", "w");

	fwrite($htpasswdfile, $newfile);

	$sshpasswordfile = fopen("/var/dashboard/password", "w");
	fwrite($sshpasswordfile, $clearTextPassword);

	echo 'Password Reset';
}

else
{
	echo 'Password reset failed';
}
?>
