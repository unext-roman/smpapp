#!/usr/bin/ruby
#encoding: UTF-8

require 'time'

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・再生中10秒・30秒操作機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class TrickPlayOperation

	@@tres = []
	@@curTime1 = ""
	@@curTime2 = ""
	@@afterTime = ""
	@@beforeTime = ""
	@@flag = ""
	@@timeval = "00:"
	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testEpisodePlayFromPlayer
	#Activity: Function for playing episode form player episode list
	#Param: object
	####################################################

	def testTrickPlayFromPlayer(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST TRICK PLAY FORM PLAYER@再生中10秒・30秒操作動作機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				TrickPlayOperation.new.trickPlayOpe(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				TrickPlayOperation.new.trickPlayOpe(client)
			end
		rescue Exception => e
			$errMsgTrick = "::MSG:: Exception occurrred while finding element: " + e.message
			$obj_rtnrs.returnNG
		end	

		puts ($obj_utili.calculateRatio($finishedTest))		
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 27
		@testcase_summary = "再生中10秒・30秒操作"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgTrick
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_vqual.testOfflineDuringPlayback(client))	
		puts ($obj_logot.testLogout(client))	
	end

	####################################################
	#Function Name: trickPlayOpe
	#Activity: Function for trick operation during playback
	#Param: object
	####################################################

	def trickPlayOpe(client)

		begin
			client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*[@id='download_indicator'])[3]", 0, 1)
			client.sleep(10000)

			for i in 0..2
				TrickPlayOperation.new.thirtySecOperation(client)
				client.sleep(15000)
				TrickPlayOperation.new.tenSecOperation(client)
				client.sleep(10000)
			end
			client.sleep(5000)
			client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
			client.sleep(500)
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)

			if @@tres.include?(false)
				$errMsgTrick = "::MSG:: トリック操作時に問題が発生しました「Trick play operation is unsuccessful」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "トリック操作が無事でした「Trick play operation is successful」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			puts "Result is : #{@@tres}"
		rescue Exception => e
			$errMsgTrick = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def thirtySecOperation(client)
		client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
		@@curTime1 = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)			
		puts "現在の時間 : " + @@curTime1
		if @@curTime1.size < 7
			@@curTime1.prepend("#{@@timeval}")
		end
		cast1 = Time.parse("#{@@curTime1}")

		client.click("NATIVE", "xpath=//*[@id='forward_button']", 0, 1)
		@@afterTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
		puts "30秒操作後の時間 : " + @@afterTime
		#cast2 = @@afterTime.scan(/\d/).join('')
		cast2 = Time.parse("#{@@afterTime}")
		@@flag = "TH"
		TrickPlayOperation.new.checkFlag(@@flag, cast1, cast2)
	end

	def tenSecOperation(client)
		client.click("NATIVE", "xpath=//*[@id='seek_controller']", 0, 1)
		@@curTime2 = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)			
		puts "現在の時間 : " + @@curTime2
		if @@curTime2.size < 7
			@@curTime2.prepend("#{@@timeval}")
		end
		cast1 = Time.parse("#{@@curTime2}")

		client.click("NATIVE", "xpath=//*[@id='rewind_button']", 0, 1)
		@@beforeTime = client.elementGetText("NATIVE", "xpath=//*[@id='time']", 0)
		puts "10秒操作後の時間 : " + @@beforeTime
		cast2 = Time.parse("#{@@beforeTime}")
		@@flag = "TN"
		TrickPlayOperation.new.checkFlag(@@flag, cast1, cast2)
	end

	####################################################
	#Function Name: checkFlag
	#Activity: Check flag and return result
	#Param: object
	####################################################

	def checkFlag(flag, val1, val2)
		@flag = flag
		@curr = val1
		@aftr = val2

		begin
			if @flag == "TH"
				diff1 = @curr - @aftr
				puts "Time difference:flag #{diff1.to_i}:#{@flag}"

				if diff1.to_i >= 30 
					@@tres = @@tres.push(true)
				else
					@@tres = @@tres.push(false)
				end
			elsif @flag == "TN"
				diff2 = @aftr - @curr
				puts "Time difference:flag #{diff2.to_i}:#{@flag}"

				if diff2.to_i >= 9 # during operation 2-3 sec loss happen
					@@tres = @@tres.push(true)
				else
					@@tres = @@tres.push(false)
				end
				puts "Return: #{@@tres}"
			end
		rescue Exception => e
			$errMsgTrick = "::MSG:: Exception occurrred while returning trick results: " + e.message
			$obj_rtnrs.returnNG
		end	
	end

	####################################################
	#Target Device: iOS
	#Function Name: testEpisodePlayFromPlayer
	#Activity: Function for playing episode form player episode list
	#Param: object
	####################################################

	def ios_testTrickPlayFromPlayer(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST TRICK PLAY FORM PLAYER@再生中10秒・30秒操作動作機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				TrickPlayOperation.new.itrickPlayOpe(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				TrickPlayOperation.new.itrickPlayOpe(client)
			end
		rescue Exception => e
			$errMsgTrick = "::MSG:: Exception occurrred while finding element: " + e.message
			$obj_rtnrs.returnNG
		end	

		puts ($obj_utili.calculateRatio($finishedTest))		
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 27
		@testcase_summary = "再生中10秒・30秒操作"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgTrick
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_vqual.ios_testConnectingAirplay(client))	
		puts ($obj_logot.ios_testLogout(client))
	end

	####################################################
	#Function Name: trickPlayOpe
	#Activity: Function for trick operation during playback
	#Param: object
	####################################################

	def itrickPlayOpe(client)

		begin
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.PlayingStateView' and @width>0 and ./parent::*[./parent::*[@class='UIView']]]", 0, 1)
			client.sleep(15000)
			
			for i in 0..2
				TrickPlayOperation.new.ithirtySecOperation(client)
				client.sleep(15000)
				TrickPlayOperation.new.itenSecOperation(client)
				client.sleep(10000)
			end
			client.sleep(5000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			client.sleep(300)
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='navbar button back']]", 0, 1)

			if @@tres.include?(false)
				$errMsgTrick = "::MSG:: トリック操作時に問題が発生しました「Trick play operation is unsuccessful」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			else
				@@comment = "トリック操作が無事でした「Trick play operation is successful」"
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			end
			puts "Result is : #{@@tres}"
		rescue Exception => e
			$errMsgTrick = "::MSG:: Exception occurrred while finding element " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def ithirtySecOperation(client)

		begin	
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)	
			@@curTime1 = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "現在の時間 : " + @@curTime1
			if @@curTime1.size < 7
				@@curTime1.prepend("#{@@timeval}")
			end
			cast1 = Time.parse("#{@@curTime1}")

			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button forward']]", 0, 1)
			@@afterTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "30秒操作後の時間 : " + @@afterTime
			cast2 = Time.parse("#{@@afterTime}")
			@@flag = "TH"
		rescue Exception => e
			$errMsgTrick = "::MSG:: Exception occurrred during 30 sec operation " + e.message
			$obj_rtnrs.returnNG
		end			
		TrickPlayOperation.new.checkFlag(@@flag, cast1, cast2)
	end

	def itenSecOperation(client)
		begin			
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekSlider']", 0, 1)
			@@curTime2 = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "現在の時間 : " + @@curTime2
			if @@curTime1.size < 7
				@@curTime1.prepend("#{@@timeval}")
			end		
			cast1 = Time.parse("#{@@curTime2}")

			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='player button rewind']]", 0, 1)
			@@beforeTime = client.elementGetText("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNSeekControl']/*[@alpha='0.6000000238418579']", 0)
			puts "10秒操作後の時間 : " + @@beforeTime
			cast2 = Time.parse("#{@@beforeTime}")
			@@flag = "TN"
		rescue Exception => e
			$errMsgTrick = "::MSG:: Exception occurrred during 10 sec operation " + e.message
			$obj_rtnrs.returnNG
		end			
		TrickPlayOperation.new.checkFlag(@@flag, cast1, cast2)
	end
end