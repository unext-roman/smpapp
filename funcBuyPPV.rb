#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・PPV作品の購入する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class BuyPPV

	####################################################
	#target Device: Android
	#Function Name: testBuyingPPV
	#Activity: Function to buy a PPV content
	#Param: object
	####################################################

	def testBuyingPPV(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST BUYING PPV@PPV作品の購入"

		$totalTest = $totalTest + 1
		@flag = false

		begin
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=洋画", 0, 1)
			client.sleep(2000)

			for n in 1..2
				# Here get the number of imageView in the visible screen
				noimgvw = client.getAllValues("NATIVE", "xpath=//*[@id='imageView' and @busy='true']", "id")
				puts "Number of image view visible in the screen:\n #{noimgvw}"
				cnt = noimgvw.length
				puts "Number of contents found in the screen is : #{cnt}"
	
				for i in 0..cnt - 1
					if client.isElementFound("NATIVE", "xpath=//*[@id='p_badge']")
						str3 = client.elementGetProperty("NATIVE", "xpath=//*[@id='p_badge']", i, "onScreen")
					
						if str3 == "true"
							puts "::MSG:: PPV 作品を見つかりました「PPV item found」"
							client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])", i, 1)
							client.sleep(2000)
							puts "::MSG:: 該当作品を選びました「Item from list has been clicked」"
							client.sleep(1000)
							if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
								puts "::MSG:: 該当作品は既に購入済みもしくはPPVではありません「This content has already bought or not PPV!!!」"
								client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
							else
								puts "::MSG:: This content is PPV and can be purchased."
								if client.waitForElement("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 30000)
									BuyPPV.new.purchasingContent(client)
								end
								# breaking loop, when operation has been done successfully
								@flag = true
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
				end
				if @flag == true
					break
				else
					n = n + 1
					client.sleep(2000)
					client.swipe2("Down", 300, 1500)
					client.sleep(2000)
				end
			end	
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while while finding ELEMENT: " + e.message	
		end
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while while finding ELEMENT: " + e.message	
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 6
		@testcase_summary = "作品の購入"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgBuypv
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_histp.testHistoryPlay(client))
	end

	####################################################
	#Function Name: purchasingContent
	#Activity: Function for purchasing process
	#Param: object
	####################################################

	def purchasingContent(client)

		begin
			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
			client.sleep(3000)
			if client.isElementFound("NATIVE", "text=レンタル／購入")
				puts "::MSG:: Entered into purchase modal"
				client.sleep(2000)
				if client.waitForElement("NATIVE", "xpath=//*[@id='button']", 0, 30000)								
					if client.isElementFound("NATIVE", "id=button")
						puts "::MSG:: Purchase button available"
					end
					#purchase operation
					client.click("NATIVE", "xpath=//*[@id='button']", 0, 1)
					client.sleep(10000)
					client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
					if client.isElementFound("NATIVE", "xpath=//*[@id='time']")
						puts "::MSG:: PPV作品の購入を成功しました、「Content has been purchased successfully」"
						$result = $resultOK
						$passCount = $passCount + 1
						$finishedTest = $finishedTest + 1
						puts "Result is -> " + $result	
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
						BuyPPV.new.leavingPlayer(client)
						client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
					else
						puts "::MSG:: PPV作品を購入できませんでした、「Could not purchase PPV content!!!」"
						$result = $resultNG
						$failCount = $failCount + 1
						$finishedTest = $finishedTest + 1
						puts "Result is -> " + $result	
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
					end
				end
			else
				puts "::MSG:: 購入モーダルが見つかりません、「Could not get purchase modal, check status!!!」"
			end
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while buying PPV: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
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
			$errMsgBuypv = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end

	####################################################
	#Function Name: whenNoPPV
	#Activity: Function for returning a result
	#Param: object
	####################################################

	def whenNoPPV(client)
		client.sleep(2000)
		puts "::MSG:: Could not find PPV item to buy!!!"
		$result = $resultNG
		$failCount = $failCount + 1
		puts "Pass count is -> #{$totalTest} / #{$passCount}"
	end

	####################################################
	#Target Device: iOS
	#Function Name: testBuyingPPV
	#Activity: Function to buy a PPV content
	#Param: object
	####################################################

	def ios_testBuyingPPV(client)
		client.sleep(2000)
		client.setDevice("ios_app:autoIpad")

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST BUYING PPV@PPV作品の購入"

		$totalTest = $totalTest + 1 

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(2000)
			
			# Here get the number of imageView in the visible screen
			nopmbg = client.getAllValues("NATIVE", "xpath=//*[@accessibilityIdentifier='badge_payitem_l' and @top='true']", "accessibilityIdentifier")
			puts "Number of payment badge in the screen:\n #{nopmbg}"
			$count = nopmbg.length - 2
			puts "Number of contents found in the screen is : #{$count}"

			for i in 0..$count
				str1 = client.elementGetProperty("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PayItemBagde' and @top='true']", i, "hidden")
				puts "Payment badge at #{i} index has Hidden property of #{str1}"
				puts "::MSG:: PPV 作品を見つかりました「PPV item found」"

				if str1 == "false"
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNAsyncImageView' and ./../following-sibling::*[@hidden='false' and @top='true']]", i, 1)
					puts "::MSG:: 該当作品を選びました「Item from list has been clicked」"
					puts ""
					client.sleep(2000)
					if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
						puts "::MSG:: 該当作品は既に購入済みもしくはPPVではありません「This content has already bought or not PPV!!!」"
						client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
						client.sleep(2000)
					else
						puts "::MSG:: 本作品は未購入ので買えます「This content is PPV and can be purchased」"
						client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
						client.sleep(2000)
						if client.isElementFound("NATIVE", "text=レンタル / 購入")
							puts "::MSG:: 購入モーダル「Entered into purchase modal」"
							client.sleep(1000)

							#Checking whether u-next point/ucoin condition
							str2 = client.getTextIn2("NATIVE", "xpath=//*[@class='UIButtonLabel' and @onScreen='true']", 0, "NATIVE", "Inside", 0, 0)
							str3 = str2.scan(/\d+/).first						
							if str3.to_i > 0
								puts "::MSG:: uCoinが足りない「Not enough uCoin」!!!"
								client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='レンタル / 購入']]", 0, 1)
								puts "::MSG:: 前提条件が合っていません、U-Nextポイントをチャージしてから再度実行して下さい「Precondition does not meet! Charge U-Next point and test again later」"
									$result = $resultNG
									$failCount = $failCount + 1
									$finishedTest = $finishedTest + 1
									puts "Result is -> " + $result	
									puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
								break
							else
								puts "::MSG:: [#{str3}] uCoinで購入「Buying content with [#{str3}] uCoin」"
								if client.waitForElement("NATIVE", "xpath=//*[@class='UIButtonLabel' and @onScreen='true']", 0, 10000)
									# If statement
								end
								client.click("NATIVE", "xpath=//*[@class='UIButtonLabel' and @onScreen='true']", 0, 1)
								client.sleep(2000)
								if client.isElementFound("NATIVE", "xpath=//*[@text='OK']")
									client.click("NATIVE", "xpath=//*[@text='OK']", 0, 1)
								end
							end
							if client.waitForElement("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 10000)
							   	# If statement
							end
							client.sleep(2000)
							client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
							BuyPPV.new.ios_buyingConfirmation(client)
							client.sleep(1000)
						else
							puts "::MSG:: 購入モーダルが開けません「Could not get purchase modal, check status!!!」"
						end
						# breaking loop, when operation has been done successfully
						break
					end
	 				puts "::MSG:: Checked index #{i} out of #{$count}"
				else
					puts "::MSG:: PPV作品が見つかりません「No purchasable PPV items found!!!」"
				end
			end
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while PPV buying" + e.message	
		end

		begin
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 6
		@testcase_summary = "作品の購入"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgBuypv
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_histp.ios_testHistoryPlay(client))
	end

	####################################################
	#Function Name: leaveingPlayer
	#Activity: Function to leave player
	#Param: object
	####################################################

	def ios_buyingConfirmation(client)

		client.sleep(35000)
		puts "::MSG:: Playing operation started..."
			
		begin		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + $startTime

			client.sleep(10000)

			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Ending time : " + $endTime

			if $endTime == $startTime
				puts "::MSG:: 作品の購入を失敗しました「Could not purchase content!!!」"
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
			else
				puts "::MSG:: 作品の購入は成功です「Content has been purchased successfully」"
				$result = $resultOK
				$passCount = $passCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
			end

		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while buying PPV: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"			
		end
		begin
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_pause']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='navbar_button_back.png']", 0, 1)
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
	end
end