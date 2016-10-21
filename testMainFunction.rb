#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : Main メソッド
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

require 'json'

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
load "funcKeySearch.rb"
load "funcGenerSearch.rb"
load "funcFilterDisplay.rb"
load "funcAddToMylist.rb"
load "funcLeanbackOpe.rb"
load "funcEditHistory.rb"
load "funcEditDownload.rb"
load "funcEditMylist.rb"
load "funcItemRatings.rb"
load "setupHost.rb"
load "funcRelease.rb"

	$host = ARGV[0]
	$port = ARGV[1]
	$l_id = ARGV[2]
	$pass = ARGV[3]
	$d_type = ARGV[4]
	$d_name = ARGV[5]
	$b_no = ARGV[6]

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
	$obj_keysh = KeywordSearch.new
	$obj_gener = GenericSearch.new
	$obj_fltrs = FilterSearch.new
	$obj_adtml = AddToMylist.new
	$obj_lnbck = Leanback.new
	$obj_edith = EditHistory.new
	$obj_editd = EditDownload.new
	$obj_editm = EditMylist.new
	$obj_rtngs = ItemRatings.new
	$obj_logot = Logout.new
	$obj_utili = Utility.new
	$obj_snddb = SendResultsToDB.new
	$obj_finis = Finish.new
	
	$dname = ""
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

		@dname = dname
		@dtype = dtype
		#$dname = client.waitForDevice("\"@name='#{dname}' AND @remote='true'\"", 300000)
		$dname = dname
		@logid = logid
		@passw = passw


		if @dtype == "ios"
			#client.setDevice("#{$dname}")
			#client.waitForDevice("\"@name='#{$dname}' AND @remote='true'\"", 300000)
			#sagi code
			#Request the devices list - Make sure you enter the right credential
			uri = URI('http://10.4.136.3:8081/api/v1/devices')
			req = Net::HTTP::Get.new(uri)
			req.basic_auth 'unext-qa', 'Unextqa1'
			res = Net::HTTP.start(uri.hostname, uri.port) {|http|
			  http.request(req)
			}
			#Get the device id for the desired device
			api_result = JSON.parse(res.body)
			devices_array = api_result["data"]
			requested_device_id = ""

			devices_array.each do |device|
			  	if device["deviceName"] == @dname
			  		puts device["id"].class
					#requested_device_id.to_i = device["id"]
					requested_device_id.push(device["id"])
				end
			end
			#And now reserve the device
			uri = URI('http://sales.experitest.com/api/v1/devices/' + requested_device_id + '/reservations/new')
			req = Net::HTTP::Post.new(uri)
			req.basic_auth 'unext-qa', 'Unextqa1'
			req.set_form_data('start' => Time.new.strftime("%Y-%m-%d-%H-%M-%S"), 'end' => '2016-10-22-13-00-00', 'clientCurrentTimestamp' => Time.new.strftime("%Y-%m-%d-%H-%M-%S"))
			res = Net::HTTP.start(uri.hostname, uri.port) {|http|
			  http.request(req)
			}
			client.setDevice("#{$dname}")
			#sagi code

			client.openDevice()
			client.sleep(2000)
			client.launch("jp.unext.mediaplayer", true, false)
			client.sleep(5000)
			puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))
		elsif @dtype == "android"
			#client.setDevice("#{$dname}")
			client.waitForDevice("\"@name='#{$dname}' AND @remote='true'\"", 300000)
			client.openDevice()
			client.sleep(2000)
			client.launch("jp.unext.mediaplayer/jp.co.unext.unextmobile.MainActivity", true, false)
			client.sleep(5000)
			puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))
		else
			puts "::MSG:: 該当デバイスが見つかりません「Confirm target test devcie」"
		end
		#client.releaseDevice("#{$dname}", true, true, true)
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
			if $execution_time == nil
				@exetime = $execution_time
			else
				@exetime = $execution_time
			end
			puts ($obj_snddb.insertIntoReleaseTestCycle(@exetime, @build, @loginid, @dtype, @dname, $passCount, $failCount))
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred while sending results to DB " + e.message	
		end
	end

	unextTestPrgm
	startTest(client, $d_type, $d_name, $l_id, $pass)
	sendResultsToDB($b_no, $l_id, $d_type, $d_name)
	$obj_finis.testEnd(client, $dname)
