#!/usr/bin/env

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・進捗率をパース機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class Utility

	@read_flag = nil
	@CONFIG_FILE_PATH = nil
 
	attr_accessor :progress, :key_progress

	####################################################
	#Function Name: initialize
	#Activity: Function for initializing variable
	#Param: 
	####################################################

	def initialize
		@CONFIG_FILE_PATH = "C:\\Jenkins\\workspace\\U-Next_SMP_App_Test\\input.txt"
		@key_progress = "progress"
	end

	####################################################
	#Function Name: setProgressValue
	#Activity: Function for witing progress ratio
	#Param: objects
	####################################################
	
	def setProgressValue(key, value)

		if key == @key_progress
			@progress = value
		end

		if @progress == nil
			@progress = ""
		end
		
		begin
			contents = @key_progress + ":" + @progress
			File.open(@CONFIG_FILE_PATH, "w") do |file|
				file.puts(contents)
			end
		rescue IOError => e
			puts e
		end
	end

	####################################################
	#Function Name: calculateRatio
	#Activity: Function for witing progress ratio
	#Param: objects
	####################################################

	def calculateRatio(finishedtc)

		@ftc_val = finishedtc
		if $tcCountFlag == false
			@totalTC = $total_tc + 1
		else
			@totalTC = $total_tc
		end

		#if $mark == true
			rat_val = ((@ftc_val - 1) * 100 ) / @totalTC #$tcs #$totalTest
		#else
		#	rat_val = (@ftc_val * 100 ) / @totalTC #$tcs #$totalTest
		#end

		begin
			puts "Progress ratio : #{rat_val}%"
			case rat_val
				when 0
					setProgressValue("progress", "0")
				when 1..10
					setProgressValue("progress", "10")
				when 11..20
					setProgressValue("progress", "20")
				when 21..30
					setProgressValue("progress", "30")
				when 31..40
					setProgressValue("progress", "40")
				when 41..50
					setProgressValue("progress", "50")
				when 51..60
					setProgressValue("progress", "60")
				when 61..70
					setProgressValue("progress", "70")
				when 71..80
					setProgressValue("progress", "80")
				when 81..90
					setProgressValue("progress", "90")
				when 91..99
					setProgressValue("progress", "99")
				when 100
					setProgressValue("progress", "100")
			else
				setProgressValue("progress", "100")
				puts "Can not update progress ratio!!!"
			end
		rescue Exception => e
			puts "::MSG:: Exception occurrred while updating progress ratio" + e.message
		end			
	end

	####################################################
	#Function Name: getTime
	#Activity: Function for getting current time
	#Param: objects
	####################################################

	def getTime

		$exeTime = Time.new.strftime("%Y-%m-%d %H:%M:%S")
		return $exeTime
	end

	####################################################
	#Function Name: andConnectingWifi
	#Activity: Function for settings Wi-Fi Connection
	#Param: objects
	####################################################

	def andConnectingWifi(client, dtype, dname, wifis)		

		@dtype = dtype
		@dname = dname
		@wifis = wifis

		puts "Wifi Value is : #{@wifis}"
		begin
			if @dtype == "android"
				client.setDevice("#{dname}")
				if @wifis == "st"
					client.run("am start -n com.android.settings/.wifi.WifiSettings")
					client.sleep(7000)
					if client.swipeWhileNotFound2("Down", 500, 1500, "NATIVE", "xpath=//*[@text='QA-ST']", 0, 3000, 5, true)
						client.sleep(3000)
						if client.isElementFound("NATIVE", "xpath=//*[@text='接続されました']", 0)
							puts "::MSG:: 既に接続しました「 Already connected to ST environment"
							client.click("NATIVE", "xpath=//*[@text='完了']", 0, 1)
							client.sleep(2000)
							client.sendText("{HOME}")
							client.sleep(2000)
						else
							if client.isElementFound("NATIVE", "xpath=//*[@id='password']", 0)
							    client.elementSendText("NATIVE", "xpath=//*[@id='password']", 0, "unexttest")
							    client.sleep(2000)
							end
							if client.isElementFound("NATIVE", "xpath=//*[@text='接続']", 0)
								client.click("NATIVE", "xpath=//*[@text='接続']", 0, 1)
								client.sleep(2000)
							end
							puts "::MSG:: ST環境に接続しました「 Conencted to ST environment"
							client.sendText("{HOME}")
							client.sleep(2000)
						end
					end
				elsif @wifis == "hb"
					client.run("am start -n com.android.settings/.wifi.WifiSettings")
					client.sleep(7000)
					if client.swipeWhileNotFound2("Down", 500, 1500, "NATIVE", "xpath=//*[@text='QA2-2G']", 0, 3000, 5, true)
						client.sleep(3000)
						if client.isElementFound("NATIVE", "xpath=//*[@text='接続されました']", 0)
							puts "::MSG:: 既に接続しました「 Already connected to Main environment"
							client.click("NATIVE", "xpath=//*[@text='完了']", 0, 1)
							client.sleep(2000)
							client.sendText("{HOME}")
							client.sleep(2000)
						else					
							if client.isElementFound("NATIVE", "xpath=//*[@id='password']", 0)
							    client.elementSendText("NATIVE", "xpath=//*[@id='password']", 0, "unexttest")
							    client.sleep(2000)
							end
							if client.isElementFound("NATIVE", "xpath=//*[@text='接続']", 0)
								client.click("NATIVE", "xpath=//*[@text='接続']", 0, 1)
								client.sleep(2000)
							end
							puts "::MSG:: 本番環境に接続しました「 Conencted to Main environment"
							client.sendText("{HOME}")
							client.sleep(2000)
						end
					end
				else
					puts "::MSG:: 特にWi-ftを選択していません、本番での実施を行います「 No Wifi has been selected, Test will be executed on Honban Env!!!"
				end
			elsif @dtype == "ios"
				client.setDevice("ios_app:#{dname}")
				client.launch("com.apple.Preferences", true, true)
				client.sleep(3000)
				if @wifis == "st"
					client.click("NATIVE", "xpath=//*[@text='Wi-Fi' and @x=118]", 0, 1)
					client.sleep(3000)
					if client.isElementFound("NATIVE", "xpath=//*[@text='QA-ST' and @x>700 and @y<400]", 0)
						puts "::MSG:: 既に接続しました「 Already connected to ST environment"		
					else		
						#if client.swipeWhileNotFound2("Down", 500, 2000, "NATIVE", "xpath=//*[@text='QA-ST']", 0, 5000, 5, true)
						client.sleep(7000)
						client.longClick("NATIVE", "xpath=//*[@text='QA-ST' and @x>700 and @y>400]", 0, 1, 0, 0)
						client.sleep(3000)
						if client.isElementFound("NATIVE", "xpath=//*[@text='このネットワーク設定を削除' and ./parent::*[@text='このネットワーク設定を削除']]", 0)
							puts "::MSG:: 既に接続しました「 Already connected to ST environment"
							client.sleep(2000)
							client.sendText("{HOME}")
						else
							if client.isElementFound("NATIVE", "xpath=//*[@text='パスワード' and ./parent::*[@text='パスワード' and ./parent::*[@text='パスワード']]]", 0)
								client.elementSendText("NATIVE", "xpath=//*[@text='パスワード' and ./parent::*[@text='パスワード' and ./parent::*[@text='パスワード']]]", 0, "unexttest")
								client.sleep(2000)
							end
							if client.isElementFound("NATIVE", "xpath=//*[@text='接続']", 0)
								client.click("NATIVE", "xpath=//*[@text='接続']", 0, 1)
								client.sleep(2000)
							end
							puts "::MSG:: ST環境に接続しました「 Conencted to ST environment"
							client.sendText("{HOME}")
						end
						#end
					end
				elsif @wifis == "hb"
					client.click("NATIVE", "xpath=//*[@text='Wi-Fi' and @x=118]", 0, 1)
					client.sleep(3000)
					if client.isElementFound("NATIVE", "xpath=//*[@text='QA2-2G' and @x>700 and @y<400]", 0)
						puts "::MSG:: 既に接続しました「 Already connected to Main environment"
						client.sleep(3000)
					else
						#if client.swipeWhileNotFound2("Down", 500, 2000, "NATIVE", "xpath=//*[@text='QA2-2G']", 0, 5000, 5, true)
						client.sleep(7000)
						client.longClick("NATIVE", "xpath=//*[@text='QA2-2G' and @x>700 and @y>400]", 0, 1, 0, 0)
						client.sleep(3000)
						if client.isElementFound("NATIVE", "xpath=//*[@text='このネットワーク設定を削除' and ./parent::*[@text='このネットワーク設定を削除']]", 0)
							puts "::MSG:: 既に接続しました「 Already connected to Main environment"
							client.sleep(2000)
						else
							if client.isElementFound("NATIVE", "xpath=//*[@text='パスワード' and ./parent::*[@text='パスワード' and ./parent::*[@text='パスワード']]]", 0)
								client.elementSendText("NATIVE", "xpath=//*[@text='パスワード' and ./parent::*[@text='パスワード' and ./parent::*[@text='パスワード']]]", 0, "unexttest")
								client.sleep(2000)
							end
							if client.isElementFound("NATIVE", "xpath=//*[@text='接続']", 0)
								client.click("NATIVE", "xpath=//*[@text='接続']", 0, 1)
								client.sleep(2000)
							end
							puts "::MSG:: 本番環境に接続しました「 Conencted to Main environment"
							client.sendText("{HOME}")
						end
						#end
					end
				else
					puts "::MSG:: Wrong parameter value for Wifi settings!!!Please check"	
				end	
			else
				puts "::MSG:: Wrong parameter value for Device!!!Please check"
			end
		rescue Exception => e
			puts "::MSG:: Exception occurred while setting Wi-Fi"
		end					
	end

	####################################################
	#Function Name: getFileName
	#Activity: Function to get target File name
	#Param: objects
	####################################################

	def getFileName

		path = "C:\\automation_builds\\ios\\dev\\BuildArtifacts\\UNextMobile-iOS-AdHoc-CI\\"
		Dir.chdir("#{path}")
		file = Dir.glob("*.ipa").max_by {|f| File.mtime(f)}
		return file
	end

	def supportLoggedOut(client)
		begin
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='設定・サポート']", 0, 1)
			client.sleep(2000)
			if client.isElementFound("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0)
				client.click("NATIVE", "xpath=//*[@accessibilityLabel='ログアウト']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "xpath=//*[@text='ログアウト' and @class='UIButtonLabel']", 0, 1)
				client.sleep(2000)
			end
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgLogot = "::MSG:: Exception occurrred, could not logout..: " + e.message
		end	
	end
end