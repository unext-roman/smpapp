#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : 
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "Client.rb"

####################################################
#Module: setupHost
#Activity: Perform host machine IP and Port
#Param: ip, port
####################################################

class SettingHostmachine

	@@port = ""

	def setupPort(port)
		@port = port
	end
end