#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・キーワードー検索機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class KeywordSearch

	@@res = []

	####################################################
	#Target Device: Android
	#Function Name: testKeywordSearch
	#Activity: Function for keyword search test
	#Param: object
	####################################################

	def testKeywordSearch(client)
		client.sleep(2000)
		
		@k1 = "lovers"
		@k2 = "ドラゴンボール"
		@k3 = "007"
		@k4 = "AKB48"
		@k5 = "tgyushtdgdbjs"

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST KEYWORD SEARCH@キーワードー検索機能"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				KeywordSearch.new.searchOperation(client, @k1, @k2, @k3, @k4, @k5)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				KeywordSearch.new.searchOperation(client, @k1, @k2, @k3, @k4, @k5)
			end
			client.sleep(1000)
			#client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@id='searchTextBg']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@id='search_word_container']]", 0, 1)			
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 13
		@testcase_summary = "キーワードー検索機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgSarch
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_gener.testGenericSearch(client))
	end

	####################################################
	#Function Name: searchOperation
	#Activity: Function for searching by keywords
	#Param: object
	####################################################

	def searchOperation(client, k1, k2, k3, k4, k5)

		keywords = [k1, k2, k3, k4, k5]

		begin
			keywords.each do |index|
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "id=editText", 0, 1)
				client.sleep(2000)
				client.elementSendText("NATIVE", "xpath=//*[@id='editText']", 0, index)
				client.sleep(2000)
				client.closeKeyboard()
				client.sleep(2000)

				if client.waitForElement("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*[@id='title' and ./parent::*[@class='android.widget.RelativeLayout']])")
					chkkeys = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*[@id='title' and ./parent::*[@class='android.widget.RelativeLayout']])", "text")
				else
					chkkeys = client.getAllValues("NATIVE", "xpath=//*[@id='recycler_view' and ./*[@text] and @onScreen='true']", "text")
				end		
				#puts "::MSG:: String values found are #{chkkeys}"
				key = ["LOVERS", "ドラゴンボール", "007", "AKB0048", "tgyushtdgdbjs"]
				#key = ["WWWWWWW", "ドドドド", "1111111", "SSSSS", "tgyushtdgdbjs"]
				key.each do |i|
					if chkkeys.select{|x| x.match(i) }.length > 0
						@@res = @@res.push(true) 
						puts "::MSG:: 検索キーワードーでの関連作品を見つけました「Search keyword related contents matched」"
						client.sleep(1000)
						client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)	
						client.sleep(1000)
					else
						@@res = @@res.push(false)
						puts "検索キーワードーでの関連作品を見つけませんでした「Did not find search keyword related contents」"
					end				
				end					
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)	
			client.sleep(2000)
			KeywordSearch.new.searchResult
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurred during search operation " + e.message
		end			
	end

	####################################################
	#Function Name: searchResult
	#Activity: Function for confirming test result
	#Param: object
	####################################################

	def searchResult

		#To check in which index true value is exist
		#hash = Hash[@@res.map.with_index.to_a]
		#puts hash[true]
		begin
			if @@res.include?(true)					
				puts "::MSG:: 検索キーワードーでの関連作品を見つけました「Search keyword related contents matched」"					
				$result = $resultOK
				$passCount = $passCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
			else
				puts "検索キーワードーでの関連作品を見つけませんでした「Did not find search keyword related contents」"
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"					
			end
			puts "::MSG:: Result is  #{@@res}"
			#puts "::MSG:: Total test #{$totalTest}"
			#puts "::MSG:: Pass count #{$passCount}"
			#puts "::MSG:: Fail count #{$failCount}"
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurred during search operation " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"					
		end		
	end
	#To-Do: Select searched item, and get into title details. future implementation

	####################################################
	#Target Device: iOS
	#Function Name: testKeywordSearch
	#Activity: Function for keyword search test
	#Param: object
	####################################################

	def ios_testKeywordSearch(client)
		client.sleep(2000)
		#client.setDevice("ios_app:autoIpad")
		
		@k1 = "lovers"
		@k2 = "ドラゴンボール"
		@k3 = "007"
		@k4 = "AKB48"
		@k5 = "tgyushtdgdbjs"

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST KEYWORD SEARCH@キーワードー検索機能"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				KeywordSearch.new.isearchOperation(client, @k1, @k2, @k3, @k4, @k5)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				KeywordSearch.new.isearchOperation(client, @k1, @k2, @k3, @k4, @k5)
			end
			#client.sleep(1000)
			#client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 13
		@testcase_summary = "キーワードー検索機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgSarch
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_gener.ios_testGenericSearch(client))
	end

	####################################################
	#Function Name: searchOperation
	#Activity: Function for searching by keywords
	#Param: object
	####################################################

	def isearchOperation(client, k1, k2, k3, k4, k5)

		keywords = [k1, k2, k3, k4, k5]

		begin
			keywords.each do |index|
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UITextFieldBorderView']", 0, 1)
				client.sleep(2000)
				client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView']", 0, index)
				client.sleep(2000)
				client.sendText("{ENTER}")
				client.sleep(3000)
				client.closeKeyboard()
				client.sleep(2000)

				if client.waitForElement("NATIVE", "xpath=//*[@class='UITableViewWrapperView' and ./*[@class='UNextMobile_Protected.UNEasyLabelCell']]")
					chkkeys = client.getAllValues("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNTitleCell' and ./*[./*[@text]]]", "text")
				else
					chkkeys = client.getAllValues("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNTitleCell' and ./*[./*[@text]]]", "text")
				end
				client.sleep(2000)
				puts "::MSG:: String values found are #{chkkeys}"
				key = ["LOVERS", "ドラゴンボール", "007", "AKB0048", "tgyushtdgdbjs"]
				#key = ["WWWWWWW", "ドドドド", "1111111", "SSSSS", "tgyushtdgdbjs"]
				key.each do |i|
					if chkkeys.select{|x| x.match(i) }.length > 0
						@@res = @@res.push(true)
						puts "Matched Found"
						#puts "::MSG:: 検索キーワードーでの関連作品を見つけました「Search keyword related contents matched」"
					else
						@@res = @@res.push(false)
						puts "Not Found"
						#puts "検索キーワードーでの関連作品を見つけませんでした「Did not find search keyword related contents」"
					end				
				end					
			end
			client.sleep(2000)
			#client.elementSendText("NATIVE", "xpath=//*[@class='UITextFieldBorderView']", 0, "")
			#client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='つづきを再生']", 0, 1)
			#client.click("NATIVE", "xpath=(//*[@class='UICollectionView' and ./following-sibling::*[@class='UITableViewLabel'] and ./parent::*[./parent::*[@class='UNextMobile_Protected.SpotlightBlockCell']]]/*/*/*[@class='UNextMobile_Protected.UNAsyncImageView' and ./parent::*[@class='UIView' and ./parent::*[@class='UNextMobile_Protected.HomeTitleCell']]])", 0, 1)	
			client.sleep(2000)
			KeywordSearch.new.searchResult
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurred during search operation " + e.message
		end			
	end
end
