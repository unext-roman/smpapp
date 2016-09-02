#!/usr/bin/ruby

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
		puts "::MSG::[ANDROID] STARTING TEST @ログイン"
		$totalTest = $totalTest + 1

		# Apps startup checking
		if client.isElementFound("NATIVE", "text=ご利用開始の前に")
			puts ($obj_strtp.testStartupCheck(client))
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=設定・サポート", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=ログアウト", 0)
				$comment = "::MSG:: 既にログイン済み!!! 結果をOKにする"
				$finishedTest = $finishedTest + 1
				##$tc3 = ($obj_snglp.testSinglePlay(client))
			else
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

				begin
					if client.isElementFound("NATIVE", "xpath=//*[@text='お客様情報の登録']")
						client.sleep(1000)
						client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']")
					end
					if client.isElementFound("NATIVE", "text=ログアウト", 0)
						puts "::MSG:: ログイン成功しました「Login successful」"
						$result = $resultOK
						$passCount = $passCount + 1
						$finishedTest = $finishedTest + 1				
						puts "Result is -> " + $result
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"						
					else
						puts "::MSG:: ログイン失敗しました「Wrong credentials, Test aborted」"
						$result = $resultNG
						$failCount = $failCount + 1
						$finishedTest = $finishedTest + 1
						puts "Result is -> " + $result
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
					end
				rescue Exception => e
					$errMsgLogin = "::MSG:: Exception occurrred, could not continue test..: " + e.message
				end
			end
		end
		
		puts ($obj_utili.calculateRatio($finishedTest))
		$tc3 = ($obj_snglp.testSinglePlay(client))

		andrt2 = RegressionTestInfo.new
		andrt2.execution_time = $obj_utili.getTime
		andrt2.test_device = "ANDROID" 
		andrt2.testcase_num = 2
		andrt2.testcase_summary = "ログイン"
		andrt2.test_result = $result
		andrt2.capture_url = $captureURL
		andrt2.err_message = $errMsgLogin
		andrt2.comment = $comment

		return andrt2
		client.sleep(5000)
#		puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc2.execution_time, $tc2.testcase_num, $tc2.testcase_summary, $tc2.test_result, $tc2.capture_url, $tc2.err_message, $tc2.comment))		
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
		puts "::MSG::[iOS] STARTING TEST @ログイン"
		$totalTest = $totalTest + 1

		client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
		client.sleep(2000)
		client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
		client.sleep(2000)

		if client.isElementFound("NATIVE", "text=ログアウト", 0)
			$comment = "::MSG:: 既にログイン済み!!! 結果をOKにする"
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)
		else
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='ログイン']", 0, 1)
			if client.waitForElement("NATIVE", "class=UITextField", 0, 10000)
	   			# If statement
			end
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='ログインID']]", 0, 1)
			client.sendText(user)
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='パスワード']]", 0, 1)
			client.sendText(pass)
			client.closeKeyboard()
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='ログイン' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)

			begin
				if client.isElementFound("NATIVE", "text=ログアウト", 0)
					puts "::MSG:: ログイン成功しました「Login successful」"
					$result = $resultOK
					$passCount = $passCount + 1					
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"	
				else
					puts "::MSG:: ログイン失敗しました「Wrong credentials, Test aborted」"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"	
				end	
			rescue Exception => e
				$errMsg = "::MSG:: Exception occurrred, could not continue test..: #{$e}"
			end
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc3 = ($obj_snglp.ios_testSinglePlay(client))

		iosrt2 = RegressionTestInfo.new
		iosrt2.execution_time = $obj_utili.getTime
		iosrt2.test_device = "iOS"
		iosrt2.testcase_num = 2
		iosrt2.testcase_summary = "ログイン"
		iosrt2.test_result = $result
		iosrt2.capture_url = $captureURL		
		iosrt2.err_message = $errMsgLogin
		iosrt2.comment = $comment

		return iosrt2
		#puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc2.execution_time, $tc2.testcase_num, $tc2.testcase_summary, $tc2.test_result, $tc2.capture_url, $tc2.err_message, $tc2.comment))	
	end
end