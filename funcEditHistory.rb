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
	@@comment = ""

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
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
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
				@@eres = @@eres.push(false)
				$errMsgEdith = "::MSG:: 視聴履歴一覧に編集するの項目がありませんでした、作品を用意してから又ご確認下さい"
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
			$errMsgEdith = "編集操作に問題が発生しました「Issue occurred while editing」"
			$obj_rtnrs.returnNG
			$obj_rtnrs.printResult	
		else
			@@comment = "::MSG:: 編集に問題ありませんでした「Editing has been done successfully」"					
			$obj_rtnrs.returnOK
			$obj_rtnrs.printResult
		end
		puts "Result is: #{@res}"
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testEditHistoryList
	#Activity: Function for adding to mylist and remove
	#Param: object
	####################################################

	def ios_testEditHistoryList(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST EDITING HISTORY@視聴履歴の編集機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				EditHistory.new.ilistEditing(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				EditHistory.new.ilistEditing(client)
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
		@test_device = "iOS" 
		@testcase_num = 19
		@testcase_summary = "視聴履歴の編集"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgEdith
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		puts ($obj_editd.ios_testEditDownloadList(client))		
	end

	####################################################
	#Function Name: ilistEditing
	#Activity: Function for editing history list
	#Param: object
	####################################################

	def ilistEditing(client)

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=視聴履歴", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=視聴履歴がありません")
				puts "::MSG:: There is no item in history list!!!"
				@@eres = @@eres.push(false)
				$errMsgEdith = "::MSG:: 視聴履歴一覧に編集するの項目がありませんでした、作品を用意してから又ご確認下さい"
			else
				#titles = client.getAllValues("NATIVE", "xpath=//*[@class='UNextMobile_Protected.LayoutableLabel' and ./parent::*[./parent::*[@class='UNextMobile_Protected.UNMovieItemCell']]]", "text")
				cnt = client.getElementCount("NATIVE", "xpath=//*[@class='UIView' and @onScreen='true' and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton' and ./preceding-sibling::*[@class='UNextMobile_Protected.LayoutableLabel']]]")
				puts "Current contents item is #{cnt}"
				getTitlebd = client.getTextIn2("NATIVE", "xpath=//*[@onScreen='true' and @x=30 and @y=164 and @class='UNextMobile_Protected.LayoutableLabel']", 0, "NATIVE", "Inside", 0, 0)
				puts "Element before editing: #{getTitlebd}"

				if cnt > 3
					for i in 0..2
						client.click("NATIVE", "xpath=//*[@text='編集']", 0, 1)
						client.sleep(2000)
						client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='useritem_checkmark']", 0, 1)
						client.sleep(2000)
						if client.waitForElement("NATIVE", "xpath=//*[@text='削除']", 0, 30000)
						    # If statement
						end
						client.click("NATIVE", "xpath=//*[@text='削除']", 0, 1)
						client.sleep(2000)
						client.click("NATIVE", "xpath=//*[@text='はい']", 0, 1)
						client.sleep(2000)
					end
				else
					client.click("NATIVE", "xpath=//*[@text='編集']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='useritem_checkmark']", 0, 1)
					client.sleep(2000)
					if client.waitForElement("NATIVE", "xpath=//*[@text='削除']", 0, 30000)
					    # If statement
					end
					client.click("NATIVE", "xpath=//*[@text='削除']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@text='はい']", 0, 1)
					client.sleep(2000)
				end
				#This implementation is zantei operation, due to APP-1331 bug
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @width>0 and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='視聴履歴']", 0, 1)
				client.sleep(2000)				

				if client.isElementFound("NATIVE", "xpath=//*[@text='視聴履歴がありません']")
					@@eres = @@eres.push(true)
				else
					getTitlead = client.getTextIn2("NATIVE", "xpath=//*[@onScreen='true' and @x=30 and @y=164 and @class='UNextMobile_Protected.LayoutableLabel']", 0, "NATIVE", "Inside", 0, 0)
					puts "Element after editing: #{getTitlead}"
					if getTitlead == getTitlebd
						@@eres = @@eres.push(false)
					else
						@@eres = @@eres.push(true)
					end
				end
			end
			EditHistory.new.returnResult(@@eres)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)				
		rescue Exception => e
			$errMsgEdith = "::MSG:: Exception occurrred while editing history list: " + e.message	
		end
	end
end