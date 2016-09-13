#!/usr/bin/ruby

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・単話ダウンロード機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class TitleDownload

	####################################################
	#Target Device: Android
	#Function Name: testSingleDownload
	#Activity: Function for downloading single content
	#Param: object
	####################################################

	def testSingleDownload(client)
		client.sleep(2000)
		client.setDevice("adb:401SO")		

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @単話ダウンロード機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				TitleDownload.new.checkDownloadStatus(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(3000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
				TitleDownload.new.checkDownloadStatus(client)
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
			$errMsgDwnld = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		tc12 = ($obj_epsdp.testSVODEpisodePlay(client))	

		andrt10 = RegressionTestInfo.new
		andrt10.execution_time = $obj_utili.getTime
		andrt10.test_device = "ANDROID" 
		andrt10.testcase_num = 10
		andrt10.testcase_summary = "単話ダウンロード機能"
		andrt10.test_result = $result
		andrt10.capture_url = $captureURL
		andrt10.err_message = $errMsgDwnld
		andrt10.comment = ""

		return andrt10
	end

	####################################################
	#Function Name: getTargetContent
	#Activity: Function for download operation
	#Param: object
	####################################################

	def getTargetContent(client)

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
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@id='subscription']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=(//*[@id='recycler_view' and ./following-sibling::*[@id='error_view']]/*/*/*[@id='thumbnail'])", 0, 1)
			client.sleep(2000)
			client.swipe2("Down", 300, 1500)
		    client.sleep(1000)
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end
	    begin
			if client.waitForElement("NATIVE", "xpath=//*[@id='otherView' and @class='jp.co.unext.widget.DownloadCircleIndicator']", 0, 10000)
				#If statement
			end
			client.click("NATIVE", "xpath=//*[@id='otherView' and @class='jp.co.unext.widget.DownloadCircleIndicator']", 0, 1)
			if client.isElementFound("NATIVE", "xpath=//*[@id='alertTitle']")
				client.click("NATIVE", "xpath=//*[@id='button1']", 0, 1)
			end
			if client.isElementFound("NATIVE", "xpath=//*[@id='download_progress']")
				puts "::MSG:: ダウンロードを開始しました「Download has started」"
				$result = $resultOK
				$passCount = $passCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
			else
				puts "::MSG:: ダウンロードを失敗しました!!!「Downloading failed, Check status」"
				$result = $resultNG
				$failCount = $failCount + 1
				$finishedTest = $finishedTest + 1
				puts "Result is -> " + $result	
				puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
			end
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred during Download operation..: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end			
	end

	####################################################
	#Function Name: checkDownloadStatus
	#Activity: Function for checking download status
	#Param: object
	####################################################

	def checkDownloadStatus(client)
		
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='ダウンロード済み']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=ダウンロード済みの作品がありません")
				puts "::MSG:: Empty download list"
				TitleDownload.new.getTargetContent(client)
				client.sleep(10000)
			else
				puts "::MSG:: Download items available"
				TitleDownload.new.deleteDownloadedContents(client)
				client.sleep(2000)
				TitleDownload.new.getTargetContent(client)
			end
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end
	end

	####################################################
	#Function Name: deleteDownloadedContents
	#Activity: Function for deleting existing downloaded items
	#Param: object
	####################################################

	def deleteDownloadedContents(client)

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @ダウンロード作品を削除機能"

		begin			
			if client.isElementFound("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='download_indicator'])[1]")
				puts "::MSG:: Download items need to delete"

				ditems = client.getAllValues("NATIVE", "xpath=(//*[@id='recycler_view']/*/*/*[@id='download_indicator'])", "id")
				cnt = ditems.length
				puts "Current contents item is #{cnt}"
				begin
					client.sleep(3000)
					client.click("NATIVE", "xpath=(//*[@id='recycler_view']/*/*[@id='delete_button'])", 0, 1)
					client.sleep(2000)
					if client.isElementFound("NATIVE", "xpath=//*[@text='中止する']")
						client.click("NATIVE", "xpath=//*[@text='中止する']", 0, 1)
					elsif client.isElementFound("NATIVE", "xpath=//*[@text='はい']")
						client.click("NATIVE", "xpath=//*[@text='はい']", 0, 1)
					end
					cnt += 1
				end until cnt == 0
			end
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred while deleting downlaoded items" + e.message	
		end
	end

	####################################################
	#Target Device: iOS
	#Function Name: testSingleDownload
	#Activity: Function for downloading single content
	#Param: object
	####################################################

	def ios_testSingleDownload(client)
		client.sleep(2000)
		client.setDevice("ios_app:autoIpad")

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST SINGLE DOWNLOAD@単話ダウンロード機能"

		$totalTest = $totalTest + 1

		client.sleep(2000)
		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				TitleDownload.new.ios_checkDownloadStatus(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)
				TitleDownload.new.ios_checkDownloadStatus(client)
			end
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@class='UNextMobile_Protected.UNTitleListHeaderView']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='戻る' and ./preceding-sibling::*[@accessibilityLabel='']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIControl']", 0, 1)
			client.sleep(1000)
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end			

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc12 = ($obj_epsdp.ios_testSVODEpisodePlay(client))		

		iosrt10 = RegressionTestInfo.new
		iosrt10.execution_time = $obj_utili.getTime
		iosrt10.test_device = "iOS" 
		iosrt10.testcase_num = 10
		iosrt10.testcase_summary = "単話ダウンロード機能"
		iosrt10.test_result = $result
		iosrt10.capture_url = $captureURL
		iosrt10.err_message = $errMsgDwnld
		iosrt10.comment = ""

		return iosrt10
	end

	####################################################
	#Function Name: ios_checkDownloadStatus
	#Activity: Function for getting download status
	#Param: object
	####################################################

	def ios_checkDownloadStatus(client)

		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ダウンロード済み']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=ダウンロード済みの作品がありません")
				puts "::MSG:: Empty download list"
				TitleDownload.new.ios_getTargetContent(client)
				client.sleep(10000)
			else
				puts "::MSG:: Download items available"
				TitleDownload.new.ios_deleteDownloadedContents(client)
				client.sleep(2000)
				TitleDownload.new.ios_getTargetContent(client)
			end
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred while finding ELEMENT " + e.message
		end		
	end	

	####################################################
	#Function Name: ios_getTargetContent
	#Activity: Function for downloading a content
	#Param: object
	####################################################

	def ios_getTargetContent(client)
		
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button back']]", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNDrawerCellbackgroundView' and ./preceding-sibling::*[@text='ホーム']]", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='button search']]", 0, 1)		
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='キッズ一覧']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='えほん']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "accessibilityLabel=見放題", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.ThumbPlayButton' and ./parent::*[@class='UITableViewCellContentView']]", 0, 1)
			client.sleep(3000)

			if client.waitForElement("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNIndicatorView' and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UITableViewCellContentView']]]", 0, 10000)
				#If statement
			end
			if client.isElementFound("NATIVE", "xpath=//*[@accessibilityIdentifier='icon_download_unselect']")
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNIndicatorView' and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UITableViewCellContentView']]]", 0, 1)
				client.sleep(2000)			
				if client.isElementFound("NATIVE", "xpath=//*[@text='ダウンロードを開始します。']")
					client.click("NATIVE", "xpath=//*[@text='OK']", 0, 1)
				end
				client.sleep(10000)
				str0 = client.getTextIn2("NATIVE", "xpath=//*[@class='UITableViewCellContentView' and ./*[@class='UIImageView'] and ./*[@text='ダウンロード']]", 0, "NATIVE", "Inside", 0, 0)
				#str1 = str0.each_char{ |c| str0.delete!(c) if c.ord<48 or c.ord>57 }
				proval = str0.split(//).map {|x| x[/\d+/]}.compact.join("").to_i
				if proval > 1
					puts "::MSG:: ダウンロードを開始しました「Download has started」"
					$result = $resultOK
					$passCount = $passCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
				else
					puts "::MSG:: ダウンロードを失敗しました!!!「Downloading failed, Check status」"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result	
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
				end
			end
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred during Download operation..: " + e.message
			$result = $resultNG
			$failCount = $failCount + 1
			$finishedTest = $finishedTest + 1
			puts "Result is -> " + $result	
			puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
		end
	end

	####################################################
	#Function Name: ios_deleteDownloadedContents
	#Activity: Function for deleting downloaded items
	#Param: object
	####################################################

	def ios_deleteDownloadedContents(client)

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST @ダウンロード作品を削除機能"

		begin			
			if client.isElementFound("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNIndicatorView' and ./parent::*[@class='UNextMobile_Protected.PlayIndicator' and ./parent::*[@class='UNextMobile_Protected.ThumbPlayButton' and @onScreen='true']]][1]")
				puts "::MSG:: Download items need to delete"
				client.click("NATIVE", "xpath=//*[@text='編集']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='すべて削除']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='はい']", 0, 1)
				client.sleep(2000)
			end
		rescue Exception => e
			$errMsgDwnld = "::MSG:: Exception occurrred while deleting downlaoded items" + e.message	
		end		
	end
end