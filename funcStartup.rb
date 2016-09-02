#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・初期起動機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "Client.rb"

# Create client using defaults or using hostname and port number
#client = Mobile::Client.new('127.0.0.1', 8889, true)
#client.setProjectBaseDirectory("/Users/admin/workspace/PR_Regression")

####################################################
#Function Name: testStartupCheck
#Activity: Perform sstartup operation
#Param: object
####################################################

class Startup

	def testStartupCheck(client)

		client.sleep(2000)
		client.swipe2("Right", 0, 500)
		client.sleep(1000)
		client.swipe2("Right", 0, 500)
		client.sleep(1000)
		client.swipe2("Right", 0, 500)
		client.elementListSelect("", "text=洋画", 0, false)
		client.sleep(1000)
		client.click("NATIVE", "text=洋画", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "text=海外ドラマ", 0, 1)
		client.sleep(1000)
		client.click("NATIVE", "text=次へ", 0, 1)
		client.sleep(2000)
		client.click("NATIVE", "text=完了", 0, 1)
			if client.waitForElement("NATIVE", "partial_text=劇場公開＆TV放送から間もない最新作をお届け！", 0, 30000)
	    		# If statement
			end
		client.click("NATIVE", "text=劇場公開＆TV放送から間もない最新作をお届け！", 0, 1)

		rt_info = RegressionTestInfo.new
		rt_info.test_device = "ANDROID" 
		rt_info.testcase_num = 5
		rt_info.testcase_summary = "つづきを再生"
		rt_info.test_result = $result
		rt_info.err_message = $errMsg
		rt_info.comment = ""

		return rt_info3

	end
end