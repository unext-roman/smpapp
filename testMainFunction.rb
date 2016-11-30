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
load "funcSelectiveTests.rb"
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
load "funcPlayEpisodeFromPlayer.rb"
load "funcChangeJifukiFromPlayer.rb"
load "funcChangeVQualityFromPlayer.rb"
load "funcTrickPlayFromPlayer.rb"
load "funcConnectCast.rb"
load "funcPlayWithoutLoggin.rb"
load "funcDownloadWithoutLoggin.rb"
load "setupHost.rb"
load "funcRelease.rb"
load "funcResultReturn.rb"

	$host = ARGV[0]
	$port = ARGV[1]
	$l_id = ARGV[2]
	$pass = ARGV[3]
	$d_type = ARGV[4]
	$d_name = ARGV[5]
 	$build_env = ARGV[6]
	$env_type = ARGV[7]	
	$t_pattern = ARGV[8]
 	$t_no = ARGV[9]

	client = Mobile::Client.new("#{$host}","#{$port}", true)

	$obj_instl = InstallApps.new
	$obj_archv = ArchiveDL.new
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
	$obj_plfel = PlayEpisodeFromPlayer.new
	$obj_chnjf = ChangeJifukiFromPlayer.new
	$obj_vqual = ChangeVQualityFromPlayer.new
	$obj_trick = TrickPlayOperation.new
	$obj_ccast = ConnectChromecast.new
	$obj_plwlg = PlaybackWithoutLogin.new
	$obj_dlwlg = DownloadWithoutLogin.new
	$obj_logot = Logout.new
	$obj_utili = Utility.new
	$obj_slctv = SelectiveTest.new
	$obj_snddb = SendResultsToDB.new
	$obj_finis = Finish.new
	$obj_rtnrs = ResultReturn.new
	
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
		puts "*			  v 2.0														"
		puts "**********************************************************************"

	end

	####################################################
	#Module: Main functions
	#Activity: Reserving a Cloud device and start Test
	#Param: 
	####################################################

	def startTest(client, dtype, dname, logid, passw, ttype, tcsno, wifis)

		#$dname = client.waitForDevice("\"@name='#{dname}' AND @remote='true'\"", 300000)
		@dtype = dtype
		@dname = dname
		@logid = logid
		@passw = passw
		@ttype = ttype
		@tcsno = tcsno
		@wifis = wifis
		@build = build

		if @ttype == "select"
			x = @tcsno.split ","
			$total_tc = x.length
		else
			$total_tc = 37
		end

		if @dtype == "ios"
			$obj_utili.andConnectingWifi(client, @dtype, @dname, @wifis)

			#temp: code for reserving a remote iOS device
			uri = URI('http://10.4.136.3:8081/api/v1/devices')
			req = Net::HTTP::Get.new(uri)
			req.basic_auth 'admin', 'Unext1101'
			#req.basic_auth 'unext-qa', 'Unextqa1'
			res = Net::HTTP.start(uri.hostname, uri.port) {|http|
			  http.request(req)
			}
			#Get the device id for the desired device
			api_result = JSON.parse(res.body)
			devices_array = api_result["data"]
			requested_device_id = ""
			
			devices_array.each do |device|
			  	if device["deviceName"] == @dname
					requested_device_id = device["id"]					
				end
			end
			#And now reserve the device
			uri = URI('http://10.4.136.3:8081/api/v1/devices/' + requested_device_id + '/reservations/new')
			req = Net::HTTP::Post.new(uri)
			req.basic_auth 'admin', 'Unext1101'
			#req.basic_auth 'unext-qa', 'Unextqa1'
			req.set_form_data('start' => Time.new.strftime("%Y-%m-%d-%H-%M-%S"), 'end' => '2016-12-30-23-00-00', 'clientCurrentTimestamp' => Time.new.strftime("%Y-%m-%d-%H-%M-%S"))
			res = Net::HTTP.start(uri.hostname, uri.port) {|http|
			  http.request(req)
			}
			client.addDevice("c24994f50118a6ae9db6a911da628b477a0ba401", "ipadair")
			client.setDevice("#{"ios_app:" + @dname}")
			#client.setDevice("#{@dname}")
			#temp

			client.openDevice()
			client.sleep(2000)
			if @build == nil
				puts "::MSG:: Apps will be using currently installed build"
			else
				puts ($obj_instl.ios_testInstallApps(client, @build))
			end
			client.launch("jp.unext.mediaplayer", true, false)
			client.sleep(5000)
			$obj_slctv.iosSelectiveTests(client, @logid, @passw, @ttype, @tcsno)
		elsif @dtype == "android"
			$obj_utili.andConnectingWifi(client, @dtype, @dname, @wifis)			
			#client.setDevice("#{$dname}")
			client.waitForDevice("\"@name='#{$dname}' AND @remote='true'\"", 300000)
			client.openDevice()
			client.sleep(2000)
			#CURRENTLY AUTO BUILD FOR ANDROID IS NOT PREPARED, WHEN JENKINS AUTO BUILD WILL BE DELIVERED, TEST CAN BE RESUMED
			#if @build == nil
			#	puts "::MSG:: Apps will be using currently installed build"
			#else
			#	puts ($obj_instl.testInstallApps(client, @build))
			#end
			client.launch("jp.unext.mediaplayer/jp.co.unext.unextmobile.MainActivity", true, false)
			client.sleep(5000)			
			$obj_slctv.andSelectiveTests(client, @logid, @passw, @ttype, @tcsno)		
		else
			puts "::MSG:: 該当デバイスが見つかりません「Confirm target test devcie」"
		end		
	end

	####################################################
	#Module: Main functions
	#Activity: Sending test results to DB
	#Param: build, loginid, device type, device name
	####################################################

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
	startTest(client, $d_type, $d_name, $l_id, $pass, $t_type, $t_no, $wifis)
	sendResultsToDB($b_no, $l_id, $d_type, $d_name)
	$obj_finis.testEnd(client, $d_name)
