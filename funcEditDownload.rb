#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・ダウンロードの編集機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class EditDownload

	@@dres = []

	####################################################
	#Target Device: Android
	#Function Name: testEditHistoryList
	#Activity: Function for adding to mylist and remove
	#Param: object
	####################################################

	def testEditDownloadList(client)
		client.sleep(2000)
		client.setDevice("adb:401SO")	

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST EDITING DOWNLOAD@ダウンロードの編集機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				EditDownload.new.listEditing(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				EditDownload.new.listEditing(client)
			end
		rescue Exception => e
			$errMsgEditd = "::MSG:: Exception occurrred while finding element: " + e.message	
		end	

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 20
		@testcase_summary = "ダウンロードの編集"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgEdith
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_editm.testEditFavoriteList(client))
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
			client.click("NATIVE", "text=ダウンロード済み", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=ダウンロード済みの作品がありません")
				puts "::MSG:: There is no item in download list!!!"
				@@dres = @@dres.push(true)
			else
				cnt = client.getElementCount("NATIVE", "xpath=(//*[@id='recycler_view']/*[@class='android.widget.LinearLayout' and ./*[@class='android.widget.LinearLayout']])")
				puts "Current contents item is #{cnt}"
				getTitlebd = client.getTextIn2("NATIVE", "xpath=//*[@id='title']", 0, "NATIVE", "Inside", 0, 0)
				puts "Element before editing: #{getTitlebd}"

				if cnt > 3
					for i in 0..2
						client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*[@id='delete_button'])[1]", 0, 1)
						client.sleep(2000)
						if client.isElementFound("NATIVE", "xpath=//*[@text='中止する']")
							client.click("NATIVE", "xpath=//*[@text='中止する']", 0, 1)
							client.sleep(1000)
						elsif client.isElementFound("NATIVE", "xpath=//*[@text='はい']")
							client.click("NATIVE", "xpath=//*[@text='はい']", 0, 1)
							client.sleep(1000)
						end					
					end
					getTitlead = client.getTextIn2("NATIVE", "xpath=//*[@id='title']", 0, "NATIVE", "Inside", 0, 0)
					puts "Element before editing: #{getTitlead}"
				else
					client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*[@id='delete_button'])", 0, 1)
					client.sleep(2000)
					if client.isElementFound("NATIVE", "xpath=//*[@text='中止する']")
						client.click("NATIVE", "xpath=//*[@text='中止する']", 0, 1)
						client.sleep(1000)
					elsif client.isElementFound("NATIVE", "xpath=//*[@text='はい']")
						client.click("NATIVE", "xpath=//*[@text='はい']", 0, 1)
						client.sleep(1000)
					end
					if client.isElementFound("NATIVE", "xpath=//*[@text='ダウンロード済みの作品がありません']", 0)
						@@dres = @@dres.push(true)
					else					
						getTitlead = client.getTextIn2("NATIVE", "xpath=//*[@id='title']", 0, "NATIVE", "Inside", 0, 0)
						puts "Element before editing: #{getTitlead}"
					end		
				end
				if getTitlead == getTitlebd
					@@dres = @@dres.push(false)
				else
					@@dres = @@dres.push(true)
				end
			end
			EditHistory.new.returnResult(@@dres)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgEdith = "::MSG:: Exception occurrred while editing download list: " + e.message	
		end
	end
end