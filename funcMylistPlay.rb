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
		client.setDevice("adb:401SO")

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @マイリストから再生機能"

		$totalTest = $totalTest + 1
		client.sleep(2000)
		
		if client.isElementFound("NATIVE", "text=つづきを再生")
			MyList.new.checkMylist(client)
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			MyList.new.checkMylist(client)
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc10 = ($obj_dwnld.testSingleDownload(client))		

		andrt9 = RegressionTestInfo.new
		andrt9.execution_time = $obj_utili.getTime
		andrt9.test_device = "ANDROID" 
		andrt9.testcase_num = 9
		andrt9.testcase_summary = "マイリストから再生"
		andrt9.test_result = $result
		andrt9.capture_url = $captureURL
		andrt9.err_message = $errMsgMlist
		andrt9.comment = ""

		return andrt9
	end

	def checkMylist(client)
		
		client.sleep(2000)
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "xpath=//*[@text='マイリスト']", 0, 1)
		client.sleep(2000)
		
		if client.isElementFound("NATIVE", "xpath=//*[@text='マイリスト']")
			puts "::MSG:: Mylist opened"
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=お気に入りはありません")
				puts "::MSG:: There is no item in mylist!!!"
			else
				# Check here whether content is PPV or viewing duration expired or SVOD
				MyList.new.checkPPVorSVODorPurchased(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)			
			end
		end		
	end

	####################################################
	#Function Name: checkPPVorSVODorPurchased
	#Activity: Function for checking content's type
	#Param: object
	####################################################

	def checkPPVorSVODorPurchased(client)

		client.sleep(1000)
		nolstitem = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", "id")
		puts "Number of image view visible in the screen:\n #{nolstitem}"
		cnt = nolstitem.length
		puts "Number of contents found in the list is : #{cnt}"

		begin
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
			$errMsgMlist = "::MSG:: Exception occurrred @MyList, could not get playback time..: " + e.message
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
		puts "::MSG::[iOS] STARTING TEST @マイリストから再生機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)		
		if client.isElementFound("NATIVE", "text=つづきを再生")
			MyList.new.ios_checkMylist(client)
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			MyList.new.ios_checkMylist(client)
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc10 = ($obj_dwnld.testSingleDownload(client))		

		iosrt9 = RegressionTestInfo.new
		iosrt9.execution_time = $obj_utili.getTime
		iosrt9.test_device = "iOS" 
		iosrt9.testcase_num = 9
		iosrt9.testcase_summary = "マイリストから再生"
		iosrt9.test_result = $result
		iosrt9.capture_url = $captureURL
		iosrt9.err_message = $errMsgMlist
		iosrt9.comment = ""

		return iosrt9		
	end

	def ios_checkMylist(client)
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
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='Back' and ./preceding-sibling::*[./*[@text='マイリスト']]]", 0, 1)				
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			end
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

		client.sleep(1000)
		nolstitem = client.getAllValues("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[./parent::*[./parent::*[./parent::*[@class='UITableViewWrapperView']]]]]]", "class")
		puts "Number of playable content visible in the screen:\n #{nolstitem}"
		cnt = nolstitem.length
		puts "Number of contents found in the list is : #{cnt}"

		begin
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
					client.sleep(1000)
					client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='main_nav_close.png']", 0, 1)
					i = i + 1
				end
			end #for
		rescue Exception => e
			$errMsgMlist = "::MSG:: Exception occurrred @MyList, could not get playback time..: " + e.message
		end			
	end
end	