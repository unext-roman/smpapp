#!/usr/bin/ruby
# encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・アプリをインストール機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class InstallApps

	####################################################
	#Target Device: Android
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def testInstallApps(client, build)
		client.sleep(2000)
		
		@build = build
		@and_dev_build_path = ""
		@and_rel_build_path = ""
		@flag = false

		puts "BUILD VAL IS : #{@build}"

		if @build == "dev"
			last_upd_file = Dir.glob("#{@and_dev_build_path}*.apk").max_by {|f| File.mtime(f)}
			puts "LAST UPDATED FILE IS : #{last_upd_file}"
			@flag = true
		elsif @build == "rel"
			last_upd_file = Dir.glob("#{@and_rel_build_path}*.apk").max_by {|f| File.mtime(f)}
			puts "LAST UPDATED FILE IS : #{last_upd_file}"
			@flag = true
		else
			@flag = false
			puts "::MSG:: Not a vaild value for Brunch selection. Continue test with currently installed build!"
		end
		if @flag == true
			client.install2("#{last_upd_file}", true, false)
		end	
		client.sleep(2000)
		client.launch("jp.unext.mediaplayer/jp.co.unext.unextmobile.MainActivity", true, false)
		client.sleep(3000)
		if client.isElementFound("NATIVE", "xpath=//*[@text='スキップ']", 0)
			client.click("NATIVE", "xpath=//*[@text='スキップ']", 0, 1)
			client.sleep(4000)
			for i in 0..2
				client.sleep(10000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='アイコンをタップしてテレビで見よう']", 0) == true
					client.click("NATIVE", "xpath=//*[@text='OK']", 0, 1)
					break
				end
			end
			client.sleep(10000)
		end
		if client.isElementFound("NATIVE", "xpath=//*[@text='いつでもどこでも｡']", 0) && client.isElementFound("NATIVE", "xpath=//*[@text='TV､PC､スマホ､タブレットなど']", 0)
			client.swipe2("Right", 50, 500)
			client.sleep(3000)
			client.swipe2("Right", 50, 500)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='洋画']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='海外ドラマ']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='次へ']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='完了']", 0, 1)
			client.sleep(2000)
			for i in 0..2
				client.sleep(10000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='アイコンをタップしてテレビで見よう']", 0) == true
					client.click("NATIVE", "xpath=//*[@text='OK']", 0, 1)
					break
				end
			end	
			client.sleep(10000)
		end
	end

	####################################################
	#Target Device: Android
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def ios_testInstallApps(client, build)
		client.sleep(2000)
		
		@build = build
		@ios_dev_build_path = "C:/automation_builds/ios/dev/BuildArtifacts/UNextMobile-iOS-AdHoc-CI/"
		@ios_rel_build_path = "C:/automation_builds/ios/dev/BuildArtifacts/UNextMobile-iOS-AdHoc-CI/" #currently RELEASE build is not covered by CI 

		@flag = false

		puts "BUILD VAL IS : #{@build}"

		if @build == "dev"
			last_upd_file = Dir.glob("#{@ios_dev_build_path}*.ipa").max_by {|f| File.mtime(f)}
			puts "::MSG:: LAST UPDATED FILE IS : #{last_upd_file}"
			@flag = true
		elsif @build == "rel"
			last_upd_file = Dir.glob("#{@ios_rel_build_path}*.ipa").max_by {|f| File.mtime(f)}
			puts "::MSG:: LAST UPDATED FILE IS : #{last_upd_file}"
			@flag = true
		else
			@flag = false
			puts "::MSG:: Not a vaild value for Brunch selection. Continue test with currently installed build!"
		end
		if @flag == true
			client.install2("#{last_upd_file}", true, false)
		end	
		client.sleep(2000)
		client.launch("jp.unext.mediaplayer", true, false)
		client.sleep(4000)
		if client.isElementFound("NATIVE", "xpath=//*[@text='スキップ']", 0)
			client.click("NATIVE", "xpath=//*[@text='スキップ']", 0, 1)
			for i in 0..2
				client.sleep(5000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='アイコンをタップして\nテレビで見よう']", 0) == true
					client.click("NATIVE", "xpath=//*[@accessibilityLabel='cast off']", 0, 1)
					break
				end
			end
			client.sleep(10000)
		end
		if client.isElementFound("WEB", "xpath=//*[@nodeName='IMG' and @height>400 and @width>1500]", 0)
			puts "Found Whats new screen"
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(5000)
		end
		if client.isElementFound("NATIVE", "xpath=//*[@text='いつでもどこでも']", 0) && client.isElementFound("NATIVE", "xpath=//*[@text='様々なデバイスで視聴ができます']", 0)
			client.swipe2("Right", 300, 500)
			client.sleep(3000)
			client.swipe2("Right", 300, 500)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='洋画']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='海外ドラマ']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='次へ']", 0, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@text='完了']", 0, 1)
			client.sleep(2000)
			for i in 0..2
				client.sleep(5000)
				if client.isElementFound("NATIVE", "xpath=//*[@text='アイコンをタップして\nテレビで見よう']", 0) == true
					client.click("NATIVE", "xpath=//*[@accessibilityLabel='cast off']", 0, 1)
					break
				end
			end		
			client.sleep(10000)
		end

		if client.isElementFound("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0) == false
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='cast off']", 0, 1)
		end
	end	
end