#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・購入済みから再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class PurchasePlay

	@@comment = ""

	####################################################
	#target Device: Android
	#Function Name: testPurchasedPlay
	#Activity: Function to play content from purchased list
	#Param: object
	####################################################

	def testPurchasedItemPlay(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST PLAY FROM PURCHASED@購入済みから再生"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin	
			if client.isElementFound("NATIVE", "text=つづきを再生")
				PurchasePlay.new.purchasedList(client)
			else
				client.sleep(3000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
				PurchasePlay.new.purchasedList(client)
			end
		rescue Exception => e
			$errMsgBougt = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 8
		@testcase_summary = "購入済みから再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgBougt
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_dwnld.testSingleDownload(client))		
	end

	####################################################
	#Function Name: purchasedList
	#Activity: Function for opening purchased list
	#Param: object
	####################################################

	def purchasedList(client)

		begin
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
					client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
					$startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
					puts "Starting time : " + $startTime

					client.sleep(10000)

					client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
					$endTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
					puts "Ending time : " + $endTime

					if $endTime == $startTime
						$errMsgBougt = "::MSG::「再生が失敗しました」Playback has not started, check status!!!"
						$obj_rtnrs.returnNG
						$obj_rtnrs.printResult			
					else
						@@comment = "::MSG::「再生が成功しました」Playback has started successfully..."
						$obj_rtnrs.returnOK
						$obj_rtnrs.printResult			
					end
					$obj_histp.leavingPlayer(client)
				end
			end
		rescue Exception => e
			$errMsgBougt = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			$obj_rtnrs.returnNG
		end
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
	    	client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgBougt = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
	end

	####################################################
	#Target Device: iOS
	#Function Name: testPurchasedPlay
	#Activity: Function to play content from purchased list
	#Param: object
	####################################################

	def ios_testPurchasedItemPlay(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST PLAYING FROM PURCHASED@購入済みから再生"

		$totalTest = $totalTest + 1 
		
		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				PurchasePlay.new.ios_purchasedList(client)
			else
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
				PurchasePlay.new.ios_purchasedList(client)
			end
		rescue Exception => e
			$errMsgBougt = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 8
		@testcase_summary = "購入済みから再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgBougt
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_mylst.ios_testMylistContent(client))	
	end

	####################################################
	#Function Name: purchasedList
	#Activity: Function for opening purchased list
	#Param: object
	####################################################

	def ios_purchasedList(client)

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='購入済み']", 0, 1)
			
			if client.isElementFound("NATIVE", "text=購入済み")
				if client.isElementFound("NATIVE", "text=購入済みの作品がありません")
					puts "::MSG:: There is no item in purchased list!!!"
				else
					if client.waitForElement("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 30000)
		    			# If statement
					end
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)				
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and ./parent::*[./preceding-sibling::*[@class='UNextMobile_Protected.UNGradientView'] and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
					client.sleep(20000)
					PurchasePlay.new.ios_playbackCheckFromTitleDetails(client)
					$obj_histp.ios_leavingPlayer(client)
				end
			end
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='main_nav_close.png']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[./*[@text='購入済み']]]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgBougt = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
	end

	####################################################
	#Function Name: ios_playbackCheck
	#Activity: Function for playback checking
	#Param: object
	####################################################

	def ios_playbackCheckFromTitleDetails(client)
		puts "::MSG:: Playing operation started..."
			
		begin		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + $startTime

			client.sleep(5000)

			if $startTime.include? ":"
				@@comment = "::MSG:: 購入済みからの再生は成功です「Playback successfully」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult	
			else
				$errMsgBougt = "::MSG:: 購入済みからの再生は失敗しました「Could not start playback!!!」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult	
			end
		rescue Exception => e
			$errMsgBougt = "::MSG:: Exception occurrred, could not get playback time..: " + e.message
			$obj_rtnrs.returnNG
		end
	end
end