#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : 定数バリエブル定義
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

	$resultOK = "OK"
	$resultNG = "NG"
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
	$errMsgEpsdp = ""
	$errMsgSarch = ""
	$errMsgLnbko = ""
	$errMsgDelet = ""


	#class names

	#testLogin			:Login
	#funcSinglePlay		:SinglePlay 	:$obj_login
	#funcContinuePlay	:ContinuePlay 	:$obj_contp
	#funcBuyPPV 		:BuyPPV 		:$obj_buypv
	#funcHistoryPlay	:HistoryPlay 	:$obj_histp
	#funcPurchasedPlay 	:PurchasePlay 	:$obj_prcsp
	#funcMylistPlay 	:MyList 		:$obj_mylst
	#funcLogout 		:Logout 		:$obj_logot


	#devices names
	#client.setDevice("adb:401SO")		
	#client.setDevice("ios_app:autoIpad")	

