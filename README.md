# Make dnsmasq ad-block list

dmsmasq で広告をブロックするためこんなリストを生成します。

	address=/100651.advision-adnw.jp/0.0.0.0
	address=/101com.com/0.0.0.0
	address=/101order.com/0.0.0.0
	address=/123found.com/0.0.0.0
	address=/123freeavatars.com/0.0.0.0
	...
	address=/zm232.com/0.0.0.0
	address=/zmedia.com/0.0.0.0
	address=/zmnqoymznwng.com/0.0.0.0
	address=/zqtk.net/0.0.0.0
	address=/zucks.net/0.0.0.0

# 利用方法

	$ ./make_adblock_list.sh --help
	make_adblock_list.sh output_list_name


# 動作環境
 
 CentOSで動作を確認。

# 連絡先

<http://d.hatena.ne.jp/ohtorii/> <br>
<https://github.com/ohtorii/everything> <br>
<https://twitter.com/ohtorii>