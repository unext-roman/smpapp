#!/usr/bin/env

#############################################################################
# 課題 : スマホアプリ向け回帰テストの自動化
# モジュール : ロカル機能・選択してテスト実施ロジック
# 開発者 : Roman Ahmed
# コピーライト : U-NEXT Co. Ltd.
# バージョン : v1.0
#############################################################################

class SelectiveTest

	####################################################
	#Target Device: Android
	#Function Name: 
	#Activity: Perform selective test
	####################################################
	
	def andSelectiveTests(client, logid, passw, ttype, tcsno)

		@logid = logid
		@passw = passw
		@ttype = ttype
		@tcsno = tcsno

		if @ttype == "select"
			if @tcsno == "0"
				puts "::MSG:: 単品テストの為に該当テストパターンが選択されていません!!!"
			else
				x = @tcsno.split ","
				cnt = x.length
				for i in 0..cnt - 1
					if x[i] == "2"
						puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))
						puts ($obj_utili.calculateRatio($finishedTest))
					elsif x[i] == "3"
						if $execFlag == false							
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))
							if $loginFlag == true
								puts ($obj_snglp.testSinglePlay(client))
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end
						else
							if $loginFlag == true
								puts ($obj_snglp.testSinglePlay(client))
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end
						end
					elsif x[i] == "4"
						if $execFlag == false							
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))
							if $loginFlag == true
								puts ($obj_logot.testLogout(client))	
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end
						else
							if $loginFlag == true
								puts ($obj_logot.testLogout(client))
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end	
					elsif x[i] == "5"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))	
							if $loginFlag == true
								puts ($obj_contp.testContinuePlay(client))	
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end
						else
							if $loginFlag == true
								puts ($obj_contp.testContinuePlay(client))
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "6"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_buypv.testBuyingPPV(client))								#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_buypv.testBuyingPPV(client))								#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end
						end
					elsif x[i] == "7"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_histp.testHistoryPlay(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_histp.testHistoryPlay(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "8"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_prcsp.testPurchasedItemPlay(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_prcsp.testPurchasedItemPlay(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end
						end
					elsif x[i] == "9"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_mylst.testMylistContent(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_mylst.testMylistContent(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "10"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_dwnld.testSingleDownload(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_dwnld.testSingleDownload(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "11"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_epsdp.testSVODEpisodePlay(client))						#OK (no comment msg)
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_epsdp.testSVODEpisodePlay(client))						#OK (no comment msg)
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "12"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_keysh.testKeywordSearch(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_keysh.testKeywordSearch(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "13"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_gener.testGenericSearch(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_gener.testGenericSearch(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "14"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_fltrs.testFilterSearch(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_fltrs.testFilterSearch(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "15"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_dwnpl.testDownloadPlay(client))							#OK	
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_dwnpl.testDownloadPlay(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
	
					elsif x[i] == "16"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_adtml.testAddtoMylist(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_adtml.testAddtoMylist(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "17"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_lnbck.testLeanbackOperation(client))					#PENDING
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_lnbck.testLeanbackOperation(client))					#PENDING
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "18"
						if $execFlag == false
							puts "TEST: NOT AVAILABLE"
							#puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							#if $loginFlag == true
							#	Call target TC:NIY
							#else
							#	SelectiveTest.new.authFailedMsg
							#end	
						else
							if $loginFlag == true
								puts "TEST: NOT AVAILABLE"
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "19"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_edith.testEditHistoryList(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_edith.testEditHistoryList(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "20"
						if $execFlag == false
							$ratioFlag = false							
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK	
							if $loginFlag == true
								puts ($obj_editd.testEditDownloadList(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end							
						else
							if $loginFlag == true
								puts ($obj_editd.testEditDownloadList(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "21"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_editm.testEditFavoriteList(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_editm.testEditFavoriteList(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "22"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_rtngs.testSakuhinRatings(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_rtngs.testSakuhinRatings(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end			
						end
					elsif x[i] == "23"
						if $execFlag == false
							puts "TEST: NOT AVAILABLE"
							#puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							#if $loginFlag == true
							#	Call target TC:NIY
							#else
							#	SelectiveTest.new.authFailedMsg
							#end
						else
							if $loginFlag == true
								puts "TEST: NOT AVAILABLE"
							else
								SelectiveTest.new.authFailedMsg
							end			
						end
					elsif x[i] == "24"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_plfel.testEpisodePlayFromPlayer(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_plfel.testEpisodePlayFromPlayer(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "25"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_chnjf.testChangingJifukiFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_chnjf.testChangingJifukiFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "26"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_vqual.testVQualityFromPlayer(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_vqual.testVQualityFromPlayer(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "27"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_trick.testTrickPlayFromPlayer(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_trick.testTrickPlayFromPlayer(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "28"
						if $execFlag == false
							puts "TEST: NOT AVAILABLE"
							#puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							#if $loginFlag == true
							#	Call target TC:NIY
							#else
							#	SelectiveTest.new.authFailedMsg
							#end
						else
							if $loginFlag == true
								puts "TEST: NOT AVAILABLE"
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "29"
						if $execFlag == false
							puts "TEST: NOT AVAILABLE"
							#puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							#if $loginFlag == true
							#	Call target TC:NIY
							#else
							#	SelectiveTest.new.authFailedMsg
							#end
						else
							if $loginFlag == true
								puts "TEST: NOT AVAILABLE"
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "30"
						if $execFlag == false
							puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))			#OK
							if $loginFlag == true
								puts ($obj_ccast.testConnectingCast(client))						#OK	
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_ccast.testConnectingCast(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "36"
						puts ($obj_plwlg.testPlayWithoutLogin(client, "roman", "qatest1"))	#OK		
						puts ($obj_utili.calculateRatio($finishedTest))				
					elsif x[i] == "37"
						puts ($obj_dlwlg.testDownloadWithoutLogin(client, "roman", "qatest1"))			#OK		
						puts ($obj_utili.calculateRatio($finishedTest))				
					else
						puts "::MSG:: Nothing to execute"
					end
				end
			end
		else
			puts ($obj_login.testLogin(client,"#{@logid}","#{@passw}"))					#OK
			if $loginFlag == true
				puts ($obj_snglp.testSinglePlay(client))										#OK
				puts ($obj_contp.testContinuePlay(client))										#OK
				puts ($obj_buypv.testBuyingPPV(client))										#OK
				puts ($obj_histp.testHistoryPlay(client))										#OK
				puts ($obj_utili.calculateRatio($finishedTest))
				puts ($obj_prcsp.testPurchasedItemPlay(client))								#OK
				puts ($obj_mylst.testMylistContent(client))									#OK
				puts ($obj_dwnld.testSingleDownload(client))									#OK	
				puts ($obj_epsdp.testSVODEpisodePlay(client))									#OK (no comment msg)
				puts ($obj_keysh.testKeywordSearch(client))									#OK
				puts ($obj_gener.testGenericSearch(client))									#OK
				puts ($obj_fltrs.testFilterSearch(client))										#OK
				puts ($obj_dwnpl.testDownloadPlay(client))										#OK	
				puts ($obj_adtml.testAddtoMylist(client))										#OK
				puts ($obj_lnbck.testLeanbackOperation(client))								#PENDING
				puts ($obj_edith.testEditHistoryList(client))									#OK
				puts ($obj_editd.testEditDownloadList(client))									#OK
				puts ($obj_editm.testEditFavoriteList(client))									#OK
				puts ($obj_utili.calculateRatio($finishedTest))
				puts ($obj_rtngs.testSakuhinRatings(client))									#OK
				puts ($obj_plfel.testEpisodePlayFromPlayer(client))							#OK
				puts ($obj_chnjf.testChangingJifukiFromPlayer(client))							#OK
				puts ($obj_vqual.testVQualityFromPlayer(client))								#OK
				puts ($obj_trick.testTrickPlayFromPlayer(client))								#OK
				puts ($obj_ccast.testConnectingCast(client))									#OK	
				puts ($obj_logot.testLogout(client))											#OK
				puts ($obj_plwlg.testPlayWithoutLogin(client, "roman", "qatest1"))				#OK
				puts ($obj_dlwlg.testDownloadWithoutLogin(client, "roman", "qatest1"))			#OK
				puts ($obj_utili.calculateRatio($finishedTest))
			else
				SelectiveTest.new.authFailedMsg
			end
		end		
	end

	####################################################
	#Target Device: iOS
	#Function Name: 
	#Activity: Perform selective test
	####################################################

	def iosSelectiveTests(client, logid, passw, ttype, tcsno)

		@logid = logid
		@passw = passw
		@ttype = ttype
		@tcsno = tcsno

		if @ttype == "select"
			if @tcsno == "0"
				puts "::MSG:: 単品テストの為に該当テストパターンが選択されていません!!!"
			else
				x = @tcsno.split ","
				cnt = x.length
				for i in 0..cnt - 1
					if x[i] == "2"
						puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
						puts ($obj_utili.calculateRatio($finishedTest))
					elsif x[i] == "3"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))	#OK
							if $loginFlag == true
								puts ($obj_snglp.ios_testSinglePlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts "TEST: SVOD PLAY"
								puts ($obj_snglp.ios_testSinglePlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "4"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_logot.ios_testLogout(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_logot.ios_testLogout(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "5"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_contp.ios_testContinuePlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_contp.ios_testContinuePlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "6"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_buypv.ios_testBuyingPPV(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_buypv.ios_testBuyingPPV(client))							#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "7"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_histp.ios_testHistoryPlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_histp.ios_testHistoryPlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "8"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_prcsp.ios_testPurchasedItemPlay(client))				#OK	
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end			
						else
							if $loginFlag == true
								puts ($obj_prcsp.ios_testPurchasedItemPlay(client))				#OK		
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end		
					elsif x[i] == "9"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_mylst.ios_testMylistContent(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_mylst.ios_testMylistContent(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end			
						end
					elsif x[i] == "10"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_dwnld.ios_testSingleDownload(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_dwnld.ios_testSingleDownload(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "11"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_epsdp.ios_testSVODEpisodePlay(client))					#OK (no comment msg)
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_epsdp.ios_testSVODEpisodePlay(client))					#OK (no comment msg)
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "12"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_keysh.ios_testKeywordSearch(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_keysh.ios_testKeywordSearch(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "13"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_gener.ios_testGenericSearch(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_gener.ios_testGenericSearch(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "14"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_fltrs.ios_testFilterSearch(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_fltrs.ios_testFilterSearch(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "15"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_dwnpl.ios_testDownloadPlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_dwnpl.ios_testDownloadPlay(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end	
					elsif x[i] == "16"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_adtml.ios_testAddtoMylist(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_adtml.ios_testAddtoMylist(client))						#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "17"
						if $execFlag == false
							puts "TEST: NOT AVAILABLE"							
						else
							if $loginFlag == true
								puts "TEST: NOT AVAILABLE"
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "19"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_edith.ios_testEditHistoryList(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_edith.ios_testEditHistoryList(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "20"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_editd.ios_testEditDownloadList(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_editd.ios_testEditDownloadList(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "21"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_editm.ios_testEditFavoriteList(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_editm.ios_testEditFavoriteList(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "22"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_rtngs.ios_testSakuhinRatings(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_rtngs.ios_testSakuhinRatings(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "23"
						if $execFlag == false
							puts "TEST: NOT AVAILABLE"							
						else
							if $loginFlag == true
								puts "TEST: NIY"
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "24"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_plfel.ios_testEpisodePlayFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_plfel.ios_testEpisodePlayFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "25"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_chnjf.ios_testChangingJifukiFromPlayer(client))			#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end	
						else
							if $loginFlag == true
								puts ($obj_chnjf.ios_testChangingJifukiFromPlayer(client))			#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "26"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_vqual.ios_testVQualityFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_vqual.ios_testVQualityFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end		
						end
					elsif x[i] == "27"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_trick.ios_testTrickPlayFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_trick.ios_testTrickPlayFromPlayer(client))				#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "31"
						if $execFlag == false
							puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))		#OK
							if $loginFlag == true
								puts ($obj_ccast.ios_testConnectingCast(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest - 1))
							else
								SelectiveTest.new.authFailedMsg
							end		
						else
							if $loginFlag == true
								puts ($obj_ccast.ios_testConnectingCast(client))					#OK
								puts ($obj_utili.calculateRatio($finishedTest))
							else
								SelectiveTest.new.authFailedMsg
							end	
						end
					elsif x[i] == "36"
						puts ($obj_plwlg.ios_testPlayWithoutLogin(client, "qa00001", "qatest1"))		#OK		
						puts ($obj_utili.calculateRatio($finishedTest))				
					elsif x[i] == "37"
						puts ($obj_dlwlg.ios_testDownloadWithoutLogin(client, "qa00001", "qatest1"))	#PENDING
						puts ($obj_utili.calculateRatio($finishedTest))
					else
						puts "::MSG:: Nothing to execute"
					end
				end
			end
		else
			puts ($obj_login.ios_testLogin(client,"#{@logid}","#{@passw}"))				#OK
			if $loginFlag == true				
				puts ($obj_snglp.ios_testSinglePlay(client))									#OK
				puts ($obj_contp.ios_testContinuePlay(client))									#OK
				puts ($obj_buypv.ios_testBuyingPPV(client))									#OK
				puts ($obj_histp.ios_testHistoryPlay(client))									#OK
				puts ($obj_utili.calculateRatio($finishedTest))
				puts ($obj_prcsp.ios_testPurchasedItemPlay(client))							#OK	
				puts ($obj_mylst.ios_testMylistContent(client))								#OK
				puts ($obj_mylst.ios_testMylistContent(client))								#OK
				puts ($obj_dwnld.ios_testSingleDownload(client))								#OK	
				puts ($obj_dwnpl.ios_testDownloadPlay(client))									#OK
				puts ($obj_epsdp.ios_testSVODEpisodePlay(client))								#OK (no comment msg)
				puts ($obj_keysh.ios_testKeywordSearch(client))								#OK
				puts ($obj_gener.ios_testGenericSearch(client))								#OK
				puts ($obj_fltrs.ios_testFilterSearch(client))									#OK
				puts ($obj_adtml.ios_testAddtoMylist(client))									#OK
				puts ($obj_edith.ios_testEditHistoryList(client))								#OK	
				puts ($obj_utili.calculateRatio($finishedTest))
				puts ($obj_editd.ios_testEditDownloadList(client))								#OK
				puts ($obj_editm.ios_testEditFavoriteList(client))								#OK
				puts ($obj_rtngs.ios_testSakuhinRatings(client))								#OK
				puts ($obj_plfel.ios_testEpisodePlayFromPlayer(client))						#OK
				puts ($obj_chnjf.ios_testChangingJifukiFromPlayer(client))						#OK
				puts ($obj_vqual.ios_testVQualityFromPlayer(client))							#OK
				puts ($obj_trick.ios_testTrickPlayFromPlayer(client))							#OK
				puts ($obj_ccast.ios_testConnectingCast(client))								#OK
				puts ($obj_logot.ios_testLogout(client))										#OK
				puts ($obj_plwlg.ios_testPlayWithoutLogin(client, "qa00001", "qatest1"))		#OK
				puts ($obj_dlwlg.ios_testDownloadWithoutLogin(client, "qa00001", "qatest1"))	#PENDING
				puts ($obj_utili.calculateRatio($finishedTest))
			else
				SelectiveTest.new.authFailedMsg
			end
		end		
	end

	def checkFlagValue(flag)
		$loginFlag = flag
	end

	def checkExecStatus(flag)
		$execFlag = flag
	end

	def authFailedMsg
		puts ""
		puts "::注意::"
		puts "::MSG:: ユーザー認証ができませんでしたので、テストが進めません。ユーザーID/PWをご確認ください。"
		puts ""
	end
end