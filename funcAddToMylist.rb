#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・マイリストに追加・削除機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class AddToMylist

	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testAddtoMylist
	#Activity: Function for adding to mylist and remove
	#Param: object
	####################################################

	def testAddtoMylist(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST ADDTO FAVORITE@マイリストに追加・削除機能"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				AddToMylist.new.addingToMylist(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				AddToMylist.new.addingToMylist(client)
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgAdtml = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 16
		@testcase_summary = "マイリストに追加・削除機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgAdtml
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_lnbck.testLeanbackOperation(client))
	end

	####################################################
	#Function Name: searchOperation
	#Activity: Function for searching by keywords
	#Param: object
	####################################################

	def addingToMylist(client)

		begin
			if client.isElementFound("NATIVE", "xpath=//*[@text='マイリスト' and @id='titleView']")
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=マイリスト", 0, 1)
				client.sleep(2000)
				AddToMylist.new.deleteMylistContents(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(3000)
				client.swipe2("Down", 500, 100)
				client.sleep(2000)
			else
				client.swipe2("Down", 500, 100)
				client.sleep(2000)
			end
			client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])", 0, 1)
			client.sleep(2000)
			AddToMylist.new.addOperation(client)
			client.sleep(2000)
		rescue Exception => e
			$errMsgAdtml = "::MSG:: Exception occurrred while adding to mylist: " + e.message	
		end		
	end

	####################################################
	#Function Name: addOperation
	#Activity: Function for adding to list and confirming test result
	#Param: object
	####################################################

	def addOperation(client)

		@cname1 = ""
		@cname2 = ""
		begin
			@cname1 = client.getTextIn2("NATIVE", "xpath=//*[@id='textView' and ./parent::*[@class='android.widget.LinearLayout' and ./parent::*[@id='listView']]]", 0, "NATIVE", "Inside", 0, 0)
			client.swipe2("Down", 1000, 100)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='マイリスト' and @id='textView1']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='マイリストに追加済' and ./parent::*[@id='otherView1']]")
				puts "::MSG:: Added to mylist"
			else
				puts "::MSG:: Could not add to mylist"
			end
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=マイリスト", 0, 1)
			client.sleep(2000)
			@cname2 = client.getTextIn2("NATIVE", "xpath=//*[@id='title']", 0, "NATIVE", "Inside", 0, 0)
			if @cname2 == @cname1
				@@comment = "::MSG:: マイリストに追加しました「Added to Mylist successfully」"					
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			else
				$errMsgAdtml = "マイリストに追加できませんでした「Could not add to Mylist」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			end
		rescue Exception => e
			$errMsgAdtml = "::MSG:: Exception occurrred while adding to mylist: " + e.message
			$obj_rtnrs.returnNG
		end
	end

	####################################################
	#Function Name: deleteDownloadedContents
	#Activity: Function for deleting existing downloaded items
	#Param: object
	####################################################

	def deleteMylistContents(client)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @マイリスト作品を削除機能"

		begin			
			if client.isElementFound("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])[1]")
				puts "::MSG:: Mylist items will be deleted"

				ditems = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", "id")
				cnt = ditems.length
				puts "Current contents item is #{cnt}"

				begin
					client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*[@id='delete_button'])", 0, 1)
					client.sleep(2000)
					cnt += 1
				end until cnt == 0
			end
		rescue Exception => e
			$errMsgMylst = "::MSG:: Exception occurrred while deleting mylist items " + e.message	
		end
	end

	####################################################
	#Target Device: iOS
	#Function Name: testAddtoMylist
	#Activity: Function for adding to mylist and remove
	#Param: object
	####################################################

	def ios_testAddtoMylist(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST MYLIST EDITING@マイリストに追加・削除機能"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				AddToMylist.new.iaddingToMylist(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				AddToMylist.new.iaddingToMylist(client)
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)				
		rescue Exception => e
			$errMsgAdtml = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 16
		@testcase_summary = "マイリストに追加・削除機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgAdtml
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts (ios_testEditHistoryList(client))
	end

	####################################################
	#Function Name: searchOperation
	#Activity: Function for searching by keywords
	#Param: object
	####################################################

	def iaddingToMylist(client)

		begin
			if client.isElementFound("NATIVE", "xpath=//*[@text='マイリスト' and @class='UNextMobile_Protected.EasyLabel']")
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='マイリスト']", 0, 1)
				client.sleep(2000)				
				AddToMylist.new.ideleteMylistContents(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
			end
			client.click("NATIVE", "xpath=(//*[@class='UICollectionView' and ./preceding-sibling::*[@class='UIView']]/*/*/*[@class='UNextMobile_Protected.UNAsyncImageView' and ./parent::*[@class='UIView' and ./parent::*[@class='UNextMobile_Protected.HomeTitleCell']]])", 0, 1)
			client.sleep(2000)
			AddToMylist.new.iaddOperation(client)
		rescue Exception => e
			$errMsgAdtml = "::MSG:: Exception occurrred while adding to mylist: " + e.message	
		end		
	end

	####################################################
	#Function Name: addOperation
	#Activity: Function for adding to list and confirming test result
	#Param: object
	####################################################

	def iaddOperation(client)

		@cname1 = ""
		@cname2 = ""

		begin
			@cname1 = client.getTextIn2("NATIVE", "xpath=//*[@class='UNextMobile_Protected.LayoutableLabel' and ./parent::*[@class='UITableViewCellContentView'] and ./preceding-sibling::*[@class='UIView'] and @height=58]", 0, "NATIVE", "Inside", 0, 0)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='マイリスト' and @class='UIButtonLabel']", 0, 1)
			client.sleep(1000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='マイリストに追加済']")
				puts "::MSG:: Added to mylist"
			else
				puts "::MSG:: Could not add to mylist"
			end
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @width>0 and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='マイリスト']", 0, 1)
			client.sleep(2000)				
			@cname2 = client.getTextIn2("NATIVE", "xpath=//*[@class='UNextMobile_Protected.LayoutableLabel' and @height=32]", 0, "NATIVE", "Inside", 0, 0)
			if @cname2 == @cname1
				@@comment = "::MSG:: マイリストに追加しました「Added to Mylist successfully」"					
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			else
				$errMsgAdtml = "マイリストに追加できませんでした「Could not add to Mylist」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			end
		rescue Exception => e
			$errMsgAdtml = "::MSG:: Exception occurrred while adding to mylist: " + e.message
			$obj_rtnrs.returnNG
		end
	end

	####################################################
	#Function Name: deleteDownloadedContents
	#Activity: Function for deleting existing downloaded items
	#Param: object
	####################################################

	def ideleteMylistContents(client)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST MYLIST ITEM DELETE@マイリスト作品を削除機能"

		begin			
			if client.isElementFound("NATIVE", "xpath=//*[@class='UNextMobile_Protected.ThumbPlayButton' and ./parent::*[./parent::*[./parent::*[./parent::*[./parent::*[@class='UIViewControllerWrapperView']]]]]][1]")
				puts "::MSG:: Mylist items will be deleted"

				cnt = client.getElementCount("NATIVE", "xpath=//*[@class='UNextMobile_Protected.ThumbPlayButton' and ./parent::*[./parent::*[./parent::*[./parent::*[./parent::*[@class='UIViewControllerWrapperView']]]]]]")
				puts "Current contents item is #{cnt}"

				until client.isElementFound("NATIVE", "xpath=//*[@text='マイリストがありません']") do
					client.click("NATIVE", "xpath=//*[@text='編集']", 0, 1)
					client.sleep(1000)
					client.click("NATIVE", "xpath=//*[@class='_TtC21UNextMobile_ProtectedP33_645B9E799C3DB4E8558DCCFF4A1EA12D13CheckmarkView' and ./parent::*[@class='UNextMobile_Protected.UNFavoriteItemCell']]", 0, 1)
					client.sleep(1000)
					client.click("NATIVE", "xpath=//*[@text='削除']", 0, 1)
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@text='はい']", 0, 1)					
					client.sleep(2000)
					cnt += 1
				end
			end
		rescue Exception => e
			$errMsgMylst = "::MSG:: Exception occurrred while deleting mylist items " + e.message	
		end
	end
end