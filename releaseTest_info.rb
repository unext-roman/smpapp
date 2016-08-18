#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : 内部APIと連携クラス
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class RegressionTestInfo

	attr_accessor :execution_time, :test_device, :testcase_num, :testcase_summary, :test_result, :capture_url, :err_message, :comment

end