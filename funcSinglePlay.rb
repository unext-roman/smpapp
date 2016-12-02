#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・単話見放題再生する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class SinglePlay

	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testSinglePlay
	#Activity: Perform a single content playing operation from title details
	#Param: object
	####################################################

	def testSinglePlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST SINGLE SVOD PLAY@単話見放題再生"

		$totalTest = $totalTest + 1
		
		SinglePlay.new.getSvodContent(client)
		SinglePlay.new.playfromTitleDetails(client)
		client.sleep(2000)

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 3
		@testcase_summary = "単話見放題再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgTanwa
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: getSvodContent
	#Activity: Function for getting SVOD content to be played
	#Param: object
	####################################################

	def getSvodContent(client)
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and @id='textView']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=見放題で楽しめる厳選良作！洋画編")
				client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='見放題で楽しめる厳選良作！洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
				client.sleep(2000)
			else
				client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=邦画一覧", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=すべての作品", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=見放題", 0, 1)
				client.sleep(3000)
				client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", 0, 1)
				client.sleep(2000)
			end
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end		
	end

	####################################################
	#Function Name: playfromTitleDetails
	#Activity: Function for playing from title details
	#Param: object
	####################################################

	def playfromTitleDetails(client)

		begin
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='thumbnail_container']]", 0, 1)		#2.11.0~
			client.sleep(15000)
			puts "::MSG:: 再生を開始する「Playing operation started」"
			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)

			$startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "再生開始時間 : " + $startTime
			client.sleep(8000)
			
			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "再生終了時間 : " + $endTime
			
			if $endTime == $startTime
				$errMsgTanwa = "::MSG:: 再生が開始しません、失敗しました「Playback has not started, check status」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "::MSG:: 再生が開始しました、成功しました「Playback has started successfully」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult				
			end
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
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
			puts "::MSG:: タイトル詳細へ戻る「Returned to Title details screen」"	
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@id='search_kind_selector']", 0)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			end
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testSinglePlay
	#Activity: Perform single play operation
	#Param: object
	####################################################

	def ios_testSinglePlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST SINGLE MOVIE PLAY@単話見放題再生"

		$totalTest = $totalTest + 1 

		SinglePlay.new.igetSvodContent(client)
		SinglePlay.new.ios_playfromTitleDetails(client)
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 3
		@testcase_summary = "単話見放題再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgTanwa
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: getSvodContent
	#Activity: Function for getting SVOD content to be played
	#Param: object
	####################################################

	def igetSvodContent(client)
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='タイトルとの一致']") == true || client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]") == true
				$obj_gener.icheckSearchField(client)
			end
			client.click("NATIVE", "text=邦画一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=すべての作品", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=見放題", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end		
	end

	####################################################
	#Function Name: playfromTitleDetails
	#Activity: Function for playing from title details
	#Param: object
	####################################################

	def ios_playfromTitleDetails(client)

		begin	
			client.sleep(1000)		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./preceding-sibling::*[@class='UNextMobile_Protected.UNGradientView'] and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
			client.sleep(15000)	
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + $startTime

			client.sleep(8000)

			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Ending time : " + $endTime

			if $endTime == $startTime
				$errMsgTanwa = "::MSG:: 再生が開始しません、失敗しました「Playback has not started, check status」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult					
			else
				@@comment = "::MSG:: 再生が開始しました、成功しました「Playback has started successfully」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
		end
		begin			
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_pause']", 0, 1)
			client.sleep(2500)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			client.sleep(300)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='navbar_button_back.png']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='main_nav_close.png']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@class='UNextMobile_Protected.UNTitleListHeaderView']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIControl']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end
end