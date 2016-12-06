#!/usr/bin/ruby

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・見放題エピソード再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class EpisodePlay

	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testSVODEpisodePlay
	#Activity: Function for playing from episode list
	#Param: object
	####################################################

	def testSVODEpisodePlay(client)
		client.sleep(2000)
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST EPISODE PLAY@見放題エピソード再生機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				client.sleep(1000)
				EpisodePlay.new.getEpisodeToPlay(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				EpisodePlay.new.getEpisodeToPlay(client)
			end				
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@id='search_kind_selector']", 0)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=ホーム", 0, 1)
			end
		rescue Exception => e
			$errMsgEpsdp = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 11
		@testcase_summary = "見放題エピソード再生機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgBougt
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: getEpisodeToPlay
	#Activity: Function for getting SVOD drama to be played
	#Param: object
	####################################################

	def getEpisodeToPlay(client)

		begin
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='海外ドラマ' and @id='textView']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='見放題で楽しめる厳選良作！海外ドラマ編']")
				client.click("NATIVE", "xpath=(//*[@id='recyclerView' and ./preceding-sibling::*[./*[@text='見放題で楽しめる厳選良作！海外ドラマ編']]]/*/*/*[@id='imageView' and ./parent::*[@id='maskLayout']])[1]", 0, 1)
				client.sleep(2000)
			else
				client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=国内ドラマ一覧", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=すべての作品", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "text=見放題", 0, 1)
				client.sleep(3000)
				client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='thumbnail'])", 0, 1)
				client.sleep(2000)
			end
			client.swipe2("Down", 250, 2000)
			client.sleep(3000)
		rescue Exception => e
			$errMsgEpsdp = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end		
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@text='エピソードを選択']")
				client.click("NATIVE", "text=エピソードを選択", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*/*[@id='download_indicator' and ./parent::*[@id='image_container']])[1]", 0, 1)
				client.sleep(10000)
				HistoryPlay.new.playbackCheck(client)
				HistoryPlay.new.leavingPlayer(client)
			else
				puts "::MSG:: This contents does not have episode list!!!"
			end
		rescue Exception => e
			$errMsgEpsdp = "::MSG:: Error occurred while episode playing.." + e.message
			$obj_rtnrs.returnNG
		end		
		client.sleep(2000)
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testSVODEpisodePlay
	#Activity: Function for playing from episode list
	#Param: object
	####################################################

	def ios_testSVODEpisodePlay(client)
		client.sleep(2000)
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST SVOD EPISODE PLAY@見放題エピソード再生機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				EpisodePlay.new.ios_getEpisodeToPlay(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
				EpisodePlay.new.ios_getEpisodeToPlay(client)
			end
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgEpsdp = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 11
		@testcase_summary = "見放題エピソード再生機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgBougt
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
	end

	####################################################
	#Function Name: getSvodContent
	#Activity: Function for getting SVOD content to be played
	#Param: object
	####################################################

	def ios_getEpisodeToPlay(client)
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='洋画' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='タイトルとの一致']") == true || client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]") == true
				$obj_gener.icheckSearchField(client)
			end
			client.click("NATIVE", "text=海外ドラマ一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=すべての作品", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=見放題", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@class='UIView' and @height>0 and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", 0, 1)
			client.sleep(2000)
			client.swipe2("Down", 500, 2000)
			client.sleep(3000)
			if client.isElementFound("NATIVE", "xpath=//*[@text='エピソードを選択']")
				client.click("NATIVE", "xpath=//*[@text='エピソードを選択']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
				client.sleep(10000)
				HistoryPlay.new.ios_playbackCheckFromList(client)
				HistoryPlay.new.ios_leavingPlayer(client)
			else
				puts "::MSG:: This contents does not have episode list!!!"
			end	
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='エピソード']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@class='UNextMobile_Protected.UNTitleListHeaderView']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIControl']", 0, 1)		
		rescue Exception => e
			$errMsgTanwa = "::MSG:: Exception occurrred while finding ELEMENT" + e.message
		end		
	end
end