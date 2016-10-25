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
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and @id='textView']", 0, 1)
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

			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
			client.sleep(10000)
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

		puts ($obj_utili.calculateRatio($finishedTest))

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
			client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='見放題で楽しめる厳選良作！洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@id='download_indicator' and ./parent::*[@id='otherView1']]", 0, 1)
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
			client.click("NATIVE", "xpath=//*[@text='洋画' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
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
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
			client.sleep(10000)
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

		puts ($obj_utili.calculateRatio($finishedTest))

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
			client.click("NATIVE", "xpath=(//*[@class='UICollectionView' and ./preceding-sibling::*[@class='UIView' and ./*[@text='見放題で楽しめる厳選良作！洋画編']]]/*/*/*[@class='UNextMobile_Protected.UNAsyncImageView' and ./parent::*[./parent::*[@class='UNextMobile_Protected.HomeTitleCell']]])", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
			client.sleep(2000)
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