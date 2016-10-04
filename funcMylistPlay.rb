#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・マイリストから再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class MyList

	####################################################
	#target Device: Android
	#Function Name: testMylistContent
	#Activity: Function to play content from mylist
	#Param: object
	####################################################

	def testMylistContent(client)
		client.sleep(2000)
		#client.setDevice("adb:401SO")

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @マイリストから再生機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				MyList.new.checkMylist(client)
			else
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				MyList.new.checkMylist(client)
			end
		rescue Exception => e
			$errMsgMlist = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 9
		@testcase_summary = "マイリストから再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgMlist
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		#puts ($obj_dwnld.testSingleDownload(client))
		puts ($obj_dwnpl.testDownloadPlay(client))
	end

	####################################################
	#Function Name: checkMylist
	#Activity: Function for checking mylist
	#Param: object
	####################################################

	def checkMylist(client)
		
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='マイリスト']", 0, 1)
			client.sleep(2000)
			
			if client.isElementFound("NATIVE", "xpath=//*[@text='マイリスト']")
				puts "::MSG:: Mylist opened"
				client.sleep(2000)

				if client.isElementFound("NATIVE", "text=お気に入りはありません")
					puts "::MSG:: There is no item in mylist!!!"
					puts "::MSG:: Playback has started successfully..."
					$result = $resultOK
					$passCount = $passCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"

					#Ph2.0 development: When no content in mylist, call addtomylist func
				else
					# Check here whether content is PPV or viewing duration expired or SVOD
					MyList.new.checkPPVorSVODorPurchased(client)
					client.sleep(2000)
					#client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
					client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)			
				end
			end
		rescue Exception => e
			$errMsgMlist = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
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
			nolstitem = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", "id")
			puts "Number of image view visible in the screen:\n #{nolstitem}"
			cnt = nolstitem.length
			puts "Number of contents found in the list is : #{cnt}"

			for i in 0..cnt - 1
				client.click("NATIVE", "xpath=//*[@id='thumbnail']", i, 1)
				client.sleep(1000)
				if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
					puts "::MSG:: Using a PPV or SVOD content for this test"
					client.sleep(500)
					#client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
		 			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", i, 1)
					client.sleep(10000)
					$obj_histp.playbackCheck(client)
					$obj_histp.leavingPlayer(client)
				else
					puts "::MSG:: 見放題か購入済み以外の作品を確認していません、「Except SVOD or Purchased item, plaback paused」"
					i = i + 1
					#puts "::MSG:: Could not find any SVOD content to play! Is it OK to buy PPV content? Type YES"
					#strin = gets.chomp
					#if (strin == "YES")
					#	puts "Buying PPV"
					#	$obj_buypv.purchasingContent(client)
					#	puts "::MSG:: Purchased and played successfully"
						#break
					#else
						#puts "Finishing Mylist test!!!"
					#end
				end
			break #for
			end #for
		rescue Exception => e
			$errMsgMlist = "::MSG:: Exception occurrred at MyList, could not get playback time..: " + e.message
		end	
	end

	####################################################
	#target Device: iOS
	#Function Name: testMylistContent
	#Activity: Function to play content from mylist
	#Param: object
	####################################################

	def ios_testMylistContent(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST PLAYING FROM MYLIST@マイリストから再生機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				MyList.new.ios_checkMylist(client)
			else
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				MyList.new.ios_checkMylist(client)
			end
		rescue Exception => e
			$errMsgMlist = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 9
		@testcase_summary = "マイリストから再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgMlist
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		#puts ($obj_dwnld.ios_testSingleDownload(client))
		puts ($obj_dwnpl.testDownloadPlay(client))			
	end

	####################################################
	#Function Name: is_checkMylist
	#Activity: Function for checking mylist
	#Param: object
	####################################################

	def ios_checkMylist(client)

		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='マイリスト' and @class='UILabel']", 0, 1)
			client.sleep(2000)		
			if client.isElementFound("NATIVE", "xpath=//*[@text='マイリスト']")
				client.sleep(2000)
				if client.isElementFound("NATIVE", "text=お気に入りはありません")
					puts "::MSG:: お気に入りはありません「There is no item in mylist!」"
				else
					# Check here whether content is PPV or viewing duration expired or SVOD
					MyList.new.ios_checkPPVorSVODorPurchased(client)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='main_nav_close.png']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[./*[@text='マイリスト']]]", 0, 1)				
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				end
			end
		rescue Exception => e
			$errMsgMlist = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
	end

	####################################################
	#Function Name: ios_checkPPVorSVODorPurchased
	#Activity: Function for checking SVOD or PPV
	#Param: object
	#Remarks: Could not use same func in history, 
	#         due to playing operation from differnt location but can be oprimized later
	####################################################

	def ios_checkPPVorSVODorPurchased(client)

		begin
			client.sleep(1000)
			nolstitem = client.getAllValues("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[./parent::*[./parent::*[./parent::*[@class='UITableViewWrapperView']]]]]]", "class")
			puts "Number of playable content visible in the screen:\n #{nolstitem}"
			cnt = nolstitem.length
			puts "Number of contents found in the list is : #{cnt}"

			for i in 0..cnt
				client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", i, 1)			
				client.sleep(2000)
				if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
					puts "::MSG:: Using a PPV or SVOD content for this test"
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and ./parent::*[./preceding-sibling::*[@class='UNextMobile_Protected.UNGradientView'] and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
					client.sleep(20000)
					$obj_prcsp.ios_playbackCheckFromTitleDetails(client)
					$obj_histp.ios_leavingPlayer(client)
					break
				else
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='main_nav_close.png']", 0, 1)
					i = i + 1
				end
			end #for
		rescue Exception => e
			$errMsgMlist = "::MSG:: Exception occurrred at MyList, could not get playback time..: " + e.message
		end			
	end
end	