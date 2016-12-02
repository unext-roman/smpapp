#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・つづきを再生する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class ContinuePlay

	@@comment = ""

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
				if client.waitForElement("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='download_indicator'])[3]", 0, 10000)
		    		client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='download_indicator'])[3]", 0, 1)
					ContinuePlay.new.playingOperation(client)
				end

			else
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
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: playingOperation
	#Activity: Function to perform playing operation
	#Param: object
	####################################################

	def playingOperation(client)

		client.sleep(15000)
		begin		
			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "Starting time : " + $startTime

			client.sleep(8000)

			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "Ending time : " + $endTime

			if $endTime == $startTime
				$errMsgConti = "::MSG::「続きを再生が失敗しました」 Playback has not started, check status!!!"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult	
			else
				@@comment = "::MSG::「続きを再生が成功しました」 Playback has started successfully..."
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult			
			end
		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			$obj_rtnrs.returnNG
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
		@comment = @@comment
		
		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: playingOperation
	#Activity: Function to perform playing operation
	#Param: object
	####################################################

	def ios_playingOperation(client)

		client.sleep(15000)
		puts "::MSG:: Playing operation started..."
			
		begin		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + $startTime

			client.sleep(8000)

			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Ending time : " + $endTime

			if $endTime == $startTime
				$errMsgConti = "::MSG::「続きを再生が失敗しました」 Playback has not started, check status!!!"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult	
			else
				@@comment = "::MSG::「続きを再生が成功しました」 Playback has started successfully..."
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult			
			end
		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			$obj_rtnrs.returnNG
		end
		begin
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_pause']", 0, 1)
			client.sleep(300)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='navbar_button_back.png']", 0, 1)
		rescue Exception => e
			$errMsgConti = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end
end