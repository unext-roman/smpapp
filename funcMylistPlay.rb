#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・マイリストから再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "funcLogout.rb"
load "utilitiesFunc.rb"

class MyList

	$obj_logot = Logout.new
	$tp_info8 = Utility.new

	def testMylistContent(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @マイリストから再生機能"

		$totalTest = $totalTest + 1

		client.setDevice("adb:401SO")
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

		puts ($tp_info8.calculateRatio($finishedTest))
		$foo7 = ($obj_logot.testLogout(client))
		dateTime = $tp_info8.getTime

		rt_info8 = RegressionTestInfo.new
		rt_info8.execution_time = dateTime
		rt_info8.test_device = "ANDROID" 
		rt_info8.testcase_num = 8
		rt_info8.testcase_summary = "マイリストから再生"
		rt_info8.test_result = $result
		rt_info8.capture_url = $captureURL
		rt_info8.err_message = $errMsgBougt
		rt_info8.comment = ""

		return rt_info8
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
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
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
				puts "::MSG:: Could not find any SVOD content to play! Is it OK to buy PPV content? Type YES"
				strin = gets.chomp
				if (strin == "YES")
					puts "Buying PPV"
					$obj_buypv.purchasingContent(client)
					puts "::MSG:: Purchased and played successfully"
					break
				else
					puts "Finishing Mylist test!!!"
				end
			end
		break #for
		end #for
	end	

end