#!/usr/bin/ruby
# encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・未ログイン再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class PlaybackWithoutLogin

	@@wres = []
	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testPlayWithoutLogin
	#Activity: Perform playback without logging
	#Param: object
	####################################################

	def testPlayWithoutLogin(client, user, pass)
		client.sleep(2000)
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST PLAYBACK WITHOUT LOGIN@未ログイン再生"

		$totalTest = $totalTest + 1

		begin
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=ホーム", 0, 1)
			client.sleep(2000)
			for i in 0..2
				PlaybackWithoutLogin.new.tryPlayback(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			end
			PlaybackWithoutLogin.new.tryPlayback(client)
			client.sleep(2000)
			client.click("NATIVE", "id=id_edit_text", 0, 1)
			client.sendText(user)
			client.click("NATIVE", "id=password_edit_text", 0, 1)
			client.sendText(pass)
			client.closeKeyboard()
			client.sleep(2000)
			client.click("NATIVE", "id=login_button", 0, 1)
			client.sleep(2000)

			#client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='thumbnail_container']]", 0, 1)		#2.11.0~
			client.sleep(20000)
			startTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
			puts "再生開始時間 : " + startTime
			$obj_histp.leavingPlayer(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			if @@wres.include?(false) && startTime == nil 
				$errMsgPlywl = "::MSG:: 予期しないエラーを発生しました「Unexpected error occurred」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "::MSG:: 未ログインで再生ができません「Playback is not done without loggin in」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='ログアウト']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "id=button1", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgPlywl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "Android" 
		@testcase_num = 36
		@testcase_summary = "未ログイン再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgPlywl
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	def tryPlayback(client)
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
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@id='login_button']", 0)
				@@wres.push(true)
			else
				@@wres.push(false)
			end
		rescue Exception => e
			$errMsgPlywl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		puts "Flag is : #{@@wres}"
	end

	####################################################
	#Target Device: iOS
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def ios_testPlayWithoutLogin(client, user, pass)
		client.sleep(2000)	
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST PLAYBACK WITHOUT LOGIN@未ログイン再生"

		$totalTest = $totalTest + 1

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)				
			for i in 0..2
				PlaybackWithoutLogin.new.tryiPlayback(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button close']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			end
			PlaybackWithoutLogin.new.tryiPlayback(client)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='ログインID']]", 0, 1)
			client.sendText(user)
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='パスワード']]", 0, 1)
			client.sendText(pass)
			client.closeKeyboard()
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ログイン' and @class='UIButtonLabel']", 0, 1)			
			client.sleep(3000)
			#client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
			client.click("NATIVE", "xpath=(//*[@class='UITableViewWrapperView' and ./parent::*[./parent::*[@class='UIView'] and ./preceding-sibling::*[@class='UIImageView']] and ./following-sibling::*[@class='UIView']]/*/*/*/*/*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./preceding-sibling::*[@class='UNextMobile_Protected.UNGradientView'] and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]])[2]", 0, 1)
			client.sleep(15000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			startTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "Starting time : " + startTime
			$obj_histp.ios_leavingPlayer(client)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			if @@wres.include?(false) && startTime == nil 
				$errMsgPlywl = "::MSG:: 予期しないエラーを発生しました「Unexpected error occurred」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "::MSG:: 未ログインで再生ができません「Playback is not done without loggin in」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='search clear']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='つづきを再生']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='ログアウト' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgPlywl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 36
		@testcase_summary = "未ログイン再生"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgPlywl
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	def tryiPlayback(client)
		begin
			#client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./following-sibling::*[@class='UIButtonLabel'] and ./parent::*[@class='UIButton' and ./parent::*[@class='UNextMobile_Protected.UNChromecastButtonContainer']]]", 0, 1)
			client.sleep(2000)
			client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView']", 0, "A.I")
			client.sleep(1000)
			client.sendText("{ENTER}")
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @top='true' and @height>0 and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
			if client.isElementFound("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='ログイン']]", 0)
				@@wres.push(true)
			else
				@@wres.push(false)
			end
		rescue Exception => e
			$errMsgPlywl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		puts "Flag is : #{@@wres}"
	end
end