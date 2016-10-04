#!/usr/bin/ruby

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・単話ダウンロード再生機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class DownlaodPlay

	$dloading = false

	####################################################
	#Target Device: Android
	#Function Name: testSingleDownload
	#Activity: Function for downloading single content
	#Param: object
	####################################################

	def testDownloadPlay(client)
		client.sleep(20000)
		#client.setDevice("adb:401SO")

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST DOWNLOAD PLAY@単話ダウンロード再生機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ダウンロード済み", 0, 1)
				client.sleep(2000)
				DownlaodPlay.new.checkDownloadStatus(client)
			else
				DownlaodPlay.new.checkDownloadStatus(client)
			end
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
	
		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 11
		@testcase_summary = "単話ダウンロード再生機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgDwnpl
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_keysh.testKeywordSearch(client))
	end

	####################################################
	#Function Name: checkDownloadStatus
	#Activity: Function for checking download status
	#Param: object
	####################################################

	def checkDownloadStatus(client)
		
		begin
			if client.isElementFound("NATIVE", "text=ダウンロード済みの作品がありません")
				puts "::MSG:: Empty download list"
				DownlaodPlay.new.downloadContents(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ダウンロード済み", 0, 1)
				client.sleep(2000)
				DownlaodPlay.new.downLoadProgress(client)
				client.sleep(1000)			
				if $dloading == true
					puts "::MSG:: Can not perform download playing, execute later"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					$errMsgDwnpl = "::MSG:: ダウンロードするに時間が掛かりました為テストを飛ばしました、ダウンロードが完了しました後又ご確認下さい"
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
				else
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@id='download_indicator']", 0, 1)
					client.sleep(10000)
					HistoryPlay.new.playbackCheck(client)
					HistoryPlay.new.leavingPlayer(client)
				end
			else
				puts "::MSG:: Download items available"
				DownlaodPlay.new.downLoadProgress(client)
				client.sleep(2000)
				if $dloading == true
					puts "::MSG:: Can not perform download playing, execute later"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					$errMsgDwnpl = "::MSG:: ダウンロードするに時間が掛かりました為テストを飛ばしました、ダウンロードが完了しました後ご確認下さい"
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"		
				else
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@id='download_indicator']", 0, 1)
					client.sleep(10000)
					HistoryPlay.new.playbackCheck(client)
					HistoryPlay.new.leavingPlayer(client)
				end
			end
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
	end

	####################################################
	#Function Name: checkDownloadStatus
	#Activity: Function for downloading a content
	#Param: object
	####################################################

	def downloadContents(client)

		begin
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=ホーム", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@id='searchButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=キッズ一覧", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "text=えほん", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@id='subscription']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*/*[@id='thumbnail'])", 0, 1)
			client.sleep(2000)
			client.swipe2("Down", 300, 1500)
		    client.sleep(1000)
			if client.waitForElement("NATIVE", "xpath=//*[@id='otherView' and @class='jp.co.unext.widget.DownloadCircleIndicator']", 0, 10000)
				#If statement
			end
			client.click("NATIVE", "xpath=//*[@id='otherView' and @class='jp.co.unext.widget.DownloadCircleIndicator']", 0, 1)
			if client.isElementFound("NATIVE", "xpath=//*[@id='alertTitle']")
				client.click("NATIVE", "xpath=//*[@id='button1']", 0, 1)
			end

			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@id='searchTextBg']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@id='searchTextBg']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@id='searchTextBg']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@id='searchTextBg']]", 0, 1)		
			client.sleep(2000)
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end
	end

	####################################################
	#Function Name: downLoadProgress
	#Activity: Function for checking download progress
	#Param: object
	####################################################

	def downLoadProgress(client)

		begin
			for i in 1..5
				dlcnt0 = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view']/*/*[@id='image_container'])[1]", "text")
				#puts "::MSG:: #{dlcnt0}"

				if dlcnt0.include?('ダウンロード中') || dlcnt0.include?('待機中')
					puts "::MSG:: 該当作品は現在特機中あるいはダウンロード中「Content is currently downloading or preparing to download」"

					puts "::MSG:: 5秒ほど待ちます。。。#{i}/5"
					client.sleep(5000)
					$dloading = true
				else
					$dloading = false
					break
				end
				i += 1				
			end
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Downlaod is taking too much time, skipping as of now " + e.message
		end
		#end while !dlcnt0.include?('ダウンロード中') 	
	end

	####################################################
	#Target Device: iOS
	#Function Name: testSingleDownload
	#Activity: Function for downloading single content
	#Param: object
	####################################################

	def ios_testDownloadPlay(client)
		client.sleep(2000)
		client.setDevice("ios_app:autoIpad")

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST DOWNLOAD PLAY@単話ダウンロード再生機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				DownlaodPlay.new.ios_checkDownloadStatus(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				DownlaodPlay.new.ios_checkDownloadStatus(client)
			end

			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end
	
		puts ($obj_utili.calculateRatio($finishedTest))

		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 11
		@testcase_summary = "単話ダウンロード再生機能"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgDwnpl
		@comment = ""

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		client.sleep(2000)
		puts ($obj_keysh.ios_testKeywordSearch(client))
	end

	####################################################
	#Function Name: ios_checkDownloadStatus
	#Activity: Function for checking download status
	#Param: object
	####################################################

	def ios_checkDownloadStatus(client)
		
		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ダウンロード済み']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=ダウンロード済みの作品がありません")
				puts "::MSG:: Empty download list"
				DownlaodPlay.new.ios_downloadContents(client)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ダウンロード済み']", 0, 1)
				client.sleep(2000)
				DownlaodPlay.new.ios_downLoadProgress(client)
				client.sleep(1000)			
				if $dloading == true
					puts "::MSG:: Can not perform download playing, execute later"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					$errMsgDwnpl = "::MSG:: ダウンロードするに時間が掛かりました為テストを飛ばしました、ダウンロードが完了しました後ご確認下さい"
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
				else
					client.sleep(2000)
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
					client.sleep(10000)
					HistoryPlay.new.ios_playbackCheckFromList(client)
					HistoryPlay.new.ios_leavingPlayer(client)
				end
			else
				puts "::MSG:: Download items available"
				DownlaodPlay.new.ios_downLoadProgress(client)
				client.sleep(2000)
				if $dloading == true
					puts "::MSG:: Can not perform download playing, execute later"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					$errMsgDwnpl = "::MSG:: ダウンロードするに時間が掛かりました為テストを飛ばしました、ダウンロードが完了しました後ご確認下さい"
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
				else
					client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]]", 0, 1)
					client.sleep(10000)
					HistoryPlay.new.ios_playbackCheckFromList(client)
					HistoryPlay.new.ios_leavingPlayer(client)
				end
			end
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			
	end

	####################################################
	#Function Name: ios_downloadContents
	#Activity: Function for downloading a content
	#Param: object
	####################################################

	def ios_downloadContents(client)

		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNDrawerCellbackgroundView' and ./preceding-sibling::*[@text='ホーム']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UITableView' and ./*[./*[@class='UNextMobile_Protected.SpecialBlockCell']]]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)		
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='キッズ一覧']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='えほん']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "accessibilityLabel=見放題", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.ThumbPlayButton' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(2000)

			if client.waitForElement("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNIndicatorView' and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UITableViewCellContentView']]]", 0, 10000)
				#If statement
			end
			if client.isElementFound("NATIVE", "xpath=//*[@accessibilityIdentifier='icon_download_unselect']")
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNIndicatorView' and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UITableViewCellContentView']]]", 0, 1)
				client.sleep(2000)			
				if client.isElementFound("NATIVE", "xpath=//*[@text='ダウンロードを開始します。']")
					client.click("NATIVE", "xpath=//*[@text='OK']", 0, 1)
				end
			end
			client.sleep(5000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@class='UNextMobile_Protected.UNTitleListHeaderView']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIControl']", 0, 1)
			client.sleep(1000)
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end
	end

	####################################################
	#Function Name: ios_downLoadProgress
	#Activity: Function for checking download progress
	#Param: object
	####################################################

	def ios_downLoadProgress(client)
		begin
			for i in 1..5
				dlcnt0 = client.getAllValues("NATIVE", "xpath=//*[@class='UILabel' and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton']]", "text")
				#puts "::MSG:: #{dlcnt0}"

				if dlcnt0.include?('ダウンロード中') || dlcnt0.include?('待機中')
					puts "::MSG:: 該当作品は現在特機中あるいはダウンロード中「Content is currently downloading or preparing to download」"

					puts "::MSG:: 5秒ほど待ちます。。。#{i}/5"
					client.sleep(5000)
					$dloading = true
				else
					$dloading = false
					break
				end
				i += 1				
			end
		rescue Exception => e
			$errMsgDwnpl = "::MSG:: Downlaod is taking too much time, skipping as of now " + e.message
		end
	end
end