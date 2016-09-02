#!/usr/bin/ruby

#############################################################################
# $B"s(B?$B!F(B? : ?X?}?z?A?v??????$B"s(B??A?e?X?g????$B!H(B?$B"s(B?
# ???W?$B!D(B?[?? : ???J???@$B!I(B\?E???O?C?$B!H(B?????@$B!I(B\
# ?J$B!I(B??? : Roman Ahmed
# ?R?s?[?$B"s(B?C?g : U-NEXT Co. Ltd.
# ?o?[?W?$B"x(B?$B!H(B : v1.0
#############################################################################

class Login

	####################################################
	#Target Device: Android
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def testLogin(client,user,pass)
		client.sleep(2000)	

		puts ""
		puts ""
		puts "::MSG::[ANDROID] STARTING TEST @ÉçÉOÉCÉì"
		$totalTest = $totalTest + 1

		# Apps startup checking
		if client.isElementFound("NATIVE", "text=Ç≤óòópäJénëOÇ…")
			puts ($obj_strtp.testStartupCheck(client))
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='è„Ç÷à⁄ìÆ']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=ê›íËÅEÉTÉ|Å[Ég", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=ÉçÉOÉAÉEÉg", 0)
				$comment = "::MSG:: $B4{$K%m%0%$%s:Q!*!*!*7k2L$r(BOK$B$K$9$k(B"
				$finishedTest = $finishedTest + 1
			else
				client.elementListSelect("", "text=ÉçÉOÉCÉì", 0, false)
				client.click("NATIVE", "text=ÉçÉOÉCÉì", 0, 1)
				client.click("NATIVE", "id=id_edit_text", 0, 1)
				client.sendText(user)
				client.click("NATIVE", "id=password_edit_text", 0, 1)
				client.sendText(pass)
				client.closeKeyboard()
				if client.waitForElement("NATIVE", "text=ÉçÉOÉCÉì", 0, 10000)
	    			# If statement
				end
				client.click("NATIVE", "id=login_button", 0, 1)
				client.sleep(2000)

				begin
					if client.isElementFound("NATIVE", "xpath=//*[@text='Ç®ãqólèÓïÒÇÃìoò^']")
						client.sleep(1000)
						client.click("NATIVE", "xpath=//*[@contentDescription='è„Ç÷à⁄ìÆ']")
					end
					if client.isElementFound("NATIVE", "text=ÉçÉOÉAÉEÉg", 0)
						puts "::MSG:: $B%m%0%$%s$r@.8y$7$^$7$?!V(BLogin successful$B!W(B"
						$result = $resultOK
						$passCount = $passCount + 1
						$finishedTest = $finishedTest + 1				
						puts "Result is -> " + $result
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"						
					else
						puts "::MSG:: $B%m%0%$%s$r<:GT$7$^$7$?!V(BWrong credentials, Test aborted?$B!W(B"
						$result = $resultNG
						$failCount = $failCount + 1
						$finishedTest = $finishedTest + 1
						puts "Result is -> " + $result
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
					end
				rescue Exception => e
					$errMsgLogin = "::MSG:: Exception occurrred, could not continue test..: " + e.message
				end
			end
		end
		
		puts ($obj_utili.calculateRatio($finishedTest))
		$tc3 = ($obj_snglp.testSinglePlay(client))

		andrt2 = RegressionTestInfo.new
		andrt2.execution_time = $obj_utili.getTime
		andrt2.test_device = "ANDROID" 
		andrt2.testcase_num = 2
		andrt2.testcase_summary = "ÉçÉOÉCÉì"
		andrt2.test_result = $result
		andrt2.capture_url = $captureURL
		andrt2.err_message = $errMsgLogin
		andrt2.comment = $comment

		return andrt2
		client.sleep(5000)
#		puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc2.execution_time, $tc2.testcase_num, $tc2.testcase_summary, $tc2.test_result, $tc2.capture_url, $tc2.err_message, $tc2.comment))		
	end

	####################################################
	#Target Device: iOS
	#Function Name: testLogin
	#Activity: Perform login operation
	#Param: object, username, password
	####################################################

	def ios_testLogin(client, user, pass)
		client.sleep(2000)	

		puts ""
		puts ""
		puts "::MSG::[iOS] STARTING TEST @$B%m%0%$%s(B"
		$totalTest = $totalTest + 1

		client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
		client.sleep(2000)
		client.click("NATIVE", "xpath=//*[@text='?$B@_Dj!&%5%]!<%H(B']", 0, 1)
		client.sleep(2000)

		if client.isElementFound("NATIVE", "text=$B%m%0%"%&%H(B", 0)
			$comment = "::MSG:: $B4{$K%m%0%$%s:Q!*!*!*7k2L$r(BOK$B$K$9$k(B"
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='$B%[!<%`(B']", 0, 1)
			client.sleep(2000)
		else
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='$B%m%0%$%s(B']", 0, 1)
			if client.waitForElement("NATIVE", "class=UITextField", 0, 10000)
	   			# If statement
			end
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='$B%m%0%$%s(BID']]", 0, 1)
			client.sendText(user)
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='$B%Q%9%o!<%I(B']]", 0, 1)
			client.sendText(pass)
			client.closeKeyboard()
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='$B%m%0%$%s(B' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)

			begin
				if client.isElementFound("NATIVE", "text=$B%m%0%"%&%H(B", 0)
					puts "::MSG:: $B%m%0%$%s$r@.8y$7$^$7$?!V(BLogin successful$B!W(B"
					$result = $resultOK
					$passCount = $passCount + 1					
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"	
				else
					puts "::MSG:: $B%m%0%$%s$r<:GT$7$^$7$?!V(BWrong credentials, Test aborted?$B!W(B"
					$result = $resultNG
					$failCount = $failCount + 1
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"	
				end	
			rescue Exception => e
				$errMsg = "::MSG:: Exception occurrred, could not continue test..: #{$e}"
			end
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='$B%[!<%`(B']", 0, 1)
			client.sleep(2000)
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc3 = ($obj_snglp.ios_testSinglePlay(client))

		iosrt2 = RegressionTestInfo.new
		iosrt2.execution_time = $obj_utili.getTime
		iosrt2.test_device = "iOS"
		iosrt2.testcase_num = 2
		iosrt2.testcase_summary = "$B%m%0%$%s(B"
		iosrt2.test_result = $result
		iosrt2.capture_url = $captureURL		
		iosrt2.err_message = $errMsgLogin
		iosrt2.comment = $comment

		return iosrt2
		#puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc2.execution_time, $tc2.testcase_num, $tc2.testcase_summary, $tc2.test_result, $tc2.capture_url, $tc2.err_message, $tc2.comment))	
	end
end