#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・ログアウトする機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class Logout

	@@comment = ""

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
		puts "::MSG::[ANDROID] STARTING TEST LOGOUT@ログアウト"

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
				@@comment = "::MSG:: ログアウト成功しました「Logout sucessfull」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			else
				$errMsgLogot = "::MSG:: ログアウト失敗しました「Logout unsucessfull」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			end
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred while loggin out" + e.message
			$obj_rtnrs.returnNG
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

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 4
		@testcase_summary = "ログアウト"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgRtngs
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		puts ($obj_plwlg.testPlayWithoutLogin(client, "roman", "qatest1"))
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
				@@comment = "::MSG:: ログアウト失敗しました「Logout unsucessfull」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNDrawerCellbackgroundView' and ./preceding-sibling::*[@text='ホーム']]", 0, 1)
			else
				$errMsgLogot = "::MSG:: ログアウト失敗しました「Logout unsucessfull」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			end
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred, could not logout..: " + e.message
			$obj_rtnrs.returnNG
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 4
		@testcase_summary = "ログアウト"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgRtngs
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		puts ($obj_dlwlg.ios_testDownloadWithoutLogin(client, "qa00001", "qatest1"))
	end
end