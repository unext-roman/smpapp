#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : Main メソッド
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

#/Users/admin/Desktop/github_edited

#loading android libs
load "Client.rb"
load "constItems.rb"
load "releaseTest_info.rb"
load "utilitiesFunc.rb"
load "funcStartup.rb"
load "funcLogin.rb"
load "funcLogout.rb"
load "funcSinglePlay.rb"
load "funcContinuePlay.rb"
load "funcBuyPPV.rb"
load "funcPurchasedPlay.rb"
load "funcHistoryPlay.rb"
load "funcMylistPlay.rb"
load "funcSendToDB.rb"
load "funcTitleDownload.rb"
load "funcDownloadPlay.rb"
load "funcEpisodePlay.rb"
load "setupHost.rb"
load "funcRelease.rb"

	$host = ARGV[0]
	$port = ARGV[1]
	$l_id = ARGV[2]
	$pass = ARGV[3]
	$d_type = ARGV[4]
	$d_name = ARGV[5]
	$b_no = ARGV[6]

	# Create client using defaults or using hostname and port number
	client = Mobile::Client.new("#{$host}","#{$port}", true)
	client.setProjectBaseDirectory("/Users/admin/workspace/PR_Regression")

	$obj_strtp = Startup.new
	$obj_login = Login.new
	$obj_snglp = SinglePlay.new
	$obj_contp = ContinuePlay.new
	$obj_buypv = BuyPPV.new
	$obj_histp = HistoryPlay.new
	$obj_prcsp = PurchasePlay.new
	$obj_mylst = MyList.new
	$obj_dwnld = TitleDownload.new
	$obj_dwnpl = DownlaodPlay.new
	$obj_epsdp = EpisodePlay.new
	$obj_logot = Logout.new
	$obj_utili = Utility.new
	$obj_snddb = SendResultsToDB.new
	$obj_finis = Finish.new
	

	####################################################
	#Module: Calling test functions
	#Activity: Perform main operation
	#Param: 
	####################################################

	def unextTestPrgm

		puts "**********************************************************************"
		puts "**"
		puts "*    ||       ||     ||\\    || ||======= \\   //  ==========			"
		puts "*    ||       ||     || \\   || ||         \\ //       ||				"
		puts "*    ||       ||=====||  \\  || ||=======   \\/        ||				"
		puts "*    ||       ||     ||   \\ || ||          //\\       ||				"
		puts "*     =========      ||    \\|| ||=======  //  \\      ||				"
		puts "*																		"
		puts "*			AUTOMATION SYSTEM											"
		puts "*			  v 1.0														"
		puts "**********************************************************************"

	end

	def startTest(client, dtype, dname, logid, passw)

		@dtype = dtype
		@dname = client.waitForDevice("@name='#{dname}' AND @remote='true'", 300000)
		@logid = logid
		@passw = passw		

		if @dtype == "ios"
			client.setDevice("#{@dname}")
			client.sleep(2000)
			client.launch("jp.unext.mediaplayer", true, false)
			client.sleep(5000)
			$tc2 = ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))
		elsif @dtype == "android"
			client.setDevice("#{@dname}")
			client.sleep(2000)
			client.launch("jp.unext.mediaplayer/jp.co.unext.unextmobile.MainActivity", true, false)
			client.sleep(5000)
			$tc2 = ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))
		else
			puts "::MSG:: 該当デバイスが見つかりません「Confirm target test devcie」"
		end
	end

	def sendResultsToDB(build, loginid, dtype, dname)

		@build = build
		@loginid = loginid
		@dtype = dtype
		@dname = dname

		begin
			puts "**********************************************************************"
			puts "**********************************************************************"
			puts "			TEST RESULTS 												"
			puts ""
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc2.execution_time, $tc2.testcase_num, $tc2.testcase_summary, $tc2.test_result, $tc2.capture_url, $tc2.err_message, $tc2.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc3.execution_time, $tc3.testcase_num, $tc3.testcase_summary, $tc3.test_result, $tc3.capture_url, $tc3.err_message, $tc3.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc5.execution_time, $tc5.testcase_num, $tc5.testcase_summary, $tc5.test_result, $tc5.capture_url, $tc5.err_message, $tc5.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc6.execution_time, $tc6.testcase_num, $tc6.testcase_summary, $tc6.test_result, $tc6.capture_url, $tc6.err_message, $tc6.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc7.execution_time, $tc7.testcase_num, $tc7.testcase_summary, $tc7.test_result, $tc7.capture_url, $tc7.err_message, $tc7.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc8.execution_time, $tc8.testcase_num, $tc8.testcase_summary, $tc8.test_result, $tc8.capture_url, $tc8.err_message, $tc8.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc9.execution_time, $tc9.testcase_num, $tc9.testcase_summary, $tc9.test_result, $tc9.capture_url, $tc9.err_message, $tc9.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc10.execution_time, $tc10.testcase_num, $tc10.testcase_summary, $tc10.test_result, $tc10.capture_url, $tc10.err_message, $tc10.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc11.execution_time, $tc11.testcase_num, $tc11.testcase_summary, $tc11.test_result, $tc11.capture_url, $tc11.err_message, $tc11.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc12.execution_time, $tc12.testcase_num, $tc12.testcase_summary, $tc12.test_result, $tc12.capture_url, $tc12.err_message, $tc12.comment))
			puts ($obj_snddb.insertIntoReleaseTestEachFunc($tcEnd.execution_time, $tcEnd.testcase_num, $tcEnd.testcase_summary, $tcEnd.test_result, $tcEnd.capture_url, $tcEnd.err_message, $tcEnd.comment))
			puts ($obj_snddb.insertIntoReleaseTestCycle($obj_utili.getTime, @build, @loginid, @dtype, @dname, $passCount, $failCount))
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred while sending results to DB " + e.message	
		end
	end

	unextTestPrgm
	startTest(client, $d_type, $d_name, $l_id, $pass)
	sendResultsToDB($b_no, $l_id, $d_type, $d_name)

	$obj_finis.testEnd(client)