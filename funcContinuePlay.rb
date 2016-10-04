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
		puts "::MSG::[ANDROID] STARTING TEST CONTINUE PLAY@つづきを再生"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
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
		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 5
		@testcase_summary = "つづきを再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgConti
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_buypv.testBuyingPPV(client))
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
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
			end
		begin
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
		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end		
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
		puts "::MSG::[iOS] STARTING TEST CONTINUE PLAY@つづきを再生"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
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
		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end		

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 5
		@testcase_summary = "つづきを再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgConti
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_buypv.ios_testBuyingPPV(client))
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
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end
		begin
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_pause']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='navbar_button_back.png']", 0, 1)
			puts "::MSG:: Returned to Home screen..."
		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end
end