# Make dnsmasq ad-block list

[dmsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html)で利用可能なウェブ広告をブロックするためのリストファイルを生成します。

## 生成するリストファイルの例
	address=/100651.advision-adnw.jp/0.0.0.0
	address=/101com.com/0.0.0.0
	address=/101order.com/0.0.0.0
	address=/123found.com/0.0.0.0
	address=/123freeavatars.com/0.0.0.0
		:
		:
	address=/zm232.com/0.0.0.0
	address=/zmedia.com/0.0.0.0
	address=/zmnqoymznwng.com/0.0.0.0
	address=/zqtk.net/0.0.0.0
	address=/zucks.net/0.0.0.0

# 利用方法

	$ ./make_adblock_list.sh ad-block.conf
	
	===========================================
	https://280blocker.net/files/280blocker_domain.txt
	===========================================
	[head]
	googleadservices.com pagead2.googlesyndication.com exosrv.com omtrdc.net coremetrics.com 100651.advision-adnw.jp 2.chmato.me 2mdn.info 4clvr.jp a-c-engine.com
	[tail]
	cdn.neppa-ad.com fullrss.net rss.rssad.jp ads.mediams.mb.softbank.jp ad.abema.io reargooduches.pro pixel.parsely.com static.parsely.com solty.biz insight.adsrvr.org
	[wc]
	967 967 14974 /tmp/adlist_work2583/host_280domain.txt
	===========================================
	http://pgl.yoyo.org/adservers/serverlist.php?hostformat=showintro=0&mimetype=plaintext
	===========================================
	[head]
	101com.com 101order.com 123found.com 123freeavatars.com 180hits.de 180searchassistant.com 207.net 247media.com 24log.com 24log.de
	[tail]
	zencudo.co.uk zenkreka.com zenzuu.com zeus.developershed.com zeusclicks.com zlp6s.pw zm232.com zmedia.com zqtk.net zy16eoat1w.com
	[wc]
	2945 2945 48054 /tmp/adlist_work2583/host_yoyo.txt
	/mnt/c/Users/ikeuc_000/Documents/GitHub/dnsmasq_adblock/script/static_list.txt
	[head]
	adjust-net.jp adlantis.jp adresult.jp advg.jp api.flipdesk.jp b3.yahoo.co.jp b90.yahoo.co.jp b91.yahoo.co.jp eimg.jp fout.jp
	[tail]
	genieesspv.jp gmossp-sp.jp gsspat.jp gsspcln.jp gssprt.jp i-mobile.co.jp image.rakuten.co.jp impact-ad.jp js.ptengine.jp log.affiliate.rakuten.co.jp
	[wc]
	20 20 274 /tmp/adlist_work2583/host_static.txt

## ad-block.conf の中身
	$ tail ad-block.conf
	address=/zeusclicks.com/0.0.0.0
	address=/zeus.developershed.com/0.0.0.0
	address=/ziyu.net/0.0.0.0
	address=/zlp6s.pw/0.0.0.0
	address=/zm232.com/0.0.0.0
	address=/zmedia.com/0.0.0.0
	address=/zmnqoymznwng.com/0.0.0.0
	address=/zqtk.net/0.0.0.0
	address=/zucks.net/0.0.0.0
	address=/zy16eoat1w.com/0.0.0.0

# dnsmasqの設定

	$ cat /etc/dnsmasq.conf
	
	# Include another lot of configuration options.
	conf-file=/etc/ad-block.conf		#←さっき作ったファイルを指定する。
	#conf-dir=/etc/dnsmasq.d

# 動作環境

CentOS7

	$ bash --version
	GNU bash, version 4.2.46(2)-release (armv7hl-redhat-linux-gnu)

Windows 10

	$ fish --version
	fish, version 2.7.1

# 連絡先

<https://ohtorii.hatenadiary.jp/> <br>
<https://github.com/ohtorii/> <br>
<https://twitter.com/ohtorii>
