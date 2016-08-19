#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・購入済みから再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

#/Users/admin/Desktop/github_edited

load "funcMylistPlay.rb"
load "utilitiesFunc.rb"

class PurchasePlay

	$obj_mylst = MyList.new
	$tp_info7 = Utility.new

	####################################################
	#Function Name: testPurchasedPlay
	#Activity: Function to play content from purchased list
	#Param: object
	####################################################

	def testPurchasedItemPlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @購入済みから再生"

		$totalTest = $totalTest + 1

		client.setDevice("adb:401SO")
		client.sleep(2000)
		
		if client.isElementFound("NATIVE", "text=つづきを再生")
			PurchasePlay.new.purchasedList(client)
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			PurchasePlay.new.purchasedList(client)
		end

		#puts ($tp_info7.calculateRatio($finishedTest))
		$foo6 = ($obj_mylst.testMylistContent(client))
		dateTime = $tp_info7.getTime

		rt_info7 = RegressionTestInfo.new
		rt_info7.execution_time = dateTime
		rt_info7.test_device = "ANDROID" 
		rt_info7.testcase_num = 7
		rt_info7.testcase_summary = "購入済みから再生"
		rt_info7.test_result = $result
		rt_info7.capture_url = $captureURL
		rt_info7.err_message = $errMsgBougt
		rt_info7.comment = ""

		return rt_info7

	end

	####################################################
	#Function Name: purchasedList
	#Activity: Function for opening purchased list
	#Param: object
	####################################################

	def purchasedList(client)

		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "xpath=//*[@text='購入済み']", 0, 1)
		
		if client.isElementFound("NATIVE", "text=購入済み")
			puts "::MSG:: Purchased list opened"

			if client.isElementFound("NATIVE", "text=購入済みの作品がありません")
				puts "::MSG:: There is no item in purchased list!!!"
			else
				if client.waitForElement("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='download_indicator'])[1]", 0, 30000)
					client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='download_indicator'])[1]", 0, 1)
				end
				client.sleep(20000)
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
					$errMsgBougt = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
				end
				leavingPlayer(client)
			end
		end

		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		if client.waitForElement("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 10000)
	    	client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		end
		client.click("NATIVE", "text=ホーム", 0, 1)
	end

	####################################################
	#Function Name: leavingPlayer
	#Activity: Function for leaving player screen
	#Param: object
	####################################################

	def leavingPlayer(client)

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
end