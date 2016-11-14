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
		
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and @id='textView']", 0, 1)
			client.sleep(2000)
			if client.waitForElement("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='11月新規入荷！見放題で楽しめる厳選良作 洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 20000)
		    	# If statement
			end
			if client.isElementFound("NATIVE", "text=11月新規入荷！見放題で楽しめる厳選良作 洋画編")
				client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='11月新規入荷！見放題で楽しめる厳選良作 洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
				client.sleep(2000)
			#else
				#click on a SVOD item, by other way
			end
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		SinglePlay.new.playfromTitleDetails(client)
		client.sleep(2000)

		puts ($obj_utili.calculateRatio($finishedTest))

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
		#puts ($obj_contp.testContinuePlay(client))
		puts ($obj_buypv.testBuyingPPV(client))
	end

	####################################################
	#Function Name: playfromTitleDetails
	#Activity: Function for playing from title details
	#Param: object
	####################################################

	def playfromTitleDetails(client)

		begin
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
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
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
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

		begin
			client.sleep(5000)		
			if client.waitForElement("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 10000)
		    	# If statement
			end
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(2000)
			if client.waitForElement("NATIVE", "xpath=(//*[@class='UICollectionView' and ./preceding-sibling::*[@class='UIView' and ./*[@text='11月新規入荷！見放題で楽しめる厳選良作 洋画編']]]/*/*/*[@class='UNextMobile_Protected.UNAsyncImageView' and ./parent::*[./parent::*[@class='UNextMobile_Protected.HomeTitleCell']]])[1]", 0, 10000)
		    	client.click("NATIVE", "xpath=(//*[@class='UICollectionView' and ./preceding-sibling::*[@class='UIView' and ./*[@text='11月新規入荷！見放題で楽しめる厳選良作 洋画編']]]/*/*/*[@class='UNextMobile_Protected.UNAsyncImageView' and ./parent::*[./parent::*[@class='UNextMobile_Protected.HomeTitleCell']]])[1]", 0, 1)
		    	client.sleep(2000)
		    else
		    	client.click("NATIVE", "xpath=(//*[@class='UICollectionView' and ./preceding-sibling::*[@class='UIView']]/*/*[@class='UNextMobile_Protected.PayItemBagde' and @top='false'])", 0, 1)
				client.sleep(2000)
			end
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		SinglePlay.new.ios_playfromTitleDetails(client)

		puts ($obj_utili.calculateRatio($finishedTest))

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
		#puts ($obj_contp.ios_testContinuePlay(client))
		puts ($obj_buypv.ios_testBuyingPPV(client))	
	end

	####################################################
	#Function Name: playfromTitleDetails
	#Activity: Function for playing from title details
	#Param: object
	####################################################

	def ios_playfromTitleDetails(client)

		begin	
			client.sleep(1000)		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @onScreen='true' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
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
			$obj_rtnrs.returnNG
		end
		begin			
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_pause']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='navbar_button_back.png']", 0, 1)
			client.sleep(2000)
			if client.waitForElement("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main_nav_close']]", 0, 10000)
		    	# If statement
			end
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='main_nav_close.png']", 0, 1)
			client.sleep(2000)
			if client.waitForElement("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 10000)
		    	# If statement
			end
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end
end