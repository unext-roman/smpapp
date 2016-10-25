#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・キャスト接続・切断機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class ConnectChromecast

	@@cres = []
	@@flag = ""
	@@play = 20000
	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testConnectingCast
	#Activity: Function for connecting a chromecast
	#Param: object
	####################################################

	def testConnectingCast(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST CONNECTING A CHROMECAST@キャスト接続・切断機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				ConnectChromecast.new.castOperation(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				ConnectChromecast.new.castOperation(client)
			end
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while finding element: " + e.message
			$obj_rtnrs.returnNG
		end	

		puts ($obj_utili.calculateRatio($finishedTest))		
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 30
		@testcase_summary = "キャスト接続・切断"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgCcast
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_logot.testLogout(client))
	end

	####################################################
	#Function Name: trickPlayOpe
	#Activity: Function for trick operation during playback
	#Param: object
	####################################################

	def castOperation(client)
		
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@contentDescription='Cast button. Disconnected']", 0)
				@@flag = true
				ConnectChromecast.new.connectCast(client)
				ConnectChromecast.new.castPlayback(client)
				ConnectChromecast.new.disconnectCast(client)
			elsif client.isElementFound("NATIVE", "xpath=//*[@contentDescription='Cast button. Connected']", 0)
				@@flag = true
				ConnectChromecast.new.disconnectCast(client)
				ConnectChromecast.new.connectCast(client)
				ConnectChromecast.new.castPlayback(client)
				ConnectChromecast.new.disconnectCast(client)
			else				
				@@flag = false
				@@cres = @@cres.push(false)
				$errMsgCcast = "::MSG:: No chromecast has found, Connect to a chromecast and try again" + e.message				
			end
			if @@cres.include?(false)
				$errMsgCcast = "::MSG:: キャスト操作時に問題が発生しました「Chromecast conencting/disconencting is unsuccessful. Check chromecasr」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "キャスト操作が無事でした「Chromecast conencting/disconencting is successful」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			puts "Result is : #{@@cres}"
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def connectCast(client)

		puts "::MSG::キャスト接続"
		begin
			if @@flag == true
				client.click("NATIVE", "xpath=//*[@contentDescription='Cast button. Disconnected']", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='付近の端末']", 0)
					@@flag = false
					@@cres = @@cres.push(false)
				else
					client.click("NATIVE", "xpath=//*[@id='mr_chooser_route_name']", 0, 1)
					@@flag = true
					client.sleep(3000)
					if client.isElementFound("NATIVE", "xpath=//*[@contentDescription='Cast button. Connected']", 0)
						@@cres = @@cres.push(true)
					else
						@@cres = @@cres.push(false)
					end
				end
			end
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while connecting cast " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def disconnectCast(client)

		puts "::MSG::キャスト切断"
		begin
			if @@flag == true
				client.click("NATIVE", "xpath=//*[@contentDescription='Cast button. Connected']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='キャストを停止']", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@contentDescription='Cast button. Disconnected']", 0)
					@@cres = @@cres.push(true)
					@@flag = false
				else
					@@cres = @@cres.push(false)
				end
			end
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while disconnecting cast " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def castPlayback(client)

		puts "::MSG::キャスト再生"
		begin
			if @@flag == true
				client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='download_indicator'])[3]", 0, 1)
				client.sleep(@@play)

				if client.isElementFound("NATIVE", "xpath=//*[@id='casting']", 0) && client.isElementFound("NATIVE", "xpath=//*[@contentDescription='Cast button. Connected']", 0)
					@@cres = @@cres.push(true)
				else
					@@cres = @@cres.push(false)
				end
			end			
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while casting " + e.message
			$obj_rtnrs.returnNG
		end				
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testConnectingCast
	#Activity: Function for connecting a chromecast
	#Param: object
	####################################################

	def ios_testConnectingCast(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST CONNECTING A CHROMECAST@キャスト接続・切断機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				ConnectChromecast.new.castiOperation(client)
			else	
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				ConnectChromecast.new.castiOperation(client)
			end
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while finding element: " + e.message
			$obj_rtnrs.returnNG
		end	

		puts ($obj_utili.calculateRatio($finishedTest))		
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 30
		@testcase_summary = "キャスト接続・切断"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgCcast
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_logot.testLogout(client))
	end

	####################################################
	#Function Name: trickPlayOpe
	#Activity: Function for trick operation during playback
	#Param: object
	####################################################

	def castiOperation(client)
		
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='cast off' and @hidden='false']", 0)
				@@flag = true
				ConnectChromecast.new.connectiCast(client)
				ConnectChromecast.new.castiPlayback(client)
				ConnectChromecast.new.disconnectiCast(client)
			elsif client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='cast on' and @hidden='false']", 0)
				@@flag = true
				ConnectChromecast.new.disconnectiCast(client)
				ConnectChromecast.new.connectiCast(client)
				ConnectChromecast.new.castiPlayback(client)
				ConnectChromecast.new.disconnectiCast(client)
			else				
				@@flag = false
				@@cres = @@cres.push(false)
			end
			if @@cres.include?(false) && @@flag == false
				$errMsgCcast = "::MSG:: No chromecast has found, Connect to a chromecast and try again"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			elsif @@cres.include?(false)
				$errMsgCcast = "::MSG:: キャスト操作時に問題が発生しました「Chromecast conencting/disconencting is successful」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "キャスト操作が無事でした「Chromecast conencting/disconencting is successful」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			puts "Result is : #{@@cres}"
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def connectiCast(client)

		puts "::MSG::キャスト接続"
		begin
			if @@flag = true
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='cast off']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='荒ぶる和食_rom']", 0, 1)
				client.sleep(3000)
				if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='cast on']", 0)
					@@cres = @@cres.push(true)
				else
					@@cres = @@cres.push(false)
				end
			end
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while connecting cast " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def disconnectiCast(client)

		puts "::MSG::キャスト切断"
		begin
			if client.isElementFound("NATIVE", "xpath=//*[@text='荒ぶる和食_romにキャスト中' and ./parent::*[@class='UIView']]", 0) && client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='cast on' and ./parent::*[./preceding-sibling::*[@accessibilityLabel='Chromecast']]]", 0)
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='cast on' and ./parent::*[./preceding-sibling::*[@accessibilityLabel='Chromecast']]]", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='接続を解除']", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='cast off']", 0)
					@@cres = @@cres.push(true)
				else
					@@cres = @@cres.push(false)
				end
			else
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='cast on']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='接続を解除']", 0, 1)
				client.sleep(2000)
				if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='cast off']", 0)
					@@cres = @@cres.push(true)
				else
					@@cres = @@cres.push(false)
				end				
			end
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while disconnecting cast " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def castiPlayback(client)

		puts "::MSG::キャスト再生"
		begin
			if @@flag == true
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView']", 0, 1)
				client.sleep(@@play)
				if client.isElementFound("NATIVE", "xpath=//*[@text='荒ぶる和食_romにキャスト中' and ./parent::*[@class='UIView']]", 0) && client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='cast on' and ./parent::*[./preceding-sibling::*[@accessibilityLabel='Chromecast']]]", 0)
					@@cres = @@cres.push(true)
				else
					@@cres = @@cres.push(false)
				end
			end			
		rescue Exception => e
			$errMsgCcast = "::MSG:: Exception occurrred while casting " + e.message
			$obj_rtnrs.returnNG
		end				
	end
end