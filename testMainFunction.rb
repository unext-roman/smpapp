#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : Main メソッド
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "Client.rb"
load "constItems.rb"
load "releaseTest_info.rb"
load "utilitiesFunc.rb"
load "funcLogin.rb"
load "funcLogout.rb"
load "funcSinglePlay.rb"
load "funcContinuePlay.rb"
load "funcBuyPPV.rb"
load "funcPurchasedPlay.rb"
load "funcHistoryPlay.rb"
load "funcMylistPlay.rb"
load "funcSendToDB.rb"

	host = ARGV[0]
	port = ARGV[1]

	# Create client using defaults or using hostname and port number
	client = Mobile::Client.new(host, port, true)
	client.setProjectBaseDirectory("/Users/admin/workspace/PR_Regression")

	$obj_login = Login.new
	$obj_snddb = SendResultsToDB.new
		
	#individual test
	#$obj_mylst = MyList.new


	####################################################
	#Module: Calling test functions
	#Activity: Perform main operation
	#Param: 
	####################################################

	def unextTestPrgm

		puts "**********************************************************************"
		puts "**"
		puts "*    ||       ||     ||\\    || ||======= \\   //  ==========			"
		puts "*    ||       ||     || \\   || ||         \\ //       ||				"
		puts "*    ||       ||=====||  \\  || ||=======   \\/        ||				"
		puts "*    ||       ||     ||   \\ || ||          //\\       ||				"
		puts "*     =========      ||    \\|| ||=======  //  \\      ||				"
		puts "*																		"
		puts "*			AUTOMATION SYSTEM											"
		puts "*			  v 1.0														"
		puts "**********************************************************************"

		puts "Enter how many TCs to be executed?"
		$tcs = gets.chomp.to_i
	end

	unextTestPrgm
	#$exeTime = Time.new
	# Calling Main function
	#for i in 1..5
	#	if i % 2 == 0		  	

		  	#puts ($obj_utili.setProgressValue("progress", "30"))
		  	
		  	#puts "::MSG:: Execution starting time : #{$obj_utili.getTime}"

		  	#foo = ($obj_login.testLogin(client,"roman","qatest1"))

			#puts "==================================================================================="
		  	#puts "TEST RESULTS SENT TO DB"
		  	#puts "==================================================================================="

		  	#puts "Result : TESTCASE 2"
			#puts "#{foo.execution_time}, #{foo.test_device}, #{foo.testcase_num}, #{foo.testcase_summary}, #{foo.test_result}, #{foo.err_message}, #{foo.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc(foo.execution_time, foo.testcase_num, foo.testcase_summary, foo.test_result, foo.capture_url, foo.err_message, foo.comment))
	
			#puts "Result : TESTCASE 3"
			#puts "#{$foo1.test_device}, #{$foo1.testcase_num}, #{$foo1.testcase_summary}, #{$foo1.test_result}, #{$foo1.err_message}, #{$foo1.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc($foo1.execution_time, $foo1.testcase_num, $foo1.testcase_summary, $foo1.test_result, $foo1.capture_url, $foo1.err_message, $foo1.comment))

			#puts "Result : TESTCASE 5"
			#puts "#{$foo3.test_device}, #{$foo3.testcase_num}, #{$foo3.testcase_summary}, #{$foo3.test_result}, #{$foo3.err_message}, #{$foo3.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc($foo3.execution_time, $foo3.testcase_num, $foo3.testcase_summary, $foo3.test_result, $foo3.capture_url, $foo3.err_message, $foo3.comment))

			#puts "Result : TESTCASE 6"
			#puts "#{$foo4.test_device}, #{$foo4.testcase_num}, #{$foo4.testcase_summary}, #{$foo4.test_result}, #{$foo4.err_message}, #{$foo4.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc($foo4.execution_time, $foo4.testcase_num, $foo4.testcase_summary, $foo4.test_result, $foo4.capture_url, $foo4.err_message, $foo4.comment))

			#puts "Result : TESTCASE 7"
			#puts "#{$foo5.test_device}, #{$foo5.testcase_num}, #{$foo5.testcase_summary}, #{$foo5.test_result}, #{$foo5.err_message}, #{$foo5.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc($foo5.execution_time, $foo5.testcase_num, $foo5.testcase_summary, $foo5.test_result, $foo5.capture_url, $foo5.err_message, $foo5.comment))

			#puts "Result : TESTCASE 4"
			#puts "#{$foo2.test_device}, #{$foo2.testcase_num}, #{$foo2.testcase_summary}, #{$foo2.test_result}, #{$foo2.err_message}, #{$foo2.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc($foo2.execution_time, $foo2.testcase_num, $foo2.testcase_summary, $foo2.test_result, $foo2.capture_url, $foo2.err_message, $foo2.comment))

			#puts "Result : TESTCASE 8"
			#puts "#{$foo6.test_device}, #{$foo6.testcase_num}, #{$foo6.testcase_summary}, #{$foo6.test_result}, #{$foo6.err_message}, #{$foo6.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc($foo6.execution_time, $foo6.testcase_num, $foo6.testcase_summary, $foo6.test_result, $foo6.capture_url, $foo6.err_message, $foo6.comment))

			#puts "Result : TESTCASE 9"
			#puts "#{$foo7.test_device}, #{$foo7.testcase_num}, #{$foo7.testcase_summary}, #{$foo7.test_result}, #{$foo7.err_message}, #{$foo7.comment}"
			#puts ($obj_snddb.insertIntoReleaseTestEachFunc($foo7.execution_time, $foo7.testcase_num, $foo7.testcase_summary, $foo7.test_result, $foo7.capture_url, $foo7.err_message, $foo7.comment))


			#puts (testHistoryPlay(client))
			#puts (testBuyingPPV(client))
			#puts ($obj_mylst.testMylistContent(client))

	#	else
	#		puts (testLogin(client,"roman","qatest"))
	#		puts (testEnd(client))
	#	end
	#	puts "Loop count is #{i}"	
	#end
	#puts (testSinglePlay(client))
	#puts (testLogout(client))