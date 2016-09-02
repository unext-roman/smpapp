#!/usr/bin/ruby

#############################################################################
# �ۑ� : �X�}�z�A�v��������A�e�X�g�̎�����
# ���W���[�� : ���J���@�\�E���O�C������@�\
# �J���� : Roman Ahmed
# �R�s�[���C�g : U-NEXT Co. Ltd.
# �o�[�W���� : v1.0
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
		puts "::MSG::[ANDROID] STARTING TEST @���O�C��"
		$totalTest = $totalTest + 1

		# Apps startup checking
		if client.isElementFound("NATIVE", "text=�����p�J�n�̑O��")
			puts ($obj_strtp.testStartupCheck(client))
		else
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@contentDescription='��ֈړ�']", 0, 1)
			client.sleep(1000)
			client.click("NATIVE", "text=�ݒ�E�T�|�[�g", 0, 1)
			client.sleep(2000)

			if client.isElementFound("NATIVE", "text=���O�A�E�g", 0)
				$comment = "::MSG:: ���Ƀ��O�C���ς�!!! ���ʂ�OK�ɂ���"
				$finishedTest = $finishedTest + 1
				##$tc3 = ($obj_snglp.testSinglePlay(client))
			else
				client.elementListSelect("", "text=���O�C��", 0, false)
				client.click("NATIVE", "text=���O�C��", 0, 1)
				client.click("NATIVE", "id=id_edit_text", 0, 1)
				client.sendText(user)
				client.click("NATIVE", "id=password_edit_text", 0, 1)
				client.sendText(pass)
				client.closeKeyboard()
				if client.waitForElement("NATIVE", "text=���O�C��", 0, 10000)
	    			# If statement
				end
				client.click("NATIVE", "id=login_button", 0, 1)
				client.sleep(2000)

				begin
					if client.isElementFound("NATIVE", "xpath=//*[@text='���q�l���̓o�^']")
						client.sleep(1000)
						client.click("NATIVE", "xpath=//*[@contentDescription='��ֈړ�']")
					end
					if client.isElementFound("NATIVE", "text=���O�A�E�g", 0)
						puts "::MSG:: ���O�C���������܂����uLogin successful�v"
						$result = $resultOK
						$passCount = $passCount + 1
						$finishedTest = $finishedTest + 1				
						puts "Result is -> " + $result
						puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"						
					else
						puts "::MSG:: ���O�C�����s���܂����uWrong credentials, Test aborted�v"
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
		andrt2.testcase_summary = "���O�C��"
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
		puts "::MSG::[iOS] STARTING TEST @���O�C��"
		$totalTest = $totalTest + 1

		client.click("NATIVE", "xpath=//*[@class='UNextMobile_Protected.HamburgerButton']", 0, 1)
		client.sleep(2000)
		client.click("NATIVE", "xpath=//*[@text='�ݒ�E�T�|�[�g']", 0, 1)
		client.sleep(2000)

		if client.isElementFound("NATIVE", "text=���O�A�E�g", 0)
			$comment = "::MSG:: ���Ƀ��O�C���ς�!!! ���ʂ�OK�ɂ���"
			client.click("NATIVE", "xpath=//*[@accessibilityIdentifier='player_button_back']", 0, 1)
			client.sleep(2000)
			client.click("NATIVE", "xpath=//*[@text='�z�[��']", 0, 1)
			client.sleep(2000)
		else
			client.click("NATIVE", "xpath=//*[@accessibilityLabel='���O�C��']", 0, 1)
			if client.waitForElement("NATIVE", "class=UITextField", 0, 10000)
	   			# If statement
			end
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='���O�C��ID']]", 0, 1)
			client.sendText(user)
			client.click("NATIVE", "xpath=//*[@class='UITextField' and ./preceding-sibling::*[@text='�p�X���[�h']]", 0, 1)
			client.sendText(pass)
			client.closeKeyboard()
			client.sleep(1000)
			client.click("NATIVE", "xpath=//*[@text='���O�C��' and @class='UIButtonLabel']", 0, 1)
			client.sleep(2000)

			begin
				if client.isElementFound("NATIVE", "text=���O�A�E�g", 0)
					puts "::MSG:: ���O�C���������܂����uLogin successful�v"
					$result = $resultOK
					$passCount = $passCount + 1					
					$finishedTest = $finishedTest + 1
					puts "Result is -> " + $result
					puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"	
				else
					puts "::MSG:: ���O�C�����s���܂����uWrong credentials, Test aborted�v"
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
			client.click("NATIVE", "xpath=//*[@text='�z�[��']", 0, 1)
			client.sleep(2000)
		end

		puts ($obj_utili.calculateRatio($finishedTest))
		$tc3 = ($obj_snglp.ios_testSinglePlay(client))

		iosrt2 = RegressionTestInfo.new
		iosrt2.execution_time = $obj_utili.getTime
		iosrt2.test_device = "iOS"
		iosrt2.testcase_num = 2
		iosrt2.testcase_summary = "���O�C��"
		iosrt2.test_result = $result
		iosrt2.capture_url = $captureURL		
		iosrt2.err_message = $errMsgLogin
		iosrt2.comment = $comment

		return iosrt2
		#puts ($obj_snddb.insertIntoReleaseTestEachFunc($tc2.execution_time, $tc2.testcase_num, $tc2.testcase_summary, $tc2.test_result, $tc2.capture_url, $tc2.err_message, $tc2.comment))	
	end
end