#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・PPV作品の購入する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class BuyPPV

	@@comment = ""
	@@flag = false

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

		begin
			client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=邦画一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=すべての作品", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ポイント", 0, 1)
			client.sleep(2000)

			for n in 1..2
				if @@flag == true
					break
				else
					for i in 0..4
						if @@flag == true
							break
						else						
							if i == 4
								client.sleep(1000)
								client.swipe2("Down", 300, 2000)
								client.sleep(3000)
							#	BuyPPV.new.checkContentsToBuy(client, i)
							end
							BuyPPV.new.checkContentsToBuy(client, i)
						end			
					end	
				end			
			end
			if @@flag == false
				puts "::MSG:: PPV作品が見つからず購入できませんでした、「Could not find any PPV content to purchase!!!」"
				@@comment = "::MSG:: 未購入のPPV作品を見つからず購入ができませんでした、PPV作品の購入が出来る用アカウントをご利用ください。"	
				$obj_rtnrs.returnNE
			end
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while while finding ELEMENT: " + e.message	
		end
		begin
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
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
			end
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while while finding ELEMENT: " + e.message	
		end

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
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	def checkContentsToBuy(client, i)
		client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", i, 1)
		#client.swipeWhileNotFound2("Down", 300, 2000, "NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='p_badge' and @top='true' and ./parent::*[@id='image_container']])", i, 1000, 1, true)
		client.sleep(2000)
		if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
			puts "::MSG:: 該当作品は既に購入済みもしくはPPVではありません「This content has already bought or not PPV!!!」"
			#client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			@@flag = false
		else
			BuyPPV.new.purchasingContent(client)
		end	
	end

	####################################################
	#Function Name: purchasingContent
	#Activity: Function for purchasing process
	#Param: object
	####################################################

	def purchasingContent(client)

		begin
			#client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='thumbnail_container']]", 0, 1)		#2.11.0~
			client.sleep(3000)
			if client.isElementFound("NATIVE", "text=レンタル／購入")
				puts "::MSG:: Entered into purchase modal"
				client.sleep(2000)
				if client.waitForElement("NATIVE", "xpath=//*[@id='button']", 0, 30000)								
					client.click("NATIVE", "xpath=//*[@id='button']", 0, 1)
					client.sleep(10000)
					client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
					if client.isElementFound("NATIVE", "xpath=//*[@id='time']")
						@@comment = "::MSG:: PPV作品の購入を成功しました、「Content has been purchased successfully」"
						$obj_rtnrs.returnOK
						$obj_rtnrs.printResult
						@@flag = true
					else
						$errMsgBuypv = "::MSG:: PPV作品を購入できませんでした、「Could not purchase PPV content!!!」"
						$obj_rtnrs.returnNG
						$obj_rtnrs.printResult
					end
				end
			else
				$errMsgBuypv = "::MSG:: 購入モーダルが見つかりません、「Could not get purchase modal, check status!!!」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			end
			BuyPPV.new.leavingPlayer(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while buying PPV: " + e.message
			$obj_rtnrs.returnNG
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
			#client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			client.click("NATIVE", "xpath=//*[@class='android.widget.FrameLayout']", 0, 1)
			client.click("NATIVE", "xpath=//*[@id='play_pause_button']", 0, 1)
			client.click("NATIVE", "xpath=//*[@id='toolbar']", 0, 1)
			client.sleep(500)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end			
	end

	####################################################
	#Target Device: iOS
	#Function Name: testBuyingPPV
	#Activity: Function to buy a PPV content
	#Param: object
	####################################################

	def ios_testBuyingPPV(client)
		client.sleep(2000)
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST BUYING PPV@PPV作品の購入"

		$totalTest = $totalTest + 1 

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(2000)
			
			count = client.getElementCount("NATIVE", "xpath=(//*[@class='UICollectionView' and ./preceding-sibling::*[@class='UIView']]/*/*[@class='UNextMobile_Protected.PayItemBagde' and @top='true'])")
			puts "Number of contents found in the screen is : #{count}"

			for i in 0..count - 1
				str1 = client.elementGetProperty("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PayItemBagde' and @top='true']", i, "hidden")
				puts "Payment badge at #{i} index has Hidden property of #{str1}"
				puts "::MSG:: PPV 作品を見つかりました「PPV item found」"

				if str1 == "false"
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNAsyncImageView' and ./../following-sibling::*[@hidden='false' and @top='true']]", i, 1)
					client.sleep(2000)
					if client.isElementFound("NATIVE", "text=見放題") || client.isElementFound("NATIVE", "text=購入済み")
						puts "::MSG:: 該当作品は既に購入済みもしくはPPVではありません「This content has already bought or not PPV!!!」"
						client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
		 				@@flag = false
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
								msg1 = "::MSG:: uCoinが足りない「Not enough uCoin」!!!"
								client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='レンタル / 購入']]", 0, 1)
								msg2 = "::MSG:: 前提条件が合っていません、U-Nextポイントをチャージしてから再度実行して下さい「Precondition does not meet! Charge U-Next point and test again later」"
								$errMsgBuypv = msg1 + " " + msg2

								@@flag = false
								break
							else
								puts "::MSG:: [#{str3}] uCoinで購入「Buying content with [#{str3}] uCoin」"
								client.click("NATIVE", "xpath=//*[@class='UIButtonLabel' and @onScreen='true']", 0, 1)
								client.sleep(2000)
								if client.isElementFound("NATIVE", "xpath=//*[@text='OK']")
									client.click("NATIVE", "xpath=//*[@text='OK']", 0, 1)
								end
							end
							client.sleep(2000)
							client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
							BuyPPV.new.ios_buyingConfirmation(client)
							@@flag = true
							client.sleep(1000)
						else
							puts "::MSG:: 購入モーダルが開けません「Could not get purchase modal, check status!!!」"
						end
						# breaking loop, when operation has been done successfully
						break
					end
	 				puts "::MSG:: Checked index #{i} out of #{count}"
				else
					@@comment = "::MSG:: PPV作品が見つかりません「No purchasable PPV items found!!!」"
					$obj_rtnrs.returnNE
					$obj_rtnrs.printResult	
				end
			end
			if @@flag == false
				@@comment = "::MSG:: PPV作品が見つかりません「No purchasable PPV items found!!!」"
				$obj_rtnrs.returnNE
				$obj_rtnrs.printResult	
			end
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while PPV buying" + e.message	
		end
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end

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
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: leaveingPlayer
	#Activity: Function to leave player
	#Param: object
	####################################################

	def ios_buyingConfirmation(client)

		client.sleep(15000)
		begin		
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + $startTime

			client.sleep(8000)

			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			$endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Ending time : " + $endTime

			if $endTime == $startTime
				$errMsgBuypv = "::MSG:: 作品の購入を失敗しました「Could not purchase content!!!」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult		
			else
				@@comment = "::MSG:: 作品の購入は成功です「Content has been purchased successfully」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult		
			end
		rescue Exception => e
			$errMsgBuypv = "::MSG:: Exception occurrred while buying PPV: " + e.message
			$obj_rtnrs.returnNG
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