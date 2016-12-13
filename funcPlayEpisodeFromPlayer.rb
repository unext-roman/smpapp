#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・再生中エピソード一覧から再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class PlayEpisodeFromPlayer

	@@eres = []
	@@epnm = []
	@@comment = ""
	@@chkres = true

	####################################################
	#Target Device: Android
	#Function Name: testEpisodePlayFromPlayer
	#Activity: Function for playing episode form player episode list
	#Param: object
	####################################################

	def testEpisodePlayFromPlayer(client)
		client.sleep(2000)
	
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST EPISODE PLAY FORM PLAYER@再生中エピソード一覧から再生機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				PlayEpisodeFromPlayer.new.playFromPlayer(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				PlayEpisodeFromPlayer.new.playFromPlayer(client)
			end
		rescue Exception => e
			$errMsgPlfep = "::MSG:: Exception occurrred while finding element: " + e.message	
		end	
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 24
		@testcase_summary = "再生中エピソード一覧から再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgPlfep
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: playFromPlayer
	#Activity: Function for playing from episode list
	#Param: object
	####################################################

	def playFromPlayer(client)

		begin
			client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=アニメ一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=すべての作品", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@id='search_kind_selector']")
				client.click("NATIVE", "text=見放題", 0, 1)
				client.sleep(2000)
				client.swipeWhileNotFound2("Down", 300, 2000, "NATIVE", "xpath=//*[@text='こちら葛飾区亀有公園前派出所']", 0, 1000, 5, true)
				client.sleep(2000)
				@chkres = true

				if @chkres == true
					client.swipe2("Down", 500, 1000)
					client.sleep(2000)
				else
					@chkres = false
				end

				if @@chkres == false
					client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
					client.sleep(2000)
					client.elementSendText("NATIVE", "xpath=//*[@id='search_word_edit_text']", 0, "naruto")
					client.sleep(1000)
					client.sendText("{ENTER}")
					client.sleep(1000)
					client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", 0, 1)
					client.sleep(2000)
					client.swipe2("Down", 600, 1000)
					client.sleep(2000)
				end
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='エピソードを選択']")
					client.click("NATIVE", "text=エピソードを選択", 0, 1)
					client.sleep(2000)
				end
				client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*/*[@id='download_indicator' and ./parent::*[@id='image_container']])", 0, 1)
				client.sleep(15000)
				for i in 0..2
					eps = client.getTextIn2("NATIVE", "xpath=//*[@id='episode_title']", 0, "NATIVE", "Inside", 0, 0)
					puts "::MSG:: Episode name is :#{eps}"
					@@epnm = @@epnm.push(eps)
					startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
					puts "再生開始時間 : " + startTime
					client.sleep(8000)
					endTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
					puts "再生終了時間 : " + endTime
					client.sleep(5000)
					if endTime != startTime
						@@eres = @@eres.push(true)
					else
						@@eres = @@eres.push(false)
					end
					client.click("NATIVE", "xpath=//*[@id='episode_button']", 0, 1)
					client.sleep(500)
					client.click("NATIVE", "xpath=//*[@text='エピソード']", 0, 1)
					client.sleep(2000)
					ind = 0
					ind = ind + 1
					if client.isElementFound("NATIVE", "xpath=//*[@text='再生中' and @width>0]")
						client.click("NATIVE", "xpath=(//*[@id='player_episode_recycler_view']/*/*/*[@id='indicator' and @width>0])", ind, 1)
						client.sleep(10000)
						@@eres = @@eres.push(true)
					else
						@@eres = @@eres.push(false)
						$errMsgPlfep = "::MSG:: Error occurred while trying to play episode from [episode list]"
					end
				end
			end
			puts "::MSG:: Array contains : #{@@epnm}"
			if @@epnm.detect{ |e| @@epnm.count(e) > 1 } || @@epnm.empty? == true
				@@eres = @@eres.push(false)
			else
				@@eres = @@eres.push(true)
			end
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			puts "::MSG:: Result array : #{@@eres}"
			if @@eres.include?(false)
				$errMsgPlfep = "::MSG:: エピソード一覧から再生時に問題が発生しました「Playing from episode list is unsuccessful」"					
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "エピソード一覧から再生されました「Playing from episode list is successful」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
		rescue Exception => e
			$errMsgPlfep = "::MSG:: Exception occurrred while playing from episode from player: " + e.message
			$obj_rtnrs.returnNG
		end
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testEditMylist
	#Activity: Function for editing mylist
	#Param: object
	####################################################

	def ios_testEpisodePlayFromPlayer(client)
		client.sleep(2000)
	
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST EPISODE PLAY FORM PLAYER@再生中エピソード一覧から再生機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				PlayEpisodeFromPlayer.new.iplayFromPlayer(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				PlayEpisodeFromPlayer.new.iplayFromPlayer(client)
			end
		rescue Exception => e
			$errMsgPlfep = "::MSG:: Exception occurrred while finding element: " + e.message	
		end	
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 24
		@testcase_summary = "再生中エピソード一覧から再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgPlfep
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: iplayFromPlayer
	#Activity: Function for playing from episode list
	#Param: object
	####################################################

	def iplayFromPlayer(client)

		begin
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./following-sibling::*[@class='UIButtonLabel'] and ./parent::*[@class='UIButton' and ./parent::*[@class='UNextMobile_Protected.UNChromecastButtonContainer']]]", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='タイトルとの一致']") == true || client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]") == true
				$obj_gener.icheckSearchField(client)
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='アニメ一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='すべての作品']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@class='UISegmentedControl']")
				client.click("NATIVE", "text=見放題", 0, 1)
				client.sleep(2000)
				client.swipeWhileNotFound2("Down", 300, 2000, "NATIVE", "xpath=//*[@text='こちら葛飾区亀有公園前派出所' and @top='true']", 0, 1000, 5, true)
				client.sleep(2000)
				@chkres = true
				if @chkres == true
					client.swipe2("Down", 500, 1000)
					client.sleep(2000)
				else
					@chkres = false
				end

				if @@chkres == false
					client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and @top='true']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and @top='true']", 0, 1)
					client.sleep(2000)
					client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView']", 0, "naruto")
					client.sleep(1000)
					client.sendText("{ENTER}")
					client.sleep(1000)
					client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
					client.sleep(2000)
					client.swipe2("Down", 1000, 1000)
					client.sleep(2000)
				end

				client.sleep(1000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='エピソードを選択']")
					client.click("NATIVE", "xpath=//*[@text='エピソードを選択']", 0, 1)
					client.sleep(2000)
				end
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::* and ./preceding-sibling::*[@class='UNextMobile_Protected.UNGradientView']]]", 0, 1)
				client.sleep(15000)
				for i in 0..2
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
					client.sleep(200)
					eps = client.getTextIn2("NATIVE", "xpath=//*[@class='UILabel' and @height=36 and @top='true' and @alpha=1 and @onScreen='true']", 0, "NATIVE", "Inside", 0, 0)
					puts "::MSG:: Episode name is :#{eps}"
					@@epnm = @@epnm.push(eps)
					startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
					puts "再生開始時間 : " + startTime
					client.sleep(8000)
					endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
					puts "再生終了時間 : " + endTime
					client.sleep(5000)
					if endTime != startTime
						@@eres = @@eres.push(true)
					else
						@@eres = @@eres.push(false)
					end
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
					client.sleep(500)
					client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='icon sort']]", 0, 1)
					client.sleep(2000)
					indx = 0
					indx = indx + 1
					if client.isElementFound("NATIVE", "xpath=//*[@text='再生中' and @top='true']")
						client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @x>700 and @width>0 and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UIView']]]", indx, 1)
						client.sleep(10000)
						@@eres = @@eres.push(true)
					else
						@@eres = @@eres.push(false)
						$errMsgPlfep = "::MSG:: Error occurred while trying to play episode from [episode list]"
					end
				end
			end
			puts "::MSG:: Array contains : #{@@epnm}"
			if @@epnm.detect{ |e| @@epnm.count(e) > 1 } || @@epnm.empty? == true
				@@eres = @@eres.push(false)
			else
				@@eres = @@eres.push(true)
			end
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			client.sleep(200)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='navbar button back']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and @top='true']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and @top='true']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and @top='true']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='つづきを再生']", 0, 1)
			puts "::MSG:: Result array : #{@@eres}"
			if @@eres.include?(false)
				$errMsgPlfep = "::MSG:: エピソード一覧から再生時に問題が発生しました「Playing from episode list is unsuccessful」"					
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "エピソード一覧から再生されました「Playing from episode list is successful」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
		rescue Exception => e
			$errMsgPlfep = "::MSG:: Exception occurrred while playing from episode from player: " + e.message
			$obj_rtnrs.returnNG
		end
	end
end