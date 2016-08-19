#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・ログアウトする機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

#/Users/admin/Desktop/github_edited

load "Client.rb"
load "funcRelease.rb"
load "constItems.rb"
load "utilitiesFunc.rb"

class Logout

	$obj_finis = Finish.new
	$tp_info2 = Utility.new

	####################################################
	#Function Name: testLogout
	#Activity: Perform logout operation
	#Param: object
	####################################################

	def testLogout(client)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @ログアウト"

		$totalTest = $totalTest + 1
		# Declation of Logout
		client.setDevice("adb:401SO")
		client.sleep(2000)
		client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "text=設定・サポート", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "xpath=//*[@text='ログアウト']", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "id=button1", 0, 1)

		begin
			if client.isElementFound("NATIVE", "text=ログイン", 0);
				puts "::MSG:: ログアウト成功しました「Logout sucessfull」"
				$result = $resultOK
				$passCount = $passCount + 1
				puts "Result is -> " + $result
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				puts "Pass count is -> #{$totalTest} / #{$passCount}"
			else
				puts "::MSG:: ログアウト失敗しました「Logout unsucessfull」"
				$result = $resultNG
				$passCount = $passCount + 0
				puts "Result is -> " + $result
				puts "Pass count is -> #{$totalTest} / #{$passCount}"
			end
		rescue Exception => e
			$errMsgLogin = "::MSG:: Exception occurrred, could not continue test..: " + e.message
		end	

		#puts ($tp_info8.calculateRatio($finishedTest))
		dateTime = $tp_info2.getTime

		rt_info4 = RegressionTestInfo.new
		rt_info4.execution_time = dateTime
		rt_info4.test_device = "ANDROID" 
		rt_info4.testcase_num = 4
		rt_info4.testcase_summary = "ログアウト"
		rt_info4.test_result = $result
		rt_info4.capture_url = $captureURL		
		rt_info4.err_message = $errMsgLogot
		rt_info4.comment = ""

		return rt_info4

		#puts ($obj_finis.testEnd(client))
	end
end