#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・視聴履歴の編集機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class EditHistory

	@@eres = []

	####################################################
	#Target Device: Android
	#Function Name: testEditHistoryList
	#Activity: Function for adding to mylist and remove
	#Param: object
	####################################################

	def testEditHistoryList(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST EDITING HISTORY@視聴履歴の編集機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				EditHistory.new.listEditing(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				EditHistory.new.listEditing(client)
			end
		rescue Exception => e
			$errMsgEdith = "::MSG:: Exception occurrred while finding element: " + e.message	
		end	

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 19
		@testcase_summary = "視聴履歴の編集"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgEdith
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_editd.testEditDownloadList(client))		
	end

	####################################################
	#Function Name: listEditing
	#Activity: Function for editing history list
	#Param: object
	####################################################

	def listEditing(client)

		begin
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=視聴履歴", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=視聴履歴がありません")
				puts "::MSG:: There is no item in history list!!!"
				@@eres = @@eres.push(true)
			else
				cnt = client.getElementCount("NATIVE", "xpath=(//*[@id='recycler_view']/*[@class='android.widget.LinearLayout' and ./*[@class='android.widget.LinearLayout']])")
				puts "Current contents item is #{cnt}"
				getTitlebd = client.getTextIn2("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='title'])", 0, "NATIVE", "Inside", 0, 0)
				puts "Element before editing: #{getTitlebd}"

				if cnt > 3
					for i in 0..2
						client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*[@id='delete_button'])[1]", 0, 1)
						client.sleep(2000)
					end
				else
					client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*[@id='delete_button'])[1]", 0, 1)
					client.sleep(5000)
				end
				#This implementation is zantei operation, due to APP-1331 bug
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=視聴履歴", 0, 1)
				client.sleep(2000)

				if client.isElementFound("NATIVE", "text=視聴履歴がありません")
					@@eres = @@eres.push(true)
				else
					getTitlead = client.getTextIn2("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='title'])", 0, "NATIVE", "Inside", 0, 0)
					puts "Element before editing: #{getTitlead}"
					if getTitlead == getTitlebd
						@@eres = @@eres.push(false)
					else
						@@eres = @@eres.push(true)
					end
				end
			end
			EditHistory.new.returnResult(@@eres)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgEdith = "::MSG:: Exception occurrred while editing history list: " + e.message	
		end
	end

	####################################################
	#Function Name: returnResult
	#Activity: Function for returning result
	#Param: object
	####################################################
	
	def returnResult(res)

		@res = res
		if @res.include?(false)
			puts "編集操作に問題が発生しました「Issue occurred while editing」"
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"		
		else
			puts "::MSG:: 編集に問題ありませんでした「Editing has been done successfully」"					
			$result = $resultOK
			$passCount = $passCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end
		puts "Result is: #{@res}"
	end
end