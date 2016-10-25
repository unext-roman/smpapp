#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・作品の評価機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class ItemRatings

	@@comment = ""

	####################################################
	#Target Device: Android
	#Function Name: testEditMylist
	#Activity: Function for editing mylist
	#Param: object
	####################################################

	def testSakuhinRatings(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST ITEM RATINGS@評価機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				ItemRatings.new.updateRatings(client)
			else
				client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動']", 0, 1)
				client.sleep(1000)
				client.click("NATIVE", "text=ホーム", 0, 1)
				client.sleep(2000)
				ItemRatings.new.updateRatings(client)
			end
		rescue Exception => e
			$errMsgRtngs = "::MSG:: Exception occurrred while finding element: " + e.message	
		end	

		puts ($obj_utili.calculateRatio($finishedTest))		
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "ANDROID" 
		@testcase_num = 22
		@testcase_summary = "作品の評価"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgRtngs
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_plfel.testEpisodePlayFromPlayer(client))	
	end

	####################################################
	#Function Name: listEditing
	#Activity: Function for editing history list
	#Param: object
	####################################################

	def updateRatings(client)

		@newrat = 0
		@indx = 0

		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*/*/*/*[@class='android.support.v7.widget.AppCompatImageView' and @width>0 and ./parent::*[@class='android.widget.LinearLayout']])[3]", 0, 1)
				client.sleep(2000)
			else
				client.swipe2("Down", 300, 1000)
				client.sleep(2000)
				client.click("NATIVE", "xpath=(//*[@id='recyclerView']/*/*[@id='maskLayout'])", 7, 1)
				client.sleep(2000)
			end
			client.swipe2("Down", 1000, 100)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@id='ratingView' and ./parent::*[@id='otherView']]", 0, 1)
			client.sleep(2000)
			@curent = ItemRatings.new.getCurrentRating(client)
			puts "Current Rating is: #{@curent}"
			@cval = @curent.to_i
			#calling API, value can be set forcely but as a operation it does not occur.
			#client.runNativeAPICall("NATIVE", "xpath=//*[@id='rate_picker']", 0, "view.setRate(40);")
			if @cval == 0
				@newrat = @cval + 30
			elsif @cval == 10
				@newrat = @cval + 20
			elsif @cval == 20
				@newrat = @cval + 10
			elsif @cval == 30
				@newrat = @cval + 5
			elsif @cval == 40
				@newrat = @cval + 5
			elsif @cval == 50
				@newrat = @cval - 40
			end
			case @newrat
			when 0..10
				@indx = 0
			when 11..20
				@indx = 1
			when 21..30
				@indx = 2
			when 31..40
				@indx = 3
			when 41..50
				@indx = 4
			end
			client.click("NATIVE", "xpath=(//*[@id='rate_picker']/*[@class='android.widget.ImageView'])", @indx, 1)	
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@id='ratingView' and ./parent::*[@id='otherView']]", 0, 1)
			client.sleep(1000)
			@updrat = ItemRatings.new.getCurrentRating(client)
			@uval = @updrat.to_i
			puts "Updated rating is: #{@uval}"
			client.click("NATIVE", "text=キャンセル", 0, 1)
			client.sleep(2000)

			if @uval != @cval
				@@comment = "::MSG:: 無事に評価設定しました「User ratings operaton was done successfully」"					
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			else
				$errMsgRtngs = "評価設定時に問題が発生しました「Issue occurred while setting user ratings」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult	
			end
			client.click("NATIVE", "xpath=//*[@contentDescription='上へ移動' and ./preceding-sibling::*[@class='android.widget.FrameLayout']]", 0, 1)
		rescue Exception => e
			$errMsgRtngs = "::MSG:: Exception occurrred while updating ratings: " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def getCurrentRating(client)
		client.runNativeAPICall("NATIVE", "xpath=//*[@id='rate_picker']", 0, "view.getRate();")
	end

	####################################################
	#Target Device: iOS
	#Function Name: ios_testEditMylist
	#Activity: Function for editing mylist
	#Param: object
	####################################################

	def ios_testSakuhinRatings(client)
		client.sleep(2000)
		
		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST ITEM RATINGS@評価機能"

		$totalTest = $totalTest + 1 

		begin
			client.sleep(2000)
			if client.isElementFound("NATIVE", "text=つづきを再生")
				ItemRatings.new.iupdateRatings(client)
			else
				client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
				client.sleep(2000)
				client.click("NATIVE", "xpath=//*[@text='ホーム']", 0, 1)
				client.sleep(2000)				
				ItemRatings.new.iupdateRatings(client)
			end
		rescue Exception => e
			$errMsgRtngs = "::MSG:: Exception occurrred while finding element: " + e.message	
		end	

		puts ($obj_utili.calculateRatio($finishedTest))		
		
		if $execution_time == nil
			@exetime = $execution_time
		else
			@exetime = $execution_time
		end
		@test_device = "iOS" 
		@testcase_num = 22
		@testcase_summary = "作品の評価"
		@test_result = $result
		@capture_url = $captureURL
		@err_message = $errMsgRtngs
		@comment = @@comment

		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))
		#puts ($obj_logot.ios_testEpisodePlayFromPlayer(client))			
	end

	####################################################
	#Function Name: listEditing
	#Activity: Function for editing history list
	#Param: object
	####################################################

	def iupdateRatings(client)

		@newrat = 0
		@indx = 0

		begin
			if client.isElementFound("NATIVE", "text=つづきを再生")
				#client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@class='UIView'] and @accessibilityIdentifier='viewing_tilte_button.png']", 0, 1)
				client.click("NATIVE", "xpath=//*[@class='UIImageView' and @onScreen='true' and @top='true' and ./parent::*[@class='UIView']]", 0, 1)			
				client.sleep(2000)
			else
				#this line will be changed for iPhone or need to be optimized
				client.click("NATIVE", "xpath=(//*[@class='UICollectionView' and ./preceding-sibling::*[@class='UIView']]/*/*/*[@class='UNextMobile_Protected.UNAsyncImageView' and ./parent::*[@class='UIView' and ./following-sibling::*[@height>0]]])", 9, 1)
				client.sleep(2000)
			end
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNRatingView' and ./parent::*[@class='UIView']]", 0, 1)
			client.sleep(2000)
			@curent = ItemRatings.new.getiCurrentRating(client)
			puts "Current Rating is: #{@curent}"
			@cval = @curent.to_i
			case @cval
			when 0
				@indx = 4
			when 1
				@indx = 3
			when 2
				@indx = 4
			when 3
				@indx = 0
			when 4
				@indx = 1
			when 5
				@indx = 2
			end
			client.click("NATIVE", "xpath=(//*[@class='UNextMobile_Protected.UNRatingControl']/*/*[@class='UIImageView' and @width>0 and @height>0])", @indx, 1)
			client.sleep(3000)
			client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNRatingView' and ./parent::*[@class='UIView']]", 0, 1)
			client.sleep(1000)
			@updrat = ItemRatings.new.getiCurrentRating(client)
			@uval = @updrat.to_i
			puts "Updated rating is: #{@uval}"
			client.click("NATIVE", "xpath=//*[@text='キャンセル']", 0, 1)
			client.sleep(2000)

			if @uval != @cval
				@@comment = "::MSG:: 無事に評価設定しました「User ratings operaton was done successfully」"					
				$obj_rtnrs.returnOK
				$obj_rtnrs.printResult
			else
				$errMsgRtngs = "評価設定時に問題が発生しました「Issue occurred while setting user ratings」"
				$obj_rtnrs.returnNG
				$obj_rtnrs.printResult
			end
			client.click("NATIVE", "xpath=//*[@class='UIImageView' and @height>0 and ./parent::*[@accessibilityLabel='main nav close']]", 0, 1)
			client.sleep(2000)
		rescue Exception => e
			$errMsgRtngs = "::MSG:: Exception occurrred while updating ratings: " + e.message
			$obj_rtnrs.returnNG
		end
	end

	def getiCurrentRating(client)
		client.runNativeAPICall("NATIVE", "xpath=//*[@class='UNextMobile_Protected.UNRatingControl']", 0, "invokeMethod:'{\"selector\":\"rate\",\"arguments\":[]}'")
	end
end