#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・再生中画質変更動作機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class ChangeVQualityFromPlayer

	@@cres = []
	@@startTime = ""
	@@endTime = ""
	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testEpisodePlayFromPlayer
	#Activity: Function for playing episode form player episode list
	#Param: object
	####################################################

	def testVQualityFromPlayer(client)
		client.sleep(2000)
	
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST CHANGING VIDEO QUALITY FORM PLAYER@再生中画質変更動作動作機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				ChangeVQualityFromPlayer.new.changingVQuality(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				ChangeVQualityFromPlayer.new.changingVQuality(client)
			end
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while finding element: " + e.message
		end	
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 26
		@testcase_summary = "再生中画質変更操作"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgQuach
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: changingVQuality
	#Activity: Function for changing video quality from player
	#Param: object
	####################################################

	def changingVQuality(client)

		begin
			client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
			client.sleep(2000)
			client.elementSendText("NATIVE", "xpath=//*[@id='search_word_edit_text']", 0, "A.I")
			client.sleep(1000)
			client.sendText("{ENTER}")
			client.sleep(1000)
			client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", 0, 1)
			client.sleep(2000)
			#client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='thumbnail_container']]", 0, 1)		#2.11.0~
			client.sleep(15000)
			client.click("NATIVE", "xpath=//*[@id='player_settings_button']", 0, 1)
			client.sleep(500)
			client.click("NATIVE", "xpath=//*[@id='player_settings_button']", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end
		begin
			for i in 0..5
				getAuto = client.elementGetProperty("NATIVE", "xpath=//*[@text='自動']", 0, "checked")
				getLow = client.elementGetProperty("NATIVE", "xpath=//*[@text='低画質']", 0, "checked")
				getHigh = client.elementGetProperty("NATIVE", "xpath=//*[@text='高画質']", 0, "checked")
				@@startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
				puts "再生開始時間 : " + @@startTime

				if getAuto == "true"
					client.click("NATIVE", "xpath=//*[@text='低画質']", 0, 1)
					client.sleep(8000)
					getLow1 = client.elementGetProperty("NATIVE", "xpath=//*[@text='低画質']", 0, "checked")
					client.sleep(1000)
					ChangeVQualityFromPlayer.new.checkFlag(client, getLow1)
				elsif getAuto == "false" && getLow == "true"
					client.click("NATIVE", "xpath=//*[@text='高画質']", 0, 1)
					client.sleep(8000)
					getHigh1 = client.elementGetProperty("NATIVE", "xpath=//*[@text='高画質']", 0, "checked")
					client.sleep(1000)
					ChangeVQualityFromPlayer.new.checkFlag(client, getHigh1)
				elsif getLow == "false" && getHigh == "true"
					client.click("NATIVE", "xpath=//*[@text='自動']", 0, 1)
					client.sleep(8000)
					getAuto1 = client.elementGetProperty("NATIVE", "xpath=//*[@text='自動']", 0, "checked")
					client.sleep(1000)
					ChangeVQualityFromPlayer.new.checkFlag(client, getAuto1)
				end
			end
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while continuously changing Sub & Dub " + e.message
			$obj_rtnrs.returnNG
		end
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@id='player_settings_button']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(500)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end

		if @@cres.include?(false)
			$errMsgQuach = "::MSG:: 画質の変更時に問題が発生しました「Changing of video quality is unsuccessful」"
			$obj_rtnrs.returnNG
			$obj_rtnrs.printResult
		else
			@@comment= "画質の変更が無事でした「Changing of video quality is successful」"
			$obj_rtnrs.returnOK
			$obj_rtnrs.printResult
		end
		puts "Result is : #{@@cres}"
	end

	####################################################
	#Function Name: checkFlag
	#Activity: Check flag and return result
	#Param: object
	####################################################

	def checkFlag(client, val)
		@flag = val

		client.sleep(8000)
		@@endTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
		puts "再生終了時間 : " + @@endTime

		if @flag == "true" && @@endTime != @@startTime
			@@cres = @@cres.push(true)
		else
			@@cres = @@cres.push(false)
		end
		puts "RETUEN RESULT : #{@@cres}"
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testEpisodePlayFromPlayer
	#Activity: Function for changing video quality while playing
	#Param: object
	####################################################

	def ios_testVQualityFromPlayer(client)
		client.sleep(2000)
	
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST CHANGING VIDEO QUALITY FORM PLAYER@再生中画質変更動作動作機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				ChangeVQualityFromPlayer.new.ichangingVQuality(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				ChangeVQualityFromPlayer.new.ichangingVQuality(client)
			end
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while finding element: " + e.message
		end	
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 26
		@testcase_summary = "再生中画質変更操作"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgQuach
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: changingVQuality
	#Activity: Function for changing video quality from player
	#Param: object
	####################################################

	def ichangingVQuality(client)

		begin
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
			#client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./following-sibling::*[@class='UIButtonLabel'] and ./parent::*[@class='UIButton' and ./parent::*[@class='UNextMobile_Protected.UNChromecastButtonContainer']]]", 0, 1)
			client.sleep(2000)
			client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView']", 0, "A.I")
			client.sleep(1000)
			client.sendText("{ENTER}")
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @top='true' and @height>0 and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
			client.sleep(15000)
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end
		begin
			for i in 0..2
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button tools']]", 0, 1)
				client.sleep(300)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button tools']]", 0, 1)
				@@startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
				puts "再生開始時間 : " + @@startTime
				client.click("NATIVE", "xpath=//*[@text='低画質']", 0, 1)
				client.sleep(7000)
				@@endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
				if @@endTime == @@startTime
					flag = false					
				else
					flag = true
				end
				ChangeVQualityFromPlayer.new.checkiFlag(flag)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button tools']]", 0, 1)
				client.sleep(300)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button tools']]", 0, 1)
				@@startTime1 = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
				puts "再生開始時間 : " + @@startTime1
				client.click("NATIVE", "xpath=//*[@text='高画質']", 0, 1)
				client.sleep(7000)
				@@endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
				if @@endTime == @@startTime
					flag = false					
				else
					flag = true
				end
				ChangeVQualityFromPlayer.new.checkiFlag(flag)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button tools']]", 0, 1)
				client.sleep(300)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button tools']]", 0, 1)
				@@startTime1 = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
				puts "再生開始時間 : " + @@startTime1
				client.click("NATIVE", "xpath=//*[@text='自動']", 0, 1)
				client.sleep(7000)
				@@endTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
				if @@endTime == @@startTime
					flag = false					
				else
					flag = true
				end
				ChangeVQualityFromPlayer.new.checkiFlag(flag)
			end
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while continuously changing video quality randomly " + e.message
			$obj_rtnrs.returnNG
		end
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button tools']]", 0, 1)
			client.sleep(300)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='navbar button back']]", 0, 1)
			client.sleep(300)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='search clear']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='つづきを再生']", 0, 1)
			client.sleep(2000)
			if @@cres.include?(false)
				$errMsgQuach = "::MSG:: 画質の変更時に問題が発生しました「Changing of video quality is unsuccessful」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "画質の変更が無事でした「Changing of video quality is successful」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			puts "Result is : #{@@cres}"
		rescue Exception => e
			$errMsgQuach = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end			
	end

	def checkiFlag(val)
		@flag = val

		if @flag == true
			@@cres = @@cres.push(true)
		else
			@@cres = @@cres.push(false)
		end	
	end	
end