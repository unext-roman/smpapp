#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・視聴履歴から再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

#/Users/admin/Desktop/github_edited

load "funcPurchasedPlay.rb"
load "utilitiesFunc.rb"

class HistoryPlay

	$obj_prcsp = PurchasePlay.new
	$tp_info6 = Utility.new

	####################################################
	#Function Name: testHistoryPlay
	#Activity: Function to buy a PPV content
	#Param: object
	####################################################

	def testHistoryPlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @視聴履歴から再生"

		$totalTest = $totalTest + 1 
		
		client.setDevice("adb:401SO")
		client.sleep(2000)

		if client.isElementFound("NATIVE", "text=つづきを再生")
			HistoryPlay.new.historyList(client)
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			HistoryPlay.new.historyList(client)
		end

		#puts ($tp_info6.calculateRatio($finishedTest))
		$foo2 = ($obj_prcsp.testPurchasedItemPlay(client))
		dateTime = $tp_info6.getTime

		rt_info8 = RegressionTestInfo.new
		rt_info8.execution_time = dateTime
		rt_info8.test_device = "ANDROID" 
		rt_info8.testcase_num = 8
		rt_info8.testcase_summary = "視聴履歴から再生"
		rt_info8.test_result = $result
		rt_info8.capture_url = $captureURL
		rt_info8.err_message = $errMsgHisto
		rt_info8.comment = ""

		return rt_info8
	end

	####################################################
	#Function Name: historyList
	#Activity: Function for opening history list
	#Param: object
	####################################################

	def historyList(client)

		client.sleep(2000)
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "xpath=//*[@text='視聴履歴']", 0, 1)
		
		if client.isElementFound("NATIVE", "xpath=//*[@text='視聴履歴']")
			puts "::MSG:: History list opened"
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=視聴履歴がありません")
				puts "::MSG:: There is no item in history list!!!"
			else
				# Check here whether content is PPV or viewing duration expired or  SVOD
				HistoryPlay.new.checkPPVorSVODorPurchased(client)			
			end
		end

		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.sleep(2000)
		client.click("NATIVE", "text=ホーム", 0, 1)
	end

	####################################################
	#Function Name: checkPPVorSVODorPurchased
	#Activity: Function for checking content's type
	#Param: object
	####################################################

	def checkPPVorSVODorPurchased(client)

		client.sleep(1000)
		nolstitem = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='download_indicator'])", "id")
		puts "Number of image view visible in the screen:\n #{nolstitem}"
		cnt = nolstitem.length
		puts "Number of contents found in the list is : #{cnt}"

		if cnt == 1
			client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='download_indicator'])")
			client.sleep(20000)
			HistoryPlay.new.playbackCheck(client)
			HistoryPlay.new.leavingPlayer(client)
		else
			for i in 1..cnt
				client.click("NATIVE", "xpath=(//*[@id='drawerList']/*/*[@id='imageView'])[#{i}]")
				client.sleep(1000)
				if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
					puts "::MSG:: Using a PPV or SVOD content for this test"
					client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
					client.sleep(1000)
					client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='download_indicator'])[#{i}]")
					client.sleep(10000)
					HistoryPlay.new.playbackCheck(client)
					HistoryPlay.new.leavingPlayer(client)
				else
					i = i + 1				
				end
				break #for
			end #for
		end	
	end

	####################################################
	#Function Name: leavingPlayer
	#Activity: Function for leaving player screen
	#Param: object
	####################################################

	def leavingPlayer(client)

		client.sleep(5000)
		if client.waitForElement("NATIVE", "xpath=//*[@class='android.view.View']", 0, 120000)
	    	# If statement
		end
		client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
		client.click("NATIVE", "xpath=//*[@id='play_pause_button']", 0, 1)

		if client.waitForElement("NATIVE", "xpath=//*[@class='android.view.View']", 0, 30000)
	    	# If statement
		end
		client.click("NATIVE", "xpath=//*[@id='toolbar']", 0, 1)
		client.sleep(500)
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
	end

	####################################################
	#Function Name: playbackCheck
	#Activity: Function for playback checking
	#Param: object
	####################################################

	def playbackCheck(client)

		begin		
			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "Starting time : " + $startTime

			client.sleep(10000)

			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "Ending time : " + $endTime

			if $endTime == $startTime
				puts "::MSG:: Playback has not started, check status!!!"
				$result = $resultNG
				$passCount = $passCount + 0
				$finishedTest = $finishedTest + 1
				puts "Pass count is -> #{$totalTest} / #{$passCount}"
			else
				puts "::MSG:: Playback has started successfully..."
				$result = $resultOK
				$passCount = $passCount + 1
				$finishedTest = $finishedTest + 1
				puts "Pass count is -> #{$totalTest} / #{$passCount}"
			end

		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
		end

	end
end
