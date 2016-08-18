#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・つづきを再生する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "funcBuyPPV.rb"
load "utilitiesFunc.rb"

class ContinuePlay

	$obj_buypv = BuyPPV.new
	$tp_info4 = Utility.new

	####################################################
	#Function Name: testContinuePlay
	#Activity: Perform playing operation from continious playing
	#Param: object
	####################################################

	def testContinuePlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @つづきを再生"

		$totalTest = $totalTest + 1 

		client.setDevice("adb:401SO")
		#client.launch("jp.unext.mediaplayer/jp.co.unext.unextmobile.MainActivity", true, true)

		client.sleep(2000)
		if client.isElementFound("NATIVE", "text=つづきを再生")
			puts "::MSG:: Now at home screen"
			if client.waitForElement("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='download_indicator'])[3]", 0, 10000)
				puts "::MSG:: Found playing content[0]"
	    		client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='download_indicator'])[3]", 0, 1)
				ContinuePlay.new.playingOperation(client)
			end

		else
			puts "::MSG:: Not in home screen"
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=ホーム", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='download_indicator'])[3]", 0, 1)
			ContinuePlay.new.playingOperation(client)
		end

		puts ($tp_info4.calculateRatio($finishedTest))
		$foo4 = ($obj_buypv.testBuyingPPV(client))
		dateTime = $tp_info4.getTime
		
		rt_info5 = RegressionTestInfo.new
		rt_info5.execution_time = dateTime
		rt_info5.test_device = "ANDROID" 
		rt_info5.testcase_num = 5
		rt_info5.testcase_summary = "つづきを再生"
		rt_info5.test_result = $result
		rt_info5.capture_url = $captureURL
		rt_info5.err_message = $errMsgConti
		rt_info5.comment = ""

		return rt_info5
	end

	####################################################
	#Function Name: playingOperation
	#Activity: Function to perform playing operation
	#Param: object
	####################################################

	def playingOperation(client)

		client.sleep(35000)
		#puts "::MSG:: Playing operation started..."
			
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
				$errMsgConti = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			end
		
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
		puts "::MSG:: Returned to Home screen..."
	end
end