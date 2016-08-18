#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・アプリを終了する機能
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

load "Client.rb"

class Finish

	####################################################
	#Function Name: testEnd
	#Activity: Perform Finishing operation, close apps
	#Param: object
	####################################################

	def testEnd(client)
		client.generateReport2(false);
		# Releases the client so that other clients can approach the agent in the near future. 
		client.releaseClient();
	end
end