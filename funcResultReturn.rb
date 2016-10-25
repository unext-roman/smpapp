#!/usr/bin/ruby
#encoding: UTF-8

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・再生中字幕・吹替動作機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class ResultReturn

	def returnNG
		$result = $resultNG
		$failCount = $failCount + 1
		$finishedTest = $finishedTest + 1
	end

	def returnOK
		$result = $resultOK
		$passCount = $passCount + 1
		$finishedTest = $finishedTest + 1
	end

	def printResult
		puts "Result is -> " + $result	
		puts "Pass count is P/T-> #{$passCount} / #{$totalTest}"
	end

	def returnNE
		$result = $resultNE
		$passCount = $passCount + 0
		$failCount = $failCount + 1
		$finishedTest = $finishedTest + 1
	end

	def returnDB
		puts ($obj_snddb.insertIntoReleaseTestEachFunc(@exetime, @testcase_num, @testcase_summary, @test_result, @capture_url, @err_message, @comment))		
	end
end