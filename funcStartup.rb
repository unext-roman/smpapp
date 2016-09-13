#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・初期起動機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class Startup

	####################################################
	#Function Name: testStartupCheck
	#Activity: Perform sstartup operation
	#Param: object
	####################################################

	def testStartupCheck(client)

		begin
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
			client.sleep(2000)
			client.click("NATIVE", "text=劇場公開＆TV放送から間もない最新作をお届け！", 0, 1)
		rescue Exception => e
			$errMsgStrtp = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end
	end
end