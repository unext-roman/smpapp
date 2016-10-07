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
		@err_message = $errMsgEditd
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
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
				@@dres = @@dres.push(false)
				$errMsgEditd = "::MSG:: ダウンロード一覧に編集するの項目がありませんでした、作品を用意してから又ご確認下さい"
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
				end
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ダウンロード済み", 0, 1)
				client.sleep(2000)				
				if client.isElementFound("NATIVE", "xpath=//*[@text='ダウンロード済みの作品がありません']", 0)
					@@dres = @@dres.push(true)
				else					
					getTitlead = client.getTextIn2("NATIVE", "xpath=//*[@id='title']", 0, "NATIVE", "Inside", 0, 0)
					puts "Element before editing: #{getTitlead}"
					if getTitlead == getTitlebd
						@@dres = @@dres.push(false)
					else
						@@dres = @@dres.push(true)
					end
				end	
			end
			EditHistory.new.returnResult(@@dres)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgEditd = "::MSG:: Exception occurrred while editing download list: " + e.message
			@@dres = @@dres.push(false)
			EditHistory.new.returnResult(@@dres)
		end
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testEditHistoryList
	#Activity: Function for adding to mylist and remove
	#Param: object
	####################################################

	def ios_testEditDownloadList(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST EDITING DOWNLOAD@ダウンロードの編集機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				EditDownload.new.ilistEditing(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				EditDownload.new.ilistEditing(client)
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
		@test_device = "iOS"
		@testcase_num = 20
		@testcase_summary = "ダウンロードの編集"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgEditd
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		puts ($obj_editm.ios_testEditFavoriteList(client))
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
			client.click("NATIVE", "xpath=//*[@text='ダウンロード済み']", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=ダウンロード済みの作品がありません")
				puts "::MSG:: There is no item in download list!!!"
				@@dres = @@dres.push(false)
				$errMsgEditd = "::MSG:: ダウンロード一覧に編集するの項目がありませんでした、作品を用意してから又ご確認下さい"
				EditHistory.new.returnResult(@@dres)
			else
				cnt = client.getElementCount("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayIndicator' and @onScreen='true' and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]")
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
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @width>0 and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ダウンロード済み']", 0, 1)
				client.sleep(2000)						
				if client.isElementFound("NATIVE", "xpath=//*[@text='ダウンロード済みの作品がありません']", 0)
					@@dres = @@dres.push(true)
					EditHistory.new.returnResult(@@dres)
				else
					getTitlead = client.getTextIn2("NATIVE", "xpath=//*[@onScreen='true' and @x=30 and @y=164 and @class='UNextMobile_Protected.LayoutableLabel']", 0, "NATIVE", "Inside", 0, 0)
					puts "Element before editing: #{getTitlead}"
					if getTitlead == getTitlebd
						@@dres = @@dres.push(false)
					else
						@@dres = @@dres.push(true)
					end
					EditHistory.new.returnResult(@@dres)
				end
			end
			
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgEditd = "::MSG:: Exception occurrred while editing download list: " + e.message
			@@dres = @@dres.push(false)
			EditHistory.new.returnResult(@@dres)	
		end
	end	
end