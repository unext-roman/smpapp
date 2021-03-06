#!/usr/bin/env

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・テスト結果をDBに送信機能
# 開発者 : Kadomura Keito
# 更新者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "connectDB.rb"

class SendResultsToDB < ConnectDB

	attr_accessor = :cycle_key_date, :cycle_key_build_no, :cycle_key_login_id, :cycle_key_device_type, :cycle_key_device_name, :cycle_key_result_ok_count, :cycle_key_result_ng_count, :each_func_key_date, :each_func_key_test_num, :each_func_key_test_summary, :each_func_key_result,  :each_func_key_capture_url, :each_func_key_err_message, :each_func_key_comment

	@table_releasetest_cycle = nil
	@table_releasetest_contents = nil


	def initialize

		super

		@table_releasetest_cycle = "releasetest_cycle"
		@table_releasetest_each_func = "releasetest_each_func"

		@cycle_key_date = "date"
		@cycle_key_build_no = "build_no"
		@cycle_key_login_id = "login_id"
		@cycle_key_device_type = "device_type"
		@cycle_key_device_name = "device_name"
		@cycle_key_result_ok_count = "result_ok_count"
		@cycle_key_result_ng_count = "result_ng_count"

		@each_func_key_date = "date"
		@each_func_key_test_num = "test_num"
		@each_func_key_test_summary = "test_summary"
		@each_func_key_result = "result"
		@each_func_key_capture_url = "capture_url"
		@each_func_key_err_message = "err_message"
		@each_func_key_comment = "comment"
		
	end	

	def createTableReleaseTestCycle

		createTableReleaseTestCycle_sql = <<-RTC
		create table #{@table_releasetest_cycle} (#{@cycle_key_date} varchar(30), #{@cycle_key_build_no} varchar(10), #{@cycle_key_login_id} text, #{@cycle_key_device_type} text, #{@cycle_key_device_name} text, #{@cycle_key_result_ok_count} int, #{@cycle_key_result_ng_count} int); 
		RTC
			sql = createTableReleaseTestCycle_sql.chomp
			unless exitDB?(@table_releasetest_cycle)
				self.query(sql)			
			end		
	end

	def createTableReleaseTestEachFunc

		createTableReleaseTestEachFunc_sql = <<-RTE
		create table #{@table_releasetest_each_func} (#{@each_func_key_date} varchar(30), #{@each_func_key_test_num} int, #{@each_func_key_test_summary} text, #{@each_func_key_result} text, #{@each_func_key_capture_url} text, #{@each_func_key_err_message} text, #{@each_func_key_comment} text);
		RTE
			sql = createTableReleaseTestEachFunc_sql.chomp
			unless exitDB?(@table_releasetest_each_func)
				self.query(sql)			
			end		
	end

	def insertIntoReleaseTestCycle(date, build_no, login_id, device_type, device_name, result_ok_count, result_ng_count)

		SendResultsToDB.new.createTableReleaseTestCycle

		if date == nil || build_no == nil || login_id == nil || device_type == nil || device_name == nil
			#return false
			puts "::MSG:: DB found NULL, results sending unsuccessful"
		end
		begin
			sql = "insert into #{@table_releasetest_cycle} (#{@cycle_key_date}, #{@cycle_key_build_no}, #{@cycle_key_login_id}, #{@cycle_key_device_type}, #{@cycle_key_device_name}, #{@cycle_key_result_ok_count}, #{@cycle_key_result_ng_count}) values ('#{date}','#{build_no}','#{login_id}','#{device_type}','#{device_name}',#{result_ok_count},#{result_ng_count});"
			self.query(sql)
		rescue
			#return false
			puts "::MSG:: Exception occurred while sending all results to DB"
		end
		#return true
		puts "::MSG:: 全結果はDBに送信を成功しました「Full test results have been sent to DB successfully」"
	end

	def insertIntoReleaseTestEachFunc(date, test_num, test_summary, result, capture_url, err_message, comment)

		SendResultsToDB.new.createTableReleaseTestEachFunc

		if date == nil || test_num == nil || test_summary == nil || result == nil
			#return false
			puts "::MSG:: DB found NULL, tc result sending unsuccessful"
		end
		begin
			sql = "insert into #{@table_releasetest_each_func} (#{@each_func_key_date}, #{@each_func_key_test_num}, #{@each_func_key_test_summary}, #{@each_func_key_result}, #{@each_func_key_capture_url}, #{@each_func_key_err_message}, #{@each_func_key_comment}) values ('#{date}','#{test_num}','#{test_summary}','#{result}','#{capture_url}','#{err_message}','#{comment}');"
			self.query(sql)
		rescue
			#return false
			puts "::MSG:: Exception occurred while sending tc result to DB"
		end
		#return true
		puts "::MSG:: TC結果はDBに送信を成功しました「TC result has been sent to DB successfully」"
	end
end
