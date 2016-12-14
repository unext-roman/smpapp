#!/usr/bin/ruby
# encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・未ログインダウンロード機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class DownloadWithoutLogin

	@@wres = []
	@@comment = ""
	@@rtn = true

	####################################################
	#Target Device: Android
	#Function Name: testDownloadWithoutLogin
	#Activity: Perform download without logging
	#Param: object
	####################################################

	def testDownloadWithoutLogin(client, user, pass)
		client.sleep(2000)
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST DOWNLOAD WITHOUT LOGIN@未ログインダウンロード"

		$totalTest = $totalTest + 1

		begin
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and @id='textView']", 0, 1)
			client.sleep(2000)
			for i in 0..2
				DownloadWithoutLogin.new.tryPlayback(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			end
			DownloadWithoutLogin.new.tryPlayback(client)
			client.sleep(2000)
			client.click("NATIVE", "id=id_edit_text", 0, 1)
			client.sendText(user)
			client.click("NATIVE", "id=password_edit_text", 0, 1)
			client.sendText(pass)
			client.closeKeyboard()
			client.sleep(2000)
			client.click("NATIVE", "id=login_button", 0, 1)
			client.sleep(2000)
		    client.click("NATIVE", "xpath=//*[@id='otherView' and @class='jp.co.unext.widget.DownloadCircleIndicator']", 0, 1)
		    client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@id='download_progress']")
				@@wres.push(true)
			else
				@@wres.push(false)
			end
			client.sleep(2000)
			if @@wres.include?(false) 
				$errMsgDlwlg = "::MSG:: 予期しないエラーを発生しました「Unexpected error occurred」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "::MSG:: 未ログインでダウンロードができません「Playback is not done without loggin in」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ログアウト']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "id=button1", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgDldwl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "Android" 
		@testcase_num = 37
		@testcase_summary = "未ログインダウンロード"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgDldwl
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	def tryPlayback(client)
		begin
			client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='見放題で楽しめる厳選良作！洋画編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
			client.sleep(2000)
			client.swipe2("Down", 300, 1500)
		    client.sleep(1000)
		    client.click("NATIVE", "xpath=//*[@id='otherView' and @class='jp.co.unext.widget.DownloadCircleIndicator']", 0, 1)
			if client.isElementFound("NATIVE", "xpath=//*[@id='alertTitle']")
				client.click("NATIVE", "xpath=//*[@id='button1']", 0, 1)
			end
			if client.isElementFound("NATIVE", "xpath=//*[@id='login_button']", 0)
				@@wres.push(true)
			else
				@@wres.push(false)
			end
		rescue Exception => e
			$errMsgDldwl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		puts "Flag is : #{@@wres}"
	end

	####################################################
	#Target Device: iOS
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def ios_testDownloadWithoutLogin(client, user, pass)
		client.sleep(2000)	
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST DOWNLOAD WITHOUT LOGIN@未ログインダウンロード"

		$totalTest = $totalTest + 1

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(2000)
			for i in 0..2
				DownloadWithoutLogin.new.tryiDownload(client)
				client.sleep(2000)
				if @@rtn == false
					client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
					client.sleep(2000)
				else					
					client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button close']]", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
					client.sleep(2000)
				end
			end
			DownloadWithoutLogin.new.tryiDownload(client)
			if @@rtn == false
				$errMsgDldwl = "::MSG:: Restricted Item, can't be downloaded"
				$obj_rtnrs.returnNE
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			else				
				client.sleep(2000)
				client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView' and ./parent::*[@class='UITextField' and ./preceding-sibling::*[@text='ログインID']]]", 0, user)
				client.sleep(2000)
				client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView' and ./parent::*[@class='UITextField' and ./preceding-sibling::*[@text='パスワード']]]", 0, pass)
				client.sleep(1000)
				client.closeKeyboard()
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ログイン' and @class='UIButtonLabel']", 0, 1)			
				client.sleep(3000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='ダウンロードを開始します。']")
					client.click("NATIVE", "xpath=//*[@text='OK']", 0, 1)
				end
				client.sleep(10000)
				str0 = client.getTextIn2("NATIVE", "xpath=//*[@class='UITableViewCellContentView' and ./*[@class='UIImageView'] and ./*[@text='ダウンロード']]", 0, "NATIVE", "Inside", 0, 0)
				#str1 = str0.each_char{ |c| str0.delete!(c) if c.ord<48 or c.ord>57 }
				proval = str0.split(//).map {|x| x[/\d+/]}.compact.join("").to_i
				if proval > 1
					@@comment = "::MSG:: ダウンロードを開始しました「Download has started」"
					$obj_rtnrs.returnOK
					$obj_rtnrs.printResult
				else
					puts "::MSG:: ダウンロードを失敗しました!!!「Downloading failed, Check status」"
					$obj_rtnrs.returnNG
					$obj_rtnrs.printResult
				end
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='search clear']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='つづきを再生']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ログアウト' and @class='UIButtonLabel']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			end
		rescue Exception => e
			$errMsgDldwl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
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
		@err_message = $errMsgDldwl
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	def tryiDownload(client)
		begin
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
			#client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./following-sibling::*[@class='UIButtonLabel'] and ./parent::*[@class='UIButton' and ./parent::*[@class='UNextMobile_Protected.UNChromecastButtonContainer']]]", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='タイトルとの一致']") == true || client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]") == true
				$obj_gener.icheckSearchField(client)
			end
			client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView']", 0, "たかいき")
			client.sleep(1000)
			client.sendText("{ENTER}")
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
			client.sleep(2000)
			DownloadWithoutLogin.new.perfOperation(client)

		rescue Exception => e
			$errMsgDldwl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		puts "Flag is : #{@@wres}"
	end

	def perfOperation(client)
		begin
			client.swipe2("Down", 1000, 1500)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@accessibilityIdentifier='icon_download_unavailable']", 0)
				puts "::MSG:: Restricted Item, can't be downloaded"
				@@rtn = false
			else				
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UITableViewCellContentView']]]", 0, 1)
				client.sleep(2000)
				@@rtn = true
				if client.isElementFound("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='ログイン']]", 0)
					@@wres.push(true)
				else
					@@wres.push(false)
				end
			end
		rescue Exception => e
			$errMsgDldwl = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end		
	end
end