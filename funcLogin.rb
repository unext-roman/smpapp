#!/usr/bin/env

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・ログインする機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

#load "Client.rb"
#load "constItems.rb"
#load "funcStartup.rb"
load "funcSinglePlay.rb"
load "utilitiesFunc.rb"

class Login

	$obj_snglp = SinglePlay.new
	$tp_info2 = Utility.new

	####################################################
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

		client.setDevice("adb:401SO")
		client.launch("jp.unext.mediaplayer/jp.co.unext.unextmobile.MainActivity", true, true)

		# Apps startup checking
		if client.isElementFound("NATIVE", "text=ご利用開始の前に")
			puts (testStartupCheck(client))
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=設定・サポート", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=ログアウト", 0)
				$comment = "::MSG:: 既にログイン済み!!! 結果をOKにする"
				$finishedTest = $finishedTest + 1
				#$foo1 = ($obj_snglp.testSinglePlay(client))
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
						puts "Result is -> " + $result
						puts "Pass count is -> #{$totalTest} / #{$passCount}"
						$finishedTest = $finishedTest + 1
						#$foo1 = ($obj_snglp.testSinglePlay(client))
					else
						puts "::MSG:: ログイン失敗しました「Wrong credentials, Test aborted」"
						$result = $resultNG
						$passCount = $passCount + 0
						$finishedTest = $finishedTest + 1
						puts "Result is -> " + $result
						puts "Pass count is -> #{$totalTest} / #{$passCount}"
					end
				rescue Exception => e
					$errMsgLogin = "::MSG:: Exception occurrred, could not continue test..: " + e.message
				end
			end
		end
		
		puts ($tp_info2.calculateRatio($finishedTest))
		dateTime = $tp_info2.getTime

		rt_info2 = RegressionTestInfo.new
		rt_info2.execution_time = dateTime
		rt_info2.test_device = "ANDROID" 
		rt_info2.testcase_num = 2
		rt_info2.testcase_summary = "ログイン"
		rt_info2.test_result = $result
		rt_info2.capture_url = $captureURL
		rt_info2.err_message = $errMsgLogin
		rt_info2.comment = $comment

		return rt_info2
	end
end