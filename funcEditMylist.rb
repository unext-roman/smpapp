#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・マイリストの編集機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class EditMylist

	@@mres = []

	####################################################
	#Target Device: Android
	#Function Name: testEditMylist
	#Activity: Function for editing mylist
	#Param: object
	####################################################

	def testEditFavoriteList(client)
		client.sleep(2000)
		client.setDevice("adb:401SO")		
		
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST EDITING MYLIST@マイリストの編集機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				EditMylist.new.listEditing(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				EditMylist.new.listEditing(client)
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
		@testcase_num = 21
		@testcase_summary = "マイリストの編集"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgEditm
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_rtngs.testSakuhinRatings(client))
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
			client.click("NATIVE", "text=マイリスト", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=お気に入りはありません")
				puts "::MSG:: There is no item in mylist!!!"
				@@mres = @@mres.push(true)
			else
				cnt = client.getElementCount("NATIVE", "xpath=(//*[@id='recycler_view']/*[./*[@id='image_container']])")
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
					client.sleep(2000)
				end

				#This implementation is zantei operation, due to APP-1331 bug
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=マイリスト", 0, 1)
				client.sleep(2000)

				if client.isElementFound("NATIVE", "text=お気に入りはありません")
					@@mres = @@mres.push(true)
				else
					getTitlead = client.getTextIn2("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='title'])", 0, "NATIVE", "Inside", 0, 0)
					puts "Element after editing: #{getTitlead}"
					if getTitlead == getTitlebd
						@@mres = @@mres.push(false)
					else
						@@mres = @@mres.push(true)
					end
				end
			end
			EditHistory.new.returnResult(@@mres)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgEdith = "::MSG:: Exception occurrred while editing download list: " + e.message	
		end
	end
end