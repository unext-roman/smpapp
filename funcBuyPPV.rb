#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・PPV作品の購入する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "funcHistoryPlay.rb"
load "utilitiesFunc.rb"

class BuyPPV

	$obj_histp = HistoryPlay.new
	$tp_info5 = Utility.new

	####################################################
	#Function Name: testBuyingPPV
	#Activity: Function to buy a PPV content
	#Param: object
	####################################################

	def testBuyingPPV(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @PPV作品の購入"

		$totalTest = $totalTest + 1 

		ppv_count = 0

		client.setDevice("adb:401SO")
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.sleep(2000)
		client.click("NATIVE", "text=洋画", 0, 1)
		client.sleep(2000)
		#client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='終了間近！【SALE】FOXサーチライトピクチャーズ']]]/*/*/*[@class='android.view.View' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
		
		# Here get the number of imageView in the visible screen
		noimgvw = client.getAllValues("NATIVE", "xpath=//*[@id='imageView' and @busy='true']", "id")
		puts "Number of image view visible in the screen:\n #{noimgvw}"
		cnt = noimgvw.length
		puts "Number of contents found in the screen is : #{cnt}"

		#norclvw = client.getAllValues("NATIVE", "xpath=//*[@id='recyclerView' and @onScreen='true']", "id")
		#puts "Number of image view visible in the screen:\n #{norclvw}"
		#cnt1 = norclvw.length
		#puts "Number of element found in the screen is : #{cnt1}"

		begin
			for i in 0..cnt
				#To-Do 
				#here implement scrolling....
					if client.isElementFound("NATIVE", "xpath=//*[@id='p_badge']")
						str3 = client.elementGetProperty("NATIVE", "xpath=//*[@id='p_badge']", i, "onScreen")
				
						if str3 == "true"
							puts "::MSG:: PPV 作品を見つかりました「PPV item found」"

	#						for i in 1..cnt
							#To-Do
							# if all the contents are already purchased, then make a swipe operation to down
							#client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='終了間近！【SALE】FOXサーチライトピクチャーズ']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]")
	#						if i > 2
	#							client.elementSwipe("NATIVE", "xpath=(//*[@id='listView']/*/*[@id='recyclerView'])[1]", 0, "Right", 200, 2000)
	#						end
	#						client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[#{i}]")
							client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])", i, 1)
							client.sleep(2000)
							puts "::MSG:: 該当作品を選びました「Item from list has been clicked」"
							client.sleep(1000)
							if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
								puts "::MSG:: 該当作品は既に購入済みもしくはPPVではありません「This content has already bought or not PPV!!!」"
								client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
								# To-Do
								# finding other content, which is not bought yet!!!
							else
								puts "::MSG:: This content is PPV and can be purchased."
								if client.waitForElement("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 30000)
									BuyPPV.new.purchasingContent(client)
								end
								# breaking loop, when operation has been done successfully
								break
							end
							# count for loop
							puts "::MSG:: Checked index #{i} out of #{cnt}"
							#end
							#break
						else
							puts "::MSG:: There is no PPV content at index #{i}!!!"
						end
						i = i + 1				
					end	
				#else
					#scrolling down when all 9 element has been checked and PPV notfound
				#	client.swipe2("Up", 500, 500)
				#	cnt = 0
				#end
			end
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred, could not find any PPV item ..: " + e.message	
		end

		puts ($tp_info5.calculateRatio($finishedTest))
		$foo5 = ($obj_histp.testHistoryPlay(client))
		client.sleep(1000)
		dateTime = $tp_info5.getTime

		rt_info6 = RegressionTestInfo.new
		rt_info6.execution_time = dateTime
		rt_info6.test_device = "ANDROID" 
		rt_info6.testcase_num = 6
		rt_info6.testcase_summary = "作品の購入"
		rt_info6.test_result = $result
		rt_info6.capture_url = $captureURL
		rt_info6.err_message = $errMsgBuypv
		rt_info6.comment = ""

		return rt_info6
	end

	####################################################
	#Function Name: purchasingContent
	#Activity: Function for purchasing process
	#Param: object
	####################################################

	def purchasingContent(client)

		client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
		client.sleep(3000)
		if client.isElementFound("NATIVE", "text=レンタル／購入")
			puts "::MSG:: Entered into purchase modal"
			client.sleep(1000)
			if client.waitForElement("NATIVE", "xpath=//*[@id='button']", 0, 30000)								
				if client.isElementFound("NATIVE", "id=button")
					puts "::MSG:: Purchase button available"
				end
				#purchase operation
				client.click("NATIVE", "xpath=//*[@id='button']", 0, 1)
				client.sleep(10000)
				client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
				if client.isElementFound("NATIVE", "xpath=//*[@id='time']")
					puts "::MSG:: Content has been purchased successfully"
					$result = $resultOK
					$passCount = $passCount + 1
					$finishedTest = $finishedTest + 1
					puts "Pass count is -> #{$totalTest} / #{$passCount}"
					BuyPPV.new.leavingPlayer(client)
					client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
				else
					puts "::MSG:: Could not purchase content, check status!!!"
					$result = $resultNG
					$passCount = $passCount + 0
					$finishedTest = $finishedTest + 1
					puts "Pass count is -> #{$totalTest} / #{$passCount}"
				end
			end
		else
			puts "::MSG:: Could not get purchase modal, check status!!!"
		end		
	end


	####################################################
	#Function Name: leavingPlayer
	#Activity: Function for leaving player screen
	#Param: object
	####################################################

	def leavingPlayer(client)

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
	end
end