#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : 定数バリエブル定義
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

	$resultOK = "OK"
	$resultNG = "NG"
	$resultNE = "NOT EXECUTED"
	$result = ""
	$passCount = 0
	$failCount = 0
	$totalTest = 0
	$finishedTest = 0
	$errMsg = ""
	$comment = ""
	$count = 0
	$exeTime = ""
	$captureURL = ""
	$tcs = 0
	$execution_time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
	$loginFlag = false
	$execFlag = false
	$ratioFlag = true
	$tstTyp = ""
	$dev_last_upd_time = Dir.glob("/Users/admin/ownCloud/BuildArtifacts/UNextMobile-iOS-AdHoc-CI/*.ipa").max_by {|f| File.mtime(f)}
	$tcCountFlag = false


	#Error Message List
	$errMsgLogin = ""
	$errMsgTanwa = ""
	$errMsgConti = ""
	$errMsgLogot = ""
	$errMsgBuypv = ""
	$errMsgHisto = ""
	$errMsgBougt = ""
	$errMsgMlist = ""
	$errMsgDwnld = ""
	$errMsgDwnpl = ""	
	$errMsgEpsdp = ""
	$errMsgKarch = ""
	$errMsgGsrch = ""
	$errMsgFsrch = ""
	$errMsgAdtml = ""
	$errMsgLnbko = ""
	$errMsgDelet = ""
	$errMsgEdite = ""
	$errMsgEditd = ""
	$errMsgEditm = ""
	$errMsgRtngs = ""
	$errMsgPlfep = ""
	$errMsgSubch = ""
	$errMsgQuach = ""
	$errMsgTrick = ""
	$errMsgCcast = ""
	$errMsgArply = ""
	$errMsgPlywl = ""
	$errMsgDldwl = ""

	#Strings
	

	#devices names
	#client.setDevice("adb:401SO")		
	#client.setDevice("ios_app:autoIpad")	

