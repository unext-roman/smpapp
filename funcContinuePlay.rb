#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・つづきを再生する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class ContinuePlay

	####################################################
	#Target Device: Android
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

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc6 = ($obj_buypv.testBuyingPPV(client))		
		
		andrt5 = RegressionTestInfo.new
		andrt5.execution_time = $obj_utili.getTime
		andrt5.test_device = "ANDROID" 
		andrt5.testcase_num = 5
		andrt5.testcase_summary = "つづきを再生"
		andrt5.test_result = $result
		andrt5.capture_url = $captureURL
		andrt5.err_message = $errMsgConti
		andrt5.comment = ""

		return andrt5
	end

	####################################################
	#Function Name: playingOperation
	#Activity: Function to perform playing operation
	#Param: object
	####################################################

	def playingOperation(client)

		client.sleep(35000)
		puts "::MSG:: Playing operation started..."
			
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
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
				else
					puts "::MSG:: Playback has started successfully..."
					$result = $resultOK
					$passCount = $passCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
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

	####################################################
	#Target Device: iOS
	#Function Name: testContinuePlay
	#Activity: Perform playing operation from continious playing
	#Param: object
	####################################################

	def ios_testContinuePlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST @つづきを再生"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		if client.isElementFound("NATIVE", "text=つづきを再生")
			if client.waitForElement("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayIndicator' and ./preceding-sibling::*[./*]][1]", 0, 10000)
				puts "::MSG:: Found playing content[0]"
	    		client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./preceding-sibling::*[./*]]][1]", 0, 1)
				ContinuePlay.new.ios_playingOperation(client)
			end

		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayIndicator' and ./preceding-sibling::*[./*]][1]", 0, 1)
			ContinuePlay.new.ios_playingOperation(client)
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc6 = ($obj_buypv.ios_testBuyPPV(client))
		
		iosrt5 = RegressionTestInfo.new
		iosrt5.execution_time = $obj_utili.getTime
		iosrt5.test_device = "iOS" 
		iosrt5.testcase_num = 5
		iosrt5.testcase_summary = "つづきを再生"
		iosrt5.test_result = $result
		iosrt5.capture_url = $captureURL		
		iosrt5.err_message = $errMsgConti
		iosrt5.comment = ""

		return iosrt5
	end

	####################################################
	#Function Name: playingOperation
	#Activity: Function to perform playing operation
	#Param: object
	####################################################

	def ios_playingOperation(client)

		client.sleep(35000)
		puts "::MSG:: Playing operation started..."
			
		begin		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + $startTime

			client.sleep(10000)

			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Ending time : " + $endTime

			if $endTime == $startTime
				puts "::MSG:: 再生が開始しません、失敗しました「Playback has not started, check status」"
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
			else
				puts "::MSG:: 再生が開始しました、成功しました「Playback has started successfully」"
				$result = $resultOK
				$passCount = $passCount + 1				
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
			end

		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
		end
		
		client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_pause']", 0, 1)
		client.sleep(2000)

		client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
		client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='navbar_button_back.png']", 0, 1)
		puts "::MSG:: Returned to Home screen..."
	end
end