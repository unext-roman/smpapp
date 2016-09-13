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
		puts "::MSG::[ANDROID] STARTING TEST LOGIN@#{s}"

		andrt2 = RegressionTestInfo.new
		andrt2.execution_time = $obj_utili.getTime
		andrt2.test_device = "ANDROID" 
		andrt2.testcase_num = 2
		andrt2.testcase_summary = "ログイン"

		$totalTest = $totalTest + 1
		@flag = true

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
				$comment = "::MSG:: 既にログイン済み!!! 結果をOKにする"
				$result = $resultOK
				$passCount = $passCount + 1					
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
			else
				begin
					client.elementListSelect("", "text=ログイン", 0, false)
					client.click("NATIVE", "text=ログイン", 0, 1)
					client.click("NATIVE", "id=id_edit_text", 0, 1)
					client.sendText(user)
					client.click("NATIVE", "id=password_edit_text", 0, 1)
					client.sendText(pass)
					client.closeKeyboard()
					if client.waitForElement("NATIVE", "text=ログイン", 0, 10000)
		    			# If statement
					end
					client.click("NATIVE", "id=login_button", 0, 1)
					client.sleep(2000)

					if client.isElementFound("NATIVE", "xpath=//*[@text='お客様情報の登録']")
						client.sleep(1000)
						client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']")
					end
					if client.isElementFound("NATIVE", "xpath=//*[@text='ログアウト']", 0)
						puts "::MSG:: ログイン成功しました「Login successful」"
						$result = $resultOK
						$passCount = $passCount + 1
						$finishedTest = $finishedTest + 1
						@flag = true						
						puts "Result is -> " + $result
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
					else
						puts "::MSG:: ログイン失敗しました「Wrong credentials, Test aborted」"
						$result = $resultNG
						$failCount = $failCount + 1
						$finishedTest = $finishedTest + 1
						@flag = false						
						puts "Result is -> " + $result
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
						client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
						client.sleep(1000)
					end
				rescue Exception => e
					$errMsgLogin = "::MSG:: Exception occurrred at Login operation: " + e.message
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"		
				end
			end
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

		puts ($obj_utili.calculateRatio($finishedTest))
		if @flag == true
			$tc3 = ($obj_snglp.testSinglePlay(client))
		else
			puts ""
			puts "::注意::"
			puts "::MSG:: ユーザー認証ができませんでしたので、テストが進めません。ユーザーID/PWをご確認ください。"
			puts ""
		end

		andrt2.test_result = $result
		andrt2.capture_url = $captureURL
		andrt2.err_message = $errMsgLogin
		andrt2.comment = $comment

		return andrt2
		client.sleep(2000)
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
		puts "::MSG::[iOS] STARTING TEST LOGIN@#{s1}"

		iosrt2 = RegressionTestInfo.new
		iosrt2.execution_time = $obj_utili.getTime
		iosrt2.test_device = "iOS"
		iosrt2.testcase_num = 2
		iosrt2.testcase_summary = "ログイン"

		$totalTest = $totalTest + 1
		@flag = true

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)		
			client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
		rescue Exception => e
			$errMsgLogin = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end
		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0)	
				$comment = "::MSG:: 既にログイン済み!!! 結果をOKにする"
				$result = $resultOK
				$passCount = $passCount + 1					
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"	
				client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
			else
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='ログイン']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='ログインID']]", 0, 1)
				client.sendText(user)
				client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='パスワード']]", 0, 1)
				client.sendText(pass)
				client.closeKeyboard()
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ログイン' and @class='UIButtonLabel']", 0, 1)			
				client.sleep(3000)
				if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0)
					puts "::MSG:: ログイン成功しました「Login successful」"
					$result = $resultOK
					$passCount = $passCount + 1					
					$finishedTest = $finishedTest + 1
					@flag = true
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"	
				else
					puts "::MSG:: ログイン失敗しました「Wrong credentials, Test aborted」"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					@flag = false
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
					client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button close']]", 0, 1)
					client.sleep(1000)
				end	
				client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
			end	
		rescue Exception => e
			$errMsgLogin = "::MSG:: Exception occurrred at Login operation: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		if @flag == true
			$tc3 = ($obj_snglp.ios_testSinglePlay(client))
		else
			puts ""
			puts "::注意::"
			puts "::MSG:: ユーザー認証ができませんでしたので、テストが進めません。ユーザーID/PWをご確認ください。"
			puts ""
		end

		iosrt2.test_result = $result
		iosrt2.capture_url = $captureURL		
		iosrt2.err_message = $errMsgLogin
		iosrt2.comment = $comment

		return iosrt2
		client.sleep(2000)
	end
end