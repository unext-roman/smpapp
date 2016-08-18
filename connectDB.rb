#!/usr/bin/env

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・DB接続機能
# 開発者 : Kadomura Keito
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################
require 'rubygems'
require 'mysql'

class ConnectDB

	attr_accessor :host_name, :user_name, :password, :db_name

	def initialize

		@host_name  = "10.4.137.16"
		@user_name = "unext"
		@password = "unext1"
		@db_name = "auto"

	end

	def exitDB?(table_name)
		sql = "show tables from " + @db_name + " like '%" + table_name + "%';"
		db = nil
		result = false
		begin
			db = Mysql.new(@host_name, @user_name, @password, @db_name)
			rows = db.query(sql)
			rows.each do |table|
				if table.include?(table_name)
					result = true
				end
			end
		rescue => e
			puts e
		end
		if db != nil
			db.close
		end
		return result
	end

	def query(sql)
		db = nil
		result = nil

		begin
			db = Mysql.new(@host_name, @user_name, @password, @db_name)
			result = db.query(sql)
		rescue => e
			puts e
		end
		if db != nil
			db.close
		end
		return result
	end
end
