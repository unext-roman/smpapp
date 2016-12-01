#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・フィルタリング・表示順機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class FilterSearch

	@@fres = []
	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testGenericSearch
	#Activity: Function for keyword search test
	#Param: object
	####################################################

	def testFilterSearch(client)
		client.sleep(2000)
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST FILTERING SEARCH@フィルタリング・表示順機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				FilterSearch.new.filterOperation(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				FilterSearch.new.filterOperation(client)
			end

			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
		rescue Exception => e
			$errMsgFsrch = "::MSG:: Exception occurred during search operation " + e.message
		end			

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 14
		@testcase_summary = "フィルタリング・表示順機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgFsrch
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: searchOperation
	#Activity: Function for searching by keywords
	#Param: object
	####################################################

	def filterOperation(client)

		begin
			client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=洋画一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=すべての作品", 0, 1)
			client.sleep(2000)
			#if client.isElementFound("NATIVE", "xpath=//*[@id='search_kind_selector']","xpath=//*[@id='segmented_group']")
			if client.isElementFound("NATIVE", "xpath=//*[@id='search_kind_selector']")
				client.click("NATIVE", "text=見放題", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*/*[@id='thumbnail'])", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='見放題' and @class='android.support.v7.widget.AppCompatTextView']")
					@@fres = @@fres.push(true)
				else
					@@fres = @@fres.push(false)
				end
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ポイント", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*/*[@id='thumbnail'])", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='ポイント' and @class='android.support.v7.widget.AppCompatTextView' and ./parent::*[@id='otherView']]")
					@@fres = @@fres.push(true)
				else
					@@fres = @@fres.push(false)
				end
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=すべて", 0, 1)
			end
			client.sleep(2000)
			client.click("NATIVE", "text=ランキング順", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=古い作品順")
			client.sleep(2000)
			client.click("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*/*[@id='thumbnail'])", 0, 1)
			client.sleep(2000)
			str = client.getTextIn2("NATIVE", "xpath=//*[@id='textView1' and ./preceding-sibling::*[@id='ratingView']]", 0, "NATIVE", "Inside", 0, 0)
			str1 = str.scan(/\d+/).first
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=古い作品順", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=新しい作品順", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*/*[@id='thumbnail'])", 0, 1)
			client.sleep(2000)
			str2 = client.getTextIn2("NATIVE", "xpath=//*[@id='textView1' and ./preceding-sibling::*[@id='ratingView']]", 0, "NATIVE", "Inside", 0, 0)
			str3 = str2.scan(/\d+/).first
			client.sleep(2000)
			FilterSearch.new.compareVal(client, str1, str3)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=新しい作品順", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=50音順(あ〜わ)", 0, 1)
			client.sleep(2000)
			str4 = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*[@id='title' and ./parent::*[@class='android.widget.RelativeLayout']])[1]", "text")
			str5 = str4[0]
			client.sleep(2000)
			client.click("NATIVE", "text=50音順(あ〜わ)", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=50音順(わ〜あ)", 0, 1)		
			client.sleep(2000)
			str6 = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*[@id='title' and ./parent::*[@class='android.widget.RelativeLayout']])[1]", "text")
			str7 = str6[0]
			client.sleep(2000)
			puts "::MSG:: STR7 contains : #{str7}"		
			FilterSearch.new.compareStr(client, str5, str7)
			client.sleep(2000)
			#client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@id='searchTextBg']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			FilterSearch.new.searchResult
		rescue Exception => e
			$errMsgFsrch = "::MSG:: Exception occurred during search operation " + e.message
		end			
	end

	def compareVal(client, v1, v2)
		puts "Cmparing YEAR : #{v1}, #{v2}"
		if v2 > v1
			@@fres = @@fres.push(true)
		else
			@@fres = @@fres.push(false)
		end
		puts "Cmparing RESULT: #{@@fres}"
	end

	def compareStr(client, st1, st2)
		puts "String CHAR : #{st1}, #{st2}"
		if st1.include?('あ') || st1.include?('ア')
			@@fres = @@fres.push(true)
		else
			@@fres = @@fres.push(false)
		end
		puts "String RESULT: #{@@fres}"

		if st2.include?('わ') || st2.include?('ワ')
			@@fres = @@fres.push(true)
		else
			@@fres = @@fres.push(false)
		end
		puts "String RESULT: #{@@fres}"
	end

	####################################################
	#Function Name: searchResult
	#Activity: Function for confirming test result
	#Param: object
	####################################################

	def searchResult

		if @@fres.include?(false)			
			$errMsgFsrch = "::MSG::フィルタリング・表示順検索結果に誤りが発生しました「Filtering search did not work properly」"
			$obj_rtnrs.returnNG
			$obj_rtnrs.printResult
		else
			@@comment = "::MSG::フィルタリング・表示順検索結果が正しいでした「Filtering search works properly」"					
			$obj_rtnrs.returnOK
			$obj_rtnrs.printResult
		end
		puts "#{@@fres}"
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testGenericSearch
	#Activity: Function for keyword search test
	#Param: object
	####################################################

	def ios_testFilterSearch(client)
		client.sleep(2000)
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST FILTER SEARCH@フィルタリング・表示順機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				FilterSearch.new.ifilterOperation(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				FilterSearch.new.ifilterOperation(client)
			end

			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@class='UIControl']", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgFsrch = "::MSG:: Exception occurred during search operation " + e.message
		end			

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 14
		@testcase_summary = "フィルタリング・表示順機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgFsrch
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: searchOperation
	#Activity: Function for searching by keywords
	#Param: object
	####################################################

	def ifilterOperation(client)

		begin
			#client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./following-sibling::*[@class='UIButtonLabel'] and ./parent::*[@class='UIButton' and ./parent::*[@class='UNextMobile_Protected.UNChromecastButtonContainer']]]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='すべての作品']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@class='UISegmentedControl']")
				client.click("NATIVE", "accessibilityLabel=見放題", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='見放題' and @class='UNextMobile_Protected.UNBadgeLabel']")
					@@fres = @@fres.push(true)
				else
					@@fres = @@fres.push(false)
				end
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "accessibilityLabel=Uコイン", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='コイン']") || client.isElementFound("NATIVE", "xpath=//*[@text='購入済み' and @top='true']")
					@@fres = @@fres.push(true)
				else
					@@fres = @@fres.push(false)
				end
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='すべて']", 0, 1)
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ランキング順' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='古い作品順']")
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
			client.sleep(2000)
			str = client.getTextIn2("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./*[@class='UNextMobile_Protected.UNRatingView']]", 0, "NATIVE", "Inside", 0, 0)
			str1 = str.scan(/\d+/).first
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='古い作品順' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='新しい作品順']")
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
			client.sleep(2000)
			str2 = client.getTextIn2("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./*[@class='UNextMobile_Protected.UNRatingView']]", 0, "NATIVE", "Inside", 0, 0)
			str3 = str2.scan(/\d+/).first
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			FilterSearch.new.compareVal(client, str1, str3)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='新しい作品順' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='50音順(あ→わ)']", 0, 1)
			client.sleep(2000)
			str4 = client.getTextIn2("NATIVE", "xpath=//*[@class='UNextMobile_Protected.LayoutableLabel' and @text and @top='true' and @height=32]", 0, "NATIVE", "Inside", 0, 0)
			str5 = str4[0]
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='50音順(あ→わ)']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='50音順(わ→あ)']", 0, 1)		
			client.sleep(2000)
			str6 = client.getTextIn2("NATIVE", "xpath=//*[@class='UNextMobile_Protected.LayoutableLabel' and @text and @top='true' and @height=32]", 0, "NATIVE", "Inside", 0, 0)
			str7 = str6[0]
			client.sleep(2000)
			FilterSearch.new.compareStr(client, str5, str7)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			FilterSearch.new.searchResult
		rescue Exception => e
			$errMsgFsrch = "::MSG:: Exception occurred during search operation " + e.message
		end			
	end
end
