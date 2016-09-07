#!/usr/bin/env

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・進捗率をパース機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "Client.rb"
load "constItems.rb"

class Utility

	@read_flag = nil
	@CONFIG_FILE_PATH = nil
 
	attr_accessor :progress, :key_progress

	def initialize
		@CONFIG_FILE_PATH = "C:\\Jenkins\\workspace\\U-Next_SMP_App_Test\\input.txt"
		#@CONFIG_FILE_PATH = "C:\\Jenkins\\workspace\\U-Next_SMP_App_Test\\input.txt"
		#@CONFIG_FILE_PATH = "/Users/admin/Desktop/auto_scripts/input.txt"
		@key_progress = "progress"
	end

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

	def calculateRatio(finishedTC)

		ftc_val = finishedTC
		rat_val = (ftc_val * 100 ) / 38 #$tcs #$totalTest

		puts "Ratio val : #{rat_val}"
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
			puts "Can not update progress ratio!!!"
		end		
	end

	def getTime

		$exeTime = Time.new.strftime("%Y-%m-%d %H:%M:%S")
		return $exeTime
	end

end
