#!/usr/bin/ruby
# encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・ログインする機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class Login

	@@comment = ""
	@@exec = false

	####################################################
	#Target Device: Android
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def testLogin(client,user,pass)
		client.sleep(2000)
		puts ""
		puts ""
		s = "ログイン"
		s.encode("Shift_JIS")
		puts "::MSG::[ANDROID] STARTING TEST LOGIN@ログイン"

		$totalTest = $totalTest + 1

		if client.isElementFound("NATIVE", "text=ご利用開始の前に")
			puts ($obj_strtp.testStartupCheck(client))
		else
			begin
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=設定・サポート", 0, 1)
				client.sleep(2000)
			rescue Exception => e
				$errMsgLogin = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
			end
			if client.isElementFound("NATIVE", "xpath=//*[@text='ログアウト']", 0)
				@@comment = "::MSG:: 既にログイン済み!!! 結果を未実施にする"
				$obj_rtnrs.returnNE
				@@exec = true
				$obj_slctv.checkExecStatus(@@exec)
				$obj_slctv.checkFlagValue(@@exec)
			else
				begin
					client.elementListSelect("", "text=ログイン", 0, false)
					client.click("NATIVE", "text=ログイン", 0, 1)
					client.elementSendText("NATIVE", "xpath=//*[@id='id_edit_text']", 0, user)
					client.sleep(2000)			
					client.elementSendText("NATIVE", "xpath=//*[@id='password_edit_text']", 0, pass)
					client.sleep(1000)
					client.closeKeyboard()
					client.click("NATIVE", "id=login_button", 0, 1)
					client.sleep(2000)

					if client.isElementFound("NATIVE", "xpath=//*[@text='お客様情報の登録']")
						client.sleep(1000)
						client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']")
					end
					if client.isElementFound("NATIVE", "xpath=//*[@text='ログアウト']", 0)
						@@comment = "::MSG:: ログイン成功しました「Login successful」"
						$obj_rtnrs.returnOK
						$obj_rtnrs.printResult
						@flag = true
						$obj_slctv.checkFlagValue(@flag)			
					else
						$errMsgLogin = "::MSG:: ログイン失敗しました「Wrong credentials, Test aborted」"
						$obj_rtnrs.returnNG
						$obj_rtnrs.printResult
						@flag = false
						$obj_slctv.checkFlagValue(@flag)
						client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
						client.sleep(1000)
					end
				rescue Exception => e
					$errMsgLogin = "::MSG:: Exception occurrred at Login operation: " + e.message
					$obj_rtnrs.returnNG
				end
			end
			@@exec = true
			$obj_slctv.checkExecStatus(@@exec)	
		end
	
		begin	
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgLogin = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 2
		@testcase_summary = "ログイン"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgLogin
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Target Device: iOS
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def ios_testLogin(client, user, pass)
		client.sleep(2000)	


		puts ""
		puts ""
		s1 = "ログイン"
		s1.encode!("Shift_JIS")
		puts "::MSG::[iOS] STARTING TEST LOGIN@ログイン"

		$totalTest = $totalTest + 1

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)		
			client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgLogin = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0)	
				@@comment = "::MSG:: 既にログイン済み!!! 結果を未実施にする"
				$obj_rtnrs.returnNE
				@@exec = true
				$obj_slctv.checkExecStatus(@@exec)
				$obj_slctv.checkFlagValue(@@exec)
				client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
			else
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='ログイン']", 0, 1)
				client.sleep(2000)
				#client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='ログインID']]", 0, 1)
				#client.sendText(user)
				client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView' and ./parent::*[@class='UITextField' and ./preceding-sibling::*[@text='ログインID']]]", 0, user)
				client.sleep(2000)
				#client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='パスワード']]", 0, 1)
				client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView' and ./parent::*[@class='UITextField' and ./preceding-sibling::*[@text='パスワード']]]", 0, pass)
				#client.sendText(pass)
				client.sleep(1000)
				client.closeKeyboard()
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ログイン' and @class='UIButtonLabel']", 0, 1)			
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0)
					@@comment = "::MSG:: ログイン成功しました「Login successful」"
					$obj_rtnrs.returnOK
					$obj_rtnrs.printResult
					@flag = true
					$obj_slctv.checkFlagValue(@flag)	
				else
					$errMsgLogin = "::MSG:: ログイン失敗しました「Wrong credentials, Test aborted」"
					$obj_rtnrs.returnNG
					$obj_rtnrs.printResult
					@flag = false
					$obj_slctv.checkFlagValue(@flag)	
					client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button close']]", 0, 1)
					client.sleep(1000)
				end	
				client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
			end
			@@exec = true
			$obj_slctv.checkExecStatus(@@exec)	
		rescue Exception => e
			$errMsgLogin = "::MSG:: Exception occurrred at Login operation: " + e.message
			$obj_rtnrs.returnNG
			$obj_rtnrs.printResult
		end

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 2
		@testcase_summary = "ログイン"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgLogin
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end
end