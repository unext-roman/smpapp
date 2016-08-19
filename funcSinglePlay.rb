#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・単話見放題再生する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

#/Users/admin/Desktop/github_edited

load "constItems.rb"
load "funcContinuePlay.rb"
load "utilitiesFunc.rb"
load "releaseTest_info.rb"

class SinglePlay

	$obj_contp = ContinuePlay.new
	$tp_info3 = Utility.new

	####################################################
	#Function Name: testSinglePlay
	#Activity: Perform a single content playing operation from title details
	#Param: object
	####################################################

	def testSinglePlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @単話見放題再生"

		$totalTest = $totalTest + 1 
		
		client.setDevice("adb:401SO")
		client.sleep(2000)
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.sleep(2000)
		client.click("NATIVE", "//*[@text='洋画']", 0, 1)
		
		if client.waitForElement("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='見放題で楽しめる厳選良作！洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 20000)
	    	# If statement
		end
		if client.isElementFound("NATIVE", "text=見放題で楽しめる厳選良作！洋画編")
			client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='見放題で楽しめる厳選良作！洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
			client.sleep(2000)
		else
			client.swipe2("Down", 250, 2000)
			client.sleep(2000)
			client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='見放題で楽しめる厳選良作！洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
			client.sleep(2000)
		end
		if client.waitForElement("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 10000)
	    	# If statement
		end
		client.sleep(1000)
		client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
		client.sleep(35000)
		puts "::MSG:: 再生を開始する「Playing operation started」"
		begin		
			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "再生開始時間 : " + $startTime

			client.sleep(10000)

			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "再生終了時間 : " + $endTime

			if $endTime == $startTime
				puts "::MSG:: 再生が開始しません、失敗しました「Playback has not started, check status」"
				$result = $resultNG
				$passCount = $passCount + 0
				puts "Pass count is -> #{$totalTest} / #{$passCount}"
				$finishedTest = $finishedTest + 1
			else
				puts "::MSG:: 再生が開始しました、成功しました「Playback has started successfully」"
				$result = $resultOK
				$passCount = $passCount + 1
				puts "Pass count is -> #{$totalTest} / #{$passCount}"
				$finishedTest = $finishedTest + 1
			end

		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
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
		
		puts "::MSG:: タイトル詳細へ戻る「Returned to Title details screen」"	
		#client.sleep(2000)
		if client.waitForElement("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 30000)
	    	# If statement
		end
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)

		#client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
		client.click("NATIVE", "text=ホーム", 0, 1)

		#puts ($tp_info3.calculateRatio($finishedTest))
		
		$foo3 = ($obj_contp.testContinuePlay(client))
		dateTime = $tp_info2.getTime

		@rt_info3 = RegressionTestInfo.new
		@rt_info3.execution_time = dateTime
		@rt_info3.test_device = "ANDROID" 
		@rt_info3.testcase_num = 3
		@rt_info3.testcase_summary = "単話見放題再生"
		@rt_info3.test_result = $result
		@rt_info3.capture_url = $captureURL
		@rt_info3.err_message = $errMsgTanwa
		@rt_info3.comment = ""

		return @rt_info3

	end
end