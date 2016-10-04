#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・視聴履歴から再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class HistoryPlay

	####################################################
	#Target Device: Android
	#Function Name: testHistoryPlay
	#Activity: Function to buy a PPV content
	#Param: object
	####################################################

	def testHistoryPlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST PLAY FORM HISTORY@視聴履歴から再生"

		$totalTest = $totalTest + 1 
		
		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				HistoryPlay.new.historyList(client)
			else
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				HistoryPlay.new.historyList(client)
			end
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 7
		@testcase_summary = "視聴履歴から再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgHisto
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_prcsp.testPurchasedItemPlay(client))
	end

	####################################################
	#Function Name: historyList
	#Activity: Function for opening history list
	#Param: object
	####################################################

	def historyList(client)

		begin
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
					HistoryPlay.new.checkPPVorSVODorPurchased(client)			
				end
			end
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
	end

	####################################################
	#Function Name: checkPPVorSVODorPurchased
	#Activity: Function for checking content's type
	#Param: object
	####################################################

	def checkPPVorSVODorPurchased(client)

		begin
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
				client.sleep(2000)
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
						client.sleep(2000)
					else
						i = i + 1				
					end
					break #for
				end #for
			end
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end
	end

	####################################################
	#Function Name: leavingPlayer
	#Activity: Function for leaving player screen
	#Param: object
	####################################################

	def leavingPlayer(client)

		begin
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
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
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
			$errMsgHisto = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end
	end

	####################################################
	#Target Device: iOS
	#Function Name: testHistoryPlay
	#Activity: Function to buy a PPV content
	#Param: object
	####################################################

	def ios_testHistoryPlay(client)
		client.sleep(2000)
		client.setDevice("ios_app:autoIpad")

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST PLAYING FROM HISTORY@視聴履歴から再生"

		$totalTest = $totalTest + 1 
		
		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				HistoryPlay.new.ios_historyList(client)
			else
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				HistoryPlay.new.ios_historyList(client)
			end
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		puts ($obj_utili.calculateRatio($finishedTest))		

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 7
		@testcase_summary = "視聴履歴から再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgHisto
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_prcsp.ios_testPurchasedItemPlay(client))
	end

	####################################################
	#Function Name: historyList
	#Activity: Function for opening history list
	#Param: object
	####################################################

	def ios_historyList(client)

		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='視聴履歴']", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "xpath=//*[@text='視聴履歴']")
				puts "::MSG:: History list opened"
				client.sleep(2000)

				if client.isElementFound("NATIVE", "text=視聴履歴がありません")
					puts "::MSG:: There is no item in history list!!!"
				else
					HistoryPlay.new.ios_checkPPVorSVODorPurchased(client)			
				end
			end

			#client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @width>0 and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end

	####################################################
	#Function Name: ios_checkPPVorSVODorPurchased
	#Activity: Function for checking SVOD or PPV
	#Param: object
	####################################################

	def ios_checkPPVorSVODorPurchased(client)

		begin
			client.sleep(1000)
			nolstitem = client.getAllValues("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[./parent::*[./parent::*[./parent::*[@class='UITableViewWrapperView']]]]]]", "class")
			puts "Number of playable content visible in the screen:\n #{nolstitem}"
			cnt = nolstitem.length - 1
			puts "Number of contents found in the list is : #{cnt}"

			for i in 0..cnt
				#client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView']", cnt, 1)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNMovieItemCell']", i, 1)			
				client.sleep(2000)
				if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
					puts "::MSG:: Using a PPV or SVOD content for this test"
					client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView']", i, 1)
					client.sleep(10000)
					HistoryPlay.new.ios_playbackCheckFromList(client)
					HistoryPlay.new.ios_leavingPlayer(client)
				else
					i = i + 1				
				end
				break #for
			end #for
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end	
	end

	####################################################
	#Function Name: leavingPlayer
	#Activity: Function for leaving player screen
	#Param: object
	####################################################

	def ios_leavingPlayer(client)

		begin
			puts "::MSG:: Tapped on seekbar..."
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_pause']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='navbar_button_back.png']", 0, 1)
		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end

	####################################################
	#Function Name: playbackCheck
	#Activity: Function for playback checking
	#Param: object
	####################################################

	def ios_playbackCheckFromList(client)

		client.sleep(10000)
		puts "::MSG:: Playing operation started..."
			
		begin		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + $startTime

			client.sleep(5000)
			if $startTime.include? ":"
				puts "::MSG:: 視聴履歴からの再生は成功です「Playback successfully」"
				$result = $resultOK
				$passCount = $passCount + 1
				$finishedTest = $finishedTest + 1				
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
			else
				puts "::MSG:: 視聴履歴からの再生は失敗しました「Could not start playback!!!」"
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
			end

		rescue Exception => e
			$errMsgHisto = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
		end
	end
end
