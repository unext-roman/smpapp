#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・ジャンル検索機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class GenericSearch

	@@gres = []

	####################################################
	#Target Device: Android
	#Function Name: testGenericSearch
	#Activity: Function for keyword search test
	#Param: object
	####################################################

	def testGenericSearch(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST GENERIC SEARCH@ジャンル検索機能"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				GenericSearch.new.generOperation(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				GenericSearch.new.generOperation(client)
			end
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
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
		@testcase_num = 14
		@testcase_summary = "ジャンル検索機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgSarch
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_fltrs.testFilterSearch(client))
	end

	####################################################
	#Function Name: searchOperation
	#Activity: Function for searching by keywords
	#Param: object
	####################################################

	def generOperation(client)

		begin
			client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=洋画一覧", 0, 1)
			client.sleep(2000)
	   		client.click("NATIVE", "text=新規入荷作品", 0, 1)
	   		client.sleep(2000)
	   		GenericSearch.new.checkScreen(client)
	    	client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
	    	client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=邦画一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=新作・準新作", 0, 1)
			client.sleep(2000)
	   		GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=海外ドラマ一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ドラマ", 0, 1)
			client.sleep(2000)
	   		GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=韓流・アジアドラマ一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=コメディ", 0, 1)
			client.sleep(2000)
	   		GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=アニメ一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ロボット・メカ", 0, 1)
			client.sleep(2000)
	   		GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=キッズ一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=えほん", 0, 1)
			client.sleep(2000)
	   		GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ドキュメンタリー一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=NHK番組", 0, 1)
			client.sleep(2000)
	   		GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			GenericSearch.new.searchResult
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurred during search operation " + e.message
		end			
	end

	def checkScreen(client)		
		if client.isElementFound("NATIVE", "xpath=//*[@id='search_kind_selector']") || client.isElementFound("NATIVE", "xpath=//*[@class='UISegmentedControl']")
			@@gres = @@gres.push(true)
		else
			@@gres = @@gres.push(false)
		end	
		puts "Return : #{@@gres}"
	end

	####################################################
	#Function Name: searchResult
	#Activity: Function for confirming test result
	#Param: object
	####################################################

	def searchResult

		if @@gres.include?(false)					
			puts "ジャンル検索結果に誤りが発生しました「Generic search did not work properly」"
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		else
			puts "::MSG:: ジャンル検索結果が正しいでした「Generic search works properly」"					
			$result = $resultOK
			$passCount = $passCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end
		puts "::MSG:: Result is  #{@@gres}"
	end

	####################################################
	#Target Device: iOS
	#Function Name: testGenericSearch
	#Activity: Function for keyword search test
	#Param: object
	####################################################

	def ios_testGenericSearch(client)
		client.sleep(2000)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST GENERIC SEARCH@ジャンル検索機能"

		$totalTest = $totalTest + 1 

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				GenericSearch.new.igenerOperation(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				GenericSearch.new.igenerOperation(client)
			end
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UIControl']", 0, 1)
			client.sleep(2000)
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
		@testcase_num = 14
		@testcase_summary = "ジャンル検索機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgSarch
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_fltrs.ios_testFilterSearch(client))
	end

	def icheckSearchField(client)
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@text='タイトルとの一致']")
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='search clear']]", 0, 1)
			elsif client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]")
				until client.isElementFound("NATIVE", "xpath=//*[@class='UITextFieldBorderView']") do
					client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
				end
			else
				puts "::MSG:: Generic search can be continued!!!"
			end
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurred during search operation " + e.message
		end		
	end

	def igenerOperation(client)

		begin
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
			client.sleep(1000)

			# currently this condition has problem and needs to correct
			if client.isElementFound("NATIVE", "xpath=//*[@text='タイトルとの一致']") == true || client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]") == true
				GenericSearch.new.icheckSearchField(client)
			end
		
			client.click("NATIVE", "xpath=//*[@text='洋画一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='新規入荷作品']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='邦画一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='新作・準新作']", 0, 1)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='海外ドラマ一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='ドラマ']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='韓流・アジアドラマ一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='ラブロマンス']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='アニメ一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='ロボット・メカ']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='キッズ一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='えほん']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ドキュメンタリー一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='NHK番組']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='音楽・アイドル一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='LIVE映像・舞台']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='テレビ局']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='テレ朝動画']", 0, 1)
			client.sleep(2000)
			GenericSearch.new.checkScreen(client)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			GenericSearch.new.searchResult
		rescue Exception => e
			$errMsgSarch = "::MSG:: Exception occurred during search operation " + e.message
		end			
	end
end
