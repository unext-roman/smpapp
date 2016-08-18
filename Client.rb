#!/usr/bin/ruby -w
require "xmlrpc/client"
require 'securerandom'

module Mobile
	class Client 
		def initialize(host = "127.0.0.1", port = 8889, useSessionID = false)
			@host = host
			@port = port;
			#url = "http://" + host + ":" + port + "/xmlrpc"
			@server = XMLRPC::Client.new(host, "/xmlrpc", port)
			@server.timeout = 300000
      @clientID = nil
      if useSessionID
        @clientID = "clientID:Ruby:version=" + getVersion() + ":" + SecureRandom.hex
      end
		end
				
		
    
    def config(host = "127.0.0.1", port = 8889)
      @host = host
      @port = port;
      #url = "http://" + host + ":" + port + "/xmlrpc"
      @server = XMLRPC::Client.new(host, "/xmlrpc", port)
      @server.timeout = 300000
      #@clientID = "clientID:Ruby:" + SecureRandom.hex
    end
        
        
		def execute(method, *params)
			begin
			  if @clientID.nil?
          result = @server.call("agent." + method, *params)
			  else
          result = @server.call("agent." + method, *(params.insert(0, @clientID)))
			  end
				
				if result == 0
				 return "OK"
				end
				@map = result
				puts @map['logLine']
				if  (@map.include? 'status') and (not @map['status'])
				 puts "Status: False"
				 raise @map['errorMessage']
				end
				return @map
			rescue XMLRPC::FaultException => e
				puts "Error:"
				puts e.faultCode
				puts e.faultString
				raise
			end
		end
		
		def getLastCommandResultMap()
			return @map
		end
		
    def pingServer()
      resultMap = execute("pingServer")
    end
            
	 def waitForDevice(query, timeout)["name"]
             begin
             @duration = Time.now.getutc.to_i + timeout/1000.0
                 while true
                     if Time.now.getutc.to_i > @duration
                         puts "Status: False"
                         self.report("Timeout wait for device", false)
                         raise "Timeout wait for device"
                     end
                      result = execute("lockDevice", query)
                          @resultMap = result
                     if  (@resultMap.include? 'status') and (@resultMap['status'])
                             @port = @resultMap['port']
                             self.config(@host,@port)
                             self.report("wait for " + query, true)
                          self.report(@resultMap['name'] + " was reserved.", true)
                             return @resultMap['name']
                     elsif  (@resultMap.include? 'validXPath') and (not @resultMap['validXPath'])
                         puts "XPath is Invalid"
                         self.report("waitForDevice - XPath is invalid", false);
                         raise "XPath is Invalid"
                     elsif  (@resultMap.include? 'license') and (not @resultMap['license'])
                         puts "License is not supported on this agent"
                         self.report("waitForDevice - License is not supported on this agent", false)
                         raise "License is not supported on this agent"
                     end
                 end
             rescue XMLRPC::FaultException => e
                 puts "Error:"
                 puts e.faultCode
                 puts e.faultString
             end
         end

        def getVersion() "9.7" end

        def addDevice(serialNumber, deviceName)
            return execute("addDevice", serialNumber, deviceName)["name"]
        end

        def applicationClearData(packageName)
            execute("applicationClearData", packageName)
        end

        def applicationClose(packageName)
            return execute("applicationClose", packageName)["found"]
        end

        def capture()
            return execute("capture")["outFile"]
        end

        def captureLine(line="Capture")
            return execute("capture", line)["outFile"]
        end

        def captureElement(name, x, y, width, height, similarity=97)
            execute("captureElement", name, x, y, width, height, similarity)
        end

        def clearAllSms()
            execute("clearAllSms")
        end

        def clearDeviceLog()
            execute("clearDeviceLog")
        end

        def clearLocation()
            execute("clearLocation")
        end

        def click(zone, element, index=0, clickCount=1)
            execute("click", zone, element, index, clickCount)
        end

        def clickOffset(zone, element, index=0, clickCount=1, x=0, y=0)
            execute("click", zone, element, index, clickCount, x, y)
        end

        def clickCoordinate(x=0, y=0, clickCount=1)
            execute("clickCoordinate", x, y, clickCount)
        end

        def clickIn(zone, searchElement, index, direction, clickElement, width=0, height=0)
            execute("clickIn", zone, searchElement, index, direction, clickElement, width, height)
        end

        def clickIn2(zone, searchElement, index, direction, clickElementZone, clickElement, width=0, height=0)
            execute("clickIn", zone, searchElement, index, direction, clickElementZone, clickElement, width, height)
        end

        def clickIn2_5(zone, searchElement, index, direction, clickElementZone, clickElement, width=0, height=0, clickCount=1)
            execute("clickIn", zone, searchElement, index, direction, clickElementZone, clickElement, width, height, clickCount)
        end

        def clickIn3(zone, searchElement, index, direction, clickElementZone, clickElement, clickElementIndex=0, width=0, height=0, clickCount=1)
            execute("clickIn", zone, searchElement, index, direction, clickElementZone, clickElement, clickElementIndex, width, height, clickCount)
        end

        def clickTableCell(zone, headerElement, headerIndex, rowElement, rowIndex=0)
            execute("clickTableCell", zone, headerElement, headerIndex, rowElement, rowIndex)
        end

        def closeDevice()
            execute("closeDevice")
        end

        def closeKeyboard()
            execute("closeKeyboard")
        end

        def collectSupportData(zipDestination, applicationPath, device, scenario, expectedResult, actualResult)
            execute("collectSupportData", zipDestination, applicationPath, device, scenario, expectedResult, actualResult)
        end

        def collectSupportData2(zipDestination, applicationPath, device, scenario, expectedResult, actualResult, withCloudData=true, onlyLatestLogs=true)
            execute("collectSupportData", zipDestination, applicationPath, device, scenario, expectedResult, actualResult, withCloudData, onlyLatestLogs)
        end

        def drag(zone, element, index=0, xOffset=0, yOffset=0)
            execute("drag", zone, element, index, xOffset, yOffset)
        end

        def dragCoordinates(x1=0, y1=0, x2=0, y2=0)
            execute("dragCoordinates", x1, y1, x2, y2)
        end

        def dragCoordinates2(x1=0, y1=0, x2=0, y2=0, time=2000)
            execute("dragCoordinates", x1, y1, x2, y2, time)
        end

        def dragDrop(zone, dragElement, dragIndex, dropElement, dropIndex=0)
            execute("dragDrop", zone, dragElement, dragIndex, dropElement, dropIndex)
        end

        def drop()
            execute("drop")
        end

        def elementGetProperty(zone, element, index, property)
            return execute("elementGetProperty", zone, element, index, property)["text"]
        end

        def elementGetTableRowsCount2(tableLocator, tableIndex=0, visible=false)
            return execute("elementGetTableRowsCount", tableLocator, tableIndex, visible)["count"]
        end

        def elementGetTableRowsCount(zone, tableLocator, tableIndex=0, visible=false)
            return execute("elementGetTableRowsCount", zone, tableLocator, tableIndex, visible)["count"]
        end

        def elementGetTableValue(rowLocator, rowLocatorIndex, columnLocator)
            return execute("elementGetTableValue", rowLocator, rowLocatorIndex, columnLocator)["text"]
        end

        def elementGetText(zone, element, index=0)
            return execute("elementGetText", zone, element, index)["text"]
        end

        def elementListPick(listZone, listLocator, elementZone, elementLocator, index=0, click=true)
            execute("elementListPick", listZone, listLocator, elementZone, elementLocator, index, click)
        end

        def elementListSelect(listLocator, elementLocator, index=0, click=true)
            execute("elementListSelect", listLocator, elementLocator, index, click)
        end

        def elementListVisible(listLocator, elementLocator, index=0)
            return execute("elementListVisible", listLocator, elementLocator, index)["found"]
        end

        def elementScrollToTableRow2(tableLocator, tableIndex=0, rowIndex=0)
            execute("elementScrollToTableRow", tableLocator, tableIndex, rowIndex)
        end

        def elementScrollToTableRow(zone, tableLocator, tableIndex=0, rowIndex=0)
            execute("elementScrollToTableRow", zone, tableLocator, tableIndex, rowIndex)
        end

        def elementSendText(zone, element, index, text)
            execute("elementSendText", zone, element, index, text)
        end

        def elementSetProperty(zone, element, index, property, value)
            return execute("elementSetProperty", zone, element, index, property, value)["text"]
        end

        def elementSwipe(zone, element, index, direction, offset=0, time=2000)
            execute("elementSwipe", zone, element, index, direction, offset, time)
        end

        def elementSwipeWhileNotFound(componentZone, componentElement, direction, offset, swipeTime, elementfindzone, elementtofind, elementtofindindex=0, delay=1000, rounds=5, click=true)
            return execute("elementSwipeWhileNotFound", componentZone, componentElement, direction, offset, swipeTime, elementfindzone, elementtofind, elementtofindindex, delay, rounds, click)["found"]
        end

        def endTransaction(name)
            execute("endTransaction", name)
        end

        def exit()
            execute("exit")
        end

        def extractLanguageFiles(application, directoryPath, allowOverwrite=true)
            execute("extractLanguageFiles", application, directoryPath, allowOverwrite)
        end

        def flick(direction, offset=0)
            execute("flick", direction, offset)
        end

        def flickCoordinate(x, y, direction)
            execute("flickCoordinate", x, y, direction)
        end

        def flickElement(zone, element, index, direction)
            execute("flickElement", zone, element, index, direction)
        end

        def forceTouch(zone, element, index=0, duration=100, force=100, dragDistanceX=0, dragDistanceY=0, dragDuration=1500)
            execute("forceTouch", zone, element, index, duration, force, dragDistanceX, dragDistanceY, dragDuration)
        end

        def generateReport()
            return execute("generateReport")["text"]
        end

        def generateReport2(releaseClient=true)
            return execute("generateReport", releaseClient)["text"]
        end

        def generateReport(releaseClient, propFilePath)
            return execute("generateReport", releaseClient, propFilePath)["text"]
        end

        def getAllSms(timeout=5000)
            return execute("getAllSms", timeout)["textArray"]
        end

        def getAllValues(zone, element, property)
            return execute("getAllValues", zone, element, property)["textArray"]
        end

        def getAllZonesWithElement(element)
            return execute("getAllZonesWithElement", element)["text"]
        end

        def getAvailableAgentPort()
            return execute("getAvailableAgentPort")["port"]
        end

        def getAvailableAgentPort2(featureName)
            return execute("getAvailableAgentPort", featureName)["port"]
        end

        def getConnectedDevices()
            return execute("getConnectedDevices")["text"]
        end

        def getCoordinateColor(x=0, y=0)
            return execute("getCoordinateColor", x, y)["color"]
        end

        def getCounter(counterName)
            return execute("getCounter", counterName)["text"]
        end

        def getCurrentApplicationName()
            return execute("getCurrentApplicationName")["text"]
        end

        def getDefaultTimeout()
            return execute("getDefaultTimeout")["timeout"]
        end

        def getDeviceLog()
            return execute("getDeviceLog")["path"]
        end

        def getDeviceProperty(key)
            return execute("getDeviceProperty", key)["text"]
        end

        def getDevicesInformation()
            return execute("getDevicesInformation")["text"]
        end

        def getElementCount(zone, element)
            return execute("getElementCount", zone, element)["count"]
        end

        def getElementCountIn(zoneName, elementSearch, index, direction, elementCountZone, elementCount, width=0, height=0)
            return execute("getElementCountIn", zoneName, elementSearch, index, direction, elementCountZone, elementCount, width, height)["count"]
        end

        def getInstalledApplications()
            return execute("getInstalledApplications")["text"]
        end

        def getLastSMS(timeout=5000)
            return execute("getLastSMS", timeout)["text"]
        end

        def getMonitorsData(cSVfilepath)
            return execute("getMonitorsData", cSVfilepath)["text"]
        end

        def getPickerValues(zone, pickerElement, index=0, wheelIndex=0)
            return execute("getPickerValues", zone, pickerElement, index, wheelIndex)["textArray"]
        end

        def getPosition(zone, element)
            return execute("getPosition", zone, element)["click"]
        end

        def getPositionWindowRelative(zone, element)
            return execute("getPositionWindowRelative", zone, element)["centerWinRelative"]
        end

        def getProperty(property)
            return execute("getProperty", property)["text"]
        end

        def getTableCellText(zone, headerElement, headerIndex, rowElement, rowIndex=0, width=0, height=0)
            return execute("getTableCellText", zone, headerElement, headerIndex, rowElement, rowIndex, width, height)["text"]
        end

        def getText(zone)
            return execute("getText", zone)["text"]
        end

        def getTextIn(zone, element, index, direction, width=0, height=0)
            return execute("getTextIn", zone, element, index, direction, width, height)["text"]
        end

        def getTextIn2(zone, element, index, textZone, direction, width=0, height=0)
            return execute("getTextIn", zone, element, index, textZone, direction, width, height)["text"]
        end

        def getTextIn3(zone, element, index, textZone, direction, width=0, height=0, xOffset=0, yOffset=0)
            return execute("getTextIn", zone, element, index, textZone, direction, width, height, xOffset, yOffset)["text"]
        end

        def getVisualDump(type="Native")
            return execute("getVisualDump", type)["text"]
        end

        def hybridClearCache(clearCookies=true, clearCache=true)
            resultMap = execute("hybridClearCache", clearCookies, clearCache)
        end

        def hybridGetHtml(webViewLocator, index=0)
            return execute("hybridGetHtml", webViewLocator, index)["text"]
        end

        def hybridRunJavascript(webViewLocator, index, script)
            return execute("hybridRunJavascript", webViewLocator, index, script)["text"]
        end

        def hybridSelect(webViewLocator, index, method, value, select)
            execute("hybridSelect", webViewLocator, index, method, value, select)
        end

        def hybridWaitForPageLoad(timeout=10000)
            execute("hybridWaitForPageLoad", timeout)
        end

        def install(path, sign=false)
            return execute("install", path, sign)["found"]
        end

        def install2(path, instrument=true, keepData=false)
            return execute("install", path, instrument, keepData)["found"]
        end

        def isElementBlank(zone, element, index=0, colorGroups=10)
            return execute("isElementBlank", zone, element, index, colorGroups)["found"]
        end

        def isElementFound2(zone, element)
            return execute("isElementFound", zone, element)["found"]
        end

        def isElementFound(zone, element, index=0)
            return execute("isElementFound", zone, element, index)["found"]
        end

        def isFoundIn(zone, searchElement, index, direction, elementFindZone, elementToFind, width=0, height=0)
            return execute("isFoundIn", zone, searchElement, index, direction, elementFindZone, elementToFind, width, height)["found"]
        end

        def isTextFound(zone, element, ignoreCase)
            return execute("isTextFound", zone, element, ignoreCase)["found"]
        end

        def launch(activityURL, instrument=true, stopIfRunning=false)
            execute("launch", activityURL, instrument, stopIfRunning)
        end

        def listSelect(sendRest, sendNavigation, delay, textToIdentify, color, rounds=5, sendonfind="{ENTER}")
            return execute("listSelect", sendRest, sendNavigation, delay, textToIdentify, color, rounds, sendonfind)["found"]
        end

        def longClick(zone, element, index=0, clickCount=1, x=0, y=0)
            execute("longClick", zone, element, index, clickCount, x, y)
        end

        def maximize()
            execute("maximize")
        end

        def openDevice()
            execute("openDevice")
        end

        def p2cx(percentage=0)
            return execute("p2cx", percentage)["pixel"]
        end

        def p2cy(percentage=0)
            return execute("p2cy", percentage)["pixel"]
        end

        def pinch(inside=true, x=0, y=0, radius=100)
            return execute("pinch", inside, x, y, radius)["found"]
        end

        def portForward(localPort, remotePort)
            return execute("portForward", localPort, remotePort)["port"]
        end

        def pressWhileNotFound(zone, elementtoclick, elementtofind, timeout=10000, delay=0)
            execute("pressWhileNotFound", zone, elementtoclick, elementtofind, timeout, delay)
        end

        def pressWhileNotFound2(zone, elementtoclick, elementtoclickindex, elementtofind, elementtofindindex=0, timeout=10000, delay=0)
            execute("pressWhileNotFound", zone, elementtoclick, elementtoclickindex, elementtofind, elementtofindindex, timeout, delay)
        end

        def reboot(timeout=120000)
            return execute("reboot", timeout)["status"]
        end

        def releaseClient()
            execute("releaseClient")
        end

        def releaseDevice(deviceName, releaseAgent=true, removeFromDeviceList=false, releaseFromCloud=true)
            execute("releaseDevice", deviceName, releaseAgent, removeFromDeviceList, releaseFromCloud)
        end

        def report(message, status)
            execute("report", message, status)
        end

        def reportWithImage(pathToImage, message, status)
            execute("report", pathToImage, message, status)
        end

        def resetDeviceBridge()
            execute("resetDeviceBridge")
        end

        def resetDeviceBridgeOS(deviceType)
            execute("resetDeviceBridge", deviceType)
        end

        def rightClick(zone, element, index=0, clickCount=1, x=0, y=0)
            execute("rightClick", zone, element, index, clickCount, x, y)
        end

        def run(command)
            return execute("run", command)["text"]
        end

        def LayoutTest(xml)
            return execute("runLayoutTest", xml)["text"]
        end

        def runNativeAPICall(zone, element, index, script)
            return execute("runNativeAPICall", zone, element, index, script)["text"]
        end

        def sendText(text)
            execute("sendText", text)
        end

        def sendWhileNotFound(toSend, zone, elementtofind, timeout=10000, delay=1000)
            execute("sendWhileNotFound", toSend, zone, elementtofind, timeout, delay)
        end

        def sendWhileNotFound2(toSend, zone, elementtofind, elementtofindindex=0, timeout=10000, delay=1000)
            execute("sendWhileNotFound", toSend, zone, elementtofind, elementtofindindex, timeout, delay)
        end

        def setApplicationTitle(title)
            execute("setApplicationTitle", title)
        end

        def setAuthenticationReply(reply="Success", delay=0)
            execute("setAuthenticationReply", reply, delay)
        end

        def setDefaultClickDownTime(downTime=100)
            execute("setDefaultClickDownTime", downTime)
        end

        def setDefaultTimeout(newTimeout=20000)
            return execute("setDefaultTimeout", newTimeout)["timeout"]
        end

        def setDefaultWebView(webViewLocator)
            execute("setDefaultWebView", webViewLocator)
        end

        def setDevice(device)
            execute("setDevice", device)
        end

        def setDragStartDelay(delay=0)
            execute("setDragStartDelay", delay)
        end

        def setInKeyDelay(delay=50)
            execute("setInKeyDelay", delay)
        end

        def setKeyToKeyDelay(delay=50)
            execute("setKeyToKeyDelay", delay)
        end

        def setLanguage(language)
            execute("setLanguage", language)
        end

        def setLanguagePropertiesFile(propertiesfile)
            execute("setLanguagePropertiesFile", propertiesfile)
        end

        def setLocation(latitude="0.0", longitude="0.0")
            execute("setLocation", latitude, longitude)
        end

        def setMonitorPollingInterval(timemilli=30000)
            execute("setMonitorPollingInterval", timemilli)
        end

        def setMonitorTestState(testStatus)
            execute("setMonitorTestState", testStatus)
        end

        def setNetworkConditions(profile)
            execute("setNetworkConditions", profile)
        end

        def setNetworkConditions2(profile, duration=0)
            execute("setNetworkConditions", profile, duration)
        end

        def setOcrIgnoreCase(ignoreCase)
            execute("setOcrIgnoreCase", ignoreCase)
        end

        def setOcrTrainingFilePath(trainingPath)
            execute("setOcrTrainingFilePath", trainingPath)
        end

        def setProjectBaseDirectory(projectBaseDirectory)
            execute("setProjectBaseDirectory", projectBaseDirectory)
        end

        def setProperty(key, value)
            execute("setProperty", key, value)
        end

        def setRedToBlue(redToBlue)
            execute("setRedToBlue", redToBlue)
        end

        def setReporter(reporterName, directory)
            return execute("setReporter", reporterName, directory)["text"]
        end

        def setReporter2(reporterName, directory, testName)
            return execute("setReporter", reporterName, directory, testName)["text"]
        end

        def setShowImageAsLink(showImageAsLink)
            execute("setShowImageAsLink", showImageAsLink)
        end

        def setShowImageInReport(showImageInReport=true)
            execute("setShowImageInReport", showImageInReport)
        end

        def setShowPassImageInReport(showPassImageInReport=true)
            execute("setShowPassImageInReport", showPassImageInReport)
        end

        def setShowReport(showReport=true)
            execute("setShowReport", showReport)
        end

        def setSpeed(speed)
            execute("setSpeed", speed)
        end

        def setWebAutoScroll(autoScroll=true)
            execute("setWebAutoScroll", autoScroll)
        end

        def setWindowSize(width=0, height=0)
            execute("setWindowSize", width, height)
        end

        def shake()
            execute("shake")
        end

        def simulateCapture(picturePath)
            execute("simulateCapture", picturePath)
        end

        def sleep(time=1000)
            execute("sleep", time)
        end

        def somethingLong(n1, n2)
            execute("somethingLong", n1, n2)
        end

        def startAudioPlay(audioFile)
            execute("startAudioPlay", audioFile)
        end

        def startAudioRecording(audioFile)
            execute("startAudioRecording", audioFile)
        end

        def startCall(skypeUser, skypePassword, number, duration=0)
            execute("startCall", skypeUser, skypePassword, number, duration)
        end

        def startLoggingDevice(path)
            execute("startLoggingDevice", path)
        end

        def startMonitor(packageName)
            execute("startMonitor", packageName)
        end

        def startStepsGroup(caption)
            execute("startStepsGroup", caption)
        end

        def startTransaction(name)
            execute("startTransaction", name)
        end

        def startVideoRecord()
            execute("startVideoRecord")
        end

        def stopAudioRecording()
            execute("stopAudioRecording")
        end

        def stopLoggingDevice()
            execute("stopLoggingDevice")
        end

        def stopStepsGroup()
            execute("stopStepsGroup")
        end

        def stopVideoRecord()
            execute("stopVideoRecord")
        end

        def swipe(direction, offset=0)
            execute("swipe", direction, offset)
        end

        def swipe2(direction, offset=0, time=500)
            execute("swipe", direction, offset, time)
        end

        def swipeWhileNotFound(direction, offset, zone, elementtofind, delay=1000, rounds=5, click=true)
            return execute("swipeWhileNotFound", direction, offset, zone, elementtofind, delay, rounds, click)["found"]
        end

        def swipeWhileNotFound3(direction, offset, swipeTime, zone, elementtofind, delay=1000, rounds=5, click=true)
            return execute("swipeWhileNotFound", direction, offset, swipeTime, zone, elementtofind, delay, rounds, click)["found"]
        end

        def swipeWhileNotFound2(direction, offset, swipeTime, zone, elementtofind, elementtofindindex=0, delay=1000, rounds=5, click=true)
            return execute("swipeWhileNotFound", direction, offset, swipeTime, zone, elementtofind, elementtofindindex, delay, rounds, click)["found"]
        end

        def sync(silentTime=2000, sensitivity=0, timeout=10000)
            return execute("sync", silentTime, sensitivity, timeout)["found"]
        end

        def syncElements(silentTime=2000, timeout=10000)
            return execute("syncElements", silentTime, timeout)["found"]
        end

        def textFilter(color, sensitivity=15)
            execute("textFilter", color, sensitivity)
        end

        def uninstall(application)
            return execute("uninstall", application)["found"]
        end

        def verifyElementFound(zone, element, index=0)
            resultMap = execute("verifyElementFound", zone, element, index)
        end

        def verifyElementNotFound(zone, element, index=0)
            resultMap = execute("verifyElementNotFound", zone, element, index)
        end

        def verifyIn(zone, searchElement, index, direction, elementFindZone, elementToFind, width=0, height=0)
            resultMap = execute("verifyIn", zone, searchElement, index, direction, elementFindZone, elementToFind, width, height)
        end

        def waitForAudioPlayEnd(timeout)
            execute("waitForAudioPlayEnd", timeout)
        end

        def waitForElement(zone, element, index=0, timeout=10000)
            return execute("waitForElement", zone, element, index, timeout)["found"]
        end

        def waitForElementToVanish(zone, element, index=0, timeout=10000)
            return execute("waitForElementToVanish", zone, element, index, timeout)["found"]
        end

        def waitForWindow(name, timeout=10000)
            return execute("waitForWindow", name, timeout)["found"]
        end


	end
end
