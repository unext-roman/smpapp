#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・ログアウトする機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class Logout

	####################################################
	#Target Device: Android
	#Function Name: testLogout
	#Activity: Perform logout operation
	#Param: object
	####################################################

	def testLogout(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @ログアウト"

		$totalTest = $totalTest + 1

		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=設定・サポート", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='ログアウト']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "id=button1", 0, 1)
			if client.isElementFound("NATIVE", "text=ログイン", 0);
				puts "::MSG:: ログアウト成功しました「Logout sucessfull」"
				$result = $resultOK
				$passCount = $passCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
			else
				puts "::MSG:: ログアウト失敗しました「Logout unsucessfull」"
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
			end
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred while loggin out" + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end	

		begin			
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end	

		puts ($obj_utili.calculateRatio($finishedTest))

		andrt4 = RegressionTestInfo.new
		andrt4.execution_time = $obj_utili.getTime
		andrt4.test_device = "ANDROID" 
		andrt4.testcase_num = 4
		andrt4.testcase_summary = "ログアウト"
		andrt4.test_result = $result
		andrt4.capture_url = $captureURL		
		andrt4.err_message = $errMsgLogot
		andrt4.comment = ""

		return andrt4

	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testLogout
	#Activity: Perform logout operation
	#Param: object
	####################################################

	def ios_testLogout(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST LOGOUT@ログアウト"

		$totalTest = $totalTest + 1

		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='ログアウト' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=ログイン", 0);
				puts "::MSG:: Logout sucessfull..."
				$result = $resultOK
				$passCount = $passCount + 1
				$finishedTest = $finishedTest + 1		
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNDrawerCellbackgroundView' and ./preceding-sibling::*[@text='ホーム']]", 0, 1)
			else
				puts "::MSG:: Logout unsucessfull..."
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1				
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
			end
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred, could not logout..: " + e.message	
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		iosrt4 = RegressionTestInfo.new
		iosrt4.execution_time = $obj_utili.getTime		
		iosrt4.test_device = "iOS"
		iosrt4.testcase_num = 4
		iosrt4.testcase_summary = "ログアウト"
		iosrt4.test_result = $result
		iosrt4.capture_url = $captureURL		
		iosrt4.err_message = $errMsgLogot
		iosrt4.comment = ""

		return iosrt4
	end
end