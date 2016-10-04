#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・リンバック操作機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class Leanback

	####################################################
	#Target Device: Android
	#Function Name: testAddtoMylist
	#Activity: Function for adding to mylist and remove
	#Param: object
	####################################################

	def testLeanbackOperation(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST LEANBACK OPERATION@リンバック操作機能"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		if client.isElementFound("NATIVE", "text=つづきを再生")
			Leanback.new.browseLeanback(client)
		else
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=ホーム", 0, 1)
			client.sleep(2000)
			Leanback.new.browseLeanback(client)
		end

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 17
		@testcase_summary = "リンバック操作機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgSarch
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_edith.testEditHistoryList(client))
	end

	####################################################
	#Function Name: browseLeanback
	#Activity: Function for browsing leanback
	#Param: object
	####################################################

	def browseLeanback(client)

		begin		
			for $i in 0..3
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=設定・サポート", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=お知らせ", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ライセンス", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=プライバシーポリシー", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=アプリ規約", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=視聴履歴", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=マイリスト", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=購入済み", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ダウンロード済み", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='android.widget.ImageView']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=洋画", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=邦画", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=海外ドラマ", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.swipe2("Down", 500, 500)
				client.sleep(2000)
				client.click("NATIVE", "text=韓流・アジアドラマ", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=国内ドラマ", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=アニメ", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=キッズ", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ドキュメンタリー", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=音楽・アイドル", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=バラエティ", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.swipe2("Up", 500, 500)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
			end
		rescue Exception => e
			$errMsgLnbko = "::MSG:: Exception occurrred during leanback operation: " + e.message	
		end

		returnResult($i)
	end

	def returnResult(val)

		@val = val
		if @val == 3
			puts "::MSG:: リンバック操作に問題ありませんでした「Leaback operation has performed successfully」"					
			$result = $resultOK
			$passCount = $passCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		else
			puts "リンバック操作に問題が発生しました「Issue occurred during leanback operation」"
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end	
	end

end
