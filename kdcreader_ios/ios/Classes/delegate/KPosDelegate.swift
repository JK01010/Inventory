//
//  KPosDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/22/24.
//

import Flutter

class KPosDelegate: KReaderDelegate {
    /* KDC500 Barcode/NFC Methods */
    private let SOFTWARE_TRIGGER_POS = "softwareTriggerPos"
    private let ENABLE_NFC_POS = "enableNFCPos"
    private let DISABLE_NFC_POS = "disableNFCPos"

    /* KDC500 MS/IC Transaction Methods */
    private let ENABLE_MSR_POS = "enableMSRPos"
    private let DISABLE_MSR_POS = "disableMSRPos"
    private let ENABLE_CARD_READER_POS = "enableCardReaderPos"
    private let DISABLE_CARD_READER_POS = "disableCardReaderPos"
    private let READ_CARD_POS = "readCardPos"
    private let CANCEL_READ_CARD_POS = "cancelReadCardPos"
    private let SELECT_EMV_APPLICATION_POS = "selectEMVApplicationPos"
    private let INITIATE_EMV_TRANSACTION_POS = "initiateEMVTransactionPos"
    private let SELECT_APPLICATION_AND_INITIATE_EMV_TRANSACTION_POS = "selectApplicationAndInitiateEMVTransactionPos"
    private let REPLY_EMV_TRANSACTION_POS = "replyEMVTransactionPos"
    private let ENTER_PIN_POS = "enterPINPos"
    private let CANCEL_ENTER_PIN_POS = "cancelEnterPINPos"

    /* KDC500 Configuration Methods */
    private let GET_DEVICE_STATUS_POS = "getDeviceStatusPos"
    private let SET_BEEP_SOUND_POS = "setBeepSoundPos"
    private let GET_BEEP_SOUND_POS = "getBeepSoundPos"
    private let SET_KEYPAD_MENU_ENTRY_POS = "setKeypadMenuEntryPos"
    private let SYNC_DATE_TIME_POS = "syncDateTimePos"
    private let GET_DATE_TIME_POS = "getDateTimePos"
    private let ENABLE_BATTERY_ALARM_POS = "enableBatteryAlarmPos"
    private let DISABLE_BATTERY_ALARM_POS = "disableBatteryAlarmPos"

    /* KDC500 Other Methods */
    private let READ_DATA_POS = "readDataPos"
    private let CANCEL_READ_DATA_POS = "cancelReadDataPos"
    private let FIND_MY_KDC_POS = "findMyKDCPos"
    private let SET_DISPLAY_MESSAGE_POS = "setDisplayMessagePos"
    private let CLEAR_DISPLAY_POS = "clearDisplayPos"
    private let ENABLE_KEYPAD_POS = "enableKeypadPos"
    private let ENABLE_KEYPAD_EVENT_ONLY_POS = "enableKeypadEventOnlyPos"
    private let DISABLE_KEYPAD_POS = "disableKeypadPos"
    private let READ_EMV_CL_CARD_POS = "readEmvCLCardPos"
    private let STOP_EMV_CL_TRANSACTION_POS = "stopEmvCLTransactionPos"
    private let GET_SUPPORTED_LOCALES_POS = "getSupportedLocalesPos"
    private let SET_DISPLAY_MESSAGE_WITH_LOCALE_POS = "setDisplayMessageWithLocalePos"
    private let SET_DISPLAY_MESSAGE_ID_AND_READ_KEYPAD_POS = "setDisplayMessageIdAndReadKeypadPos"
    private let SET_DISPLAY_MESSAGE_AND_READ_KEYPAD_POS = "setDisplayMessageAndReadKeypadPos"
    private let SET_DISPLAY_MESSAGE_AND_SELECT_ITEM_POS = "setDisplayMessageAndSelectItemPos"
    private let CLEAR_DISPLAY_AND_CANCEL_KEYPAD_POS = "clearDisplayAndCancelKeypadPos"

    /* PARAM */
    private let PARAM_NAME_TARGET = "target"
    private let PARAM_NAME_AID = "aid"
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_COUNT = "count"
    private let PARAM_NAME_CLEAR = "clear"
    private let PARAM_NAME_TIMEOUT = "timeout"
    private let PARAM_NAME_PIN_BLOCK_FORMAT = "pinBlockFormat"
    private let PARAM_NAME_MAX_DIGIT = "maxDigit"
    private let PARAM_NAME_TRANS_TYPE = "transType"
    private let PARAM_NAME_AMOUNT = "amount"
    private let PARAM_NAME_OTHER_AMOUNT = "otherAmount"
    private let PARAM_NAME_OPERATION = "operation"
    private let PARAM_NAME_PAN = "pan"
    private let PARAM_NAME_TLV = "tlv"

    private let PARAM_NAME_KEY_VOLUME = "keyVolume"
    private let PARAM_NAME_BEEP_VOLUME = "beepVolume"
    private let PARAM_NAME_BEEP_SOUND = "beepSound"
    private let PARAM_NAME_BEEP_POWER_ON = "beepPowerOn"
    private let PARAM_NAME_BEEP_BARCODE = "beepBarcode"
    private let PARAM_NAME_BEEP_CONNECTION = "beepConnection"
    private let PARAM_NAME_INTERVAL = "interval"
    private let PARAM_NAME_LEVEL = "level"
    private let PARAM_NAME_TITLE_ID = "titleId"
    private let PARAM_NAME_MASK = "mask"
    private let PARAM_NAME_LINE1 = "line1"
    private let PARAM_NAME_LINE2 = "line2"
    private let PARAM_NAME_LINE3 = "line3"
    private let PARAM_NAME_LINE4 = "line4"
    private let PARAM_NAME_LINE = "line"
    private let PARAM_NAME_ONLINE = "online"
    private let PARAM_NAME_LOCALE = "locale"
    private let PARAM_NAME_KEYPAD_TYPE = "keypadType"
    private let PARAM_NAME_INPUT_LINE = "inputLine"
    private let PARAM_NAME_INPUT_ALIGN = "inputAlign"
    private let PARAM_NAME_FIRST_ITEM_LINE = "firstItemLine"
    private let PARAM_NAME_ITEMS = "items"
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
        
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            SOFTWARE_TRIGGER_POS,
            
            ENABLE_NFC_POS,
            DISABLE_NFC_POS,
            
            ENABLE_MSR_POS,
            DISABLE_MSR_POS,
            
            ENABLE_CARD_READER_POS,
            DISABLE_CARD_READER_POS,
            
            READ_CARD_POS,
            CANCEL_READ_CARD_POS,
            
            SELECT_EMV_APPLICATION_POS,
            
            INITIATE_EMV_TRANSACTION_POS,
            
            SELECT_APPLICATION_AND_INITIATE_EMV_TRANSACTION_POS,
            
            REPLY_EMV_TRANSACTION_POS,
            
            ENTER_PIN_POS,
            CANCEL_ENTER_PIN_POS,
            
            GET_DEVICE_STATUS_POS,
            
            SET_BEEP_SOUND_POS,
            GET_BEEP_SOUND_POS,
            
            SET_KEYPAD_MENU_ENTRY_POS,
            
            SYNC_DATE_TIME_POS,
            GET_DATE_TIME_POS,
            
            ENABLE_BATTERY_ALARM_POS,
            DISABLE_BATTERY_ALARM_POS,
            
            READ_DATA_POS,
            CANCEL_READ_DATA_POS,
            
            FIND_MY_KDC_POS,
            
            SET_DISPLAY_MESSAGE_POS,
            CLEAR_DISPLAY_POS,
            
            ENABLE_KEYPAD_POS,
            ENABLE_KEYPAD_EVENT_ONLY_POS,
            DISABLE_KEYPAD_POS,
            
            READ_EMV_CL_CARD_POS,
            STOP_EMV_CL_TRANSACTION_POS,
            
            GET_SUPPORTED_LOCALES_POS,
            
            SET_DISPLAY_MESSAGE_WITH_LOCALE_POS,
            SET_DISPLAY_MESSAGE_ID_AND_READ_KEYPAD_POS,
            SET_DISPLAY_MESSAGE_AND_READ_KEYPAD_POS,
            SET_DISPLAY_MESSAGE_AND_SELECT_ITEM_POS,
            CLEAR_DISPLAY_AND_CANCEL_KEYPAD_POS,
        ]);
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case SOFTWARE_TRIGGER_POS: 
            softwareTriggerPos(call, result: result)

        case ENABLE_NFC_POS: 
            enableNFCPos(call, result: result)
            
        case DISABLE_NFC_POS:
            disableNFCPos(call, result: result)

        case ENABLE_MSR_POS: 
            enableMSRPos(call, result: result)
            
        case DISABLE_MSR_POS:
            disableMSRPos(call, result: result)

        case ENABLE_CARD_READER_POS: 
            enableCardReaderPos(call, result: result)
            
        case DISABLE_CARD_READER_POS:
            disableCardReaderPos(call, result: result)

        case READ_CARD_POS: 
            readCardPos(call, result: result)
            
        case CANCEL_READ_CARD_POS:
            cancelReadCardPos(call, result: result)

        case SELECT_EMV_APPLICATION_POS: 
            selectEmvApplicationPos(call, result: result)
            
        case INITIATE_EMV_TRANSACTION_POS:
            initiateEmvTransactionPos(call, result: result)
            
        case SELECT_APPLICATION_AND_INITIATE_EMV_TRANSACTION_POS:
            selectApplicationAndInitiateEmvTransactionPos(call, result: result)
            
        case REPLY_EMV_TRANSACTION_POS:
            replyEmvTransactionPos(call, result: result)

        case ENTER_PIN_POS: 
            enterPinPos(call, result: result)
            
        case CANCEL_ENTER_PIN_POS:
            cancelEnterPinPos(call, result: result)

        case GET_DEVICE_STATUS_POS: 
            getDeviceStatusPos(call, result: result)

        case SET_BEEP_SOUND_POS: 
            setBeepSoundPos(call, result: result)
            
        case GET_BEEP_SOUND_POS:
            getBeepSoundPos(call, result: result)

        case SET_KEYPAD_MENU_ENTRY_POS: 
            setKeypadMenuEntryPos(call, result: result)

        case SYNC_DATE_TIME_POS: 
            syncDateTimePos(call, result: result)
            
        case GET_DATE_TIME_POS:
            getDateTimePos(call, result: result)

        case ENABLE_BATTERY_ALARM_POS: 
            enableBatteryAlarmPos(call, result: result)
            
        case DISABLE_BATTERY_ALARM_POS:
            disableBatteryAlarmPos(call, result: result)

        case READ_DATA_POS: 
            readDataPos(call, result: result)
            
        case CANCEL_READ_DATA_POS:
            cancelReadDataPos(call, result: result)

        case FIND_MY_KDC_POS: 
            findMyKDCPos(call, result: result)

        case SET_DISPLAY_MESSAGE_POS: 
            setDisplayMessagePos(call, result: result)
            
        case CLEAR_DISPLAY_POS:
            clearDisplayPos(call, result: result)

        case ENABLE_KEYPAD_POS: 
            enableKeypadPos(call, result: result)
            
        case ENABLE_KEYPAD_EVENT_ONLY_POS:
            enableKeypadEventOnlyPos(call, result: result)
            
        case DISABLE_KEYPAD_POS:
            disableKeypadPos(call, result: result)

        case READ_EMV_CL_CARD_POS: 
            readEmvCLCardPos(call, result: result)
            
        case STOP_EMV_CL_TRANSACTION_POS:
            stopEmvCLTransactionPos(call, result: result)

        case GET_SUPPORTED_LOCALES_POS: 
            getSupportedLocales(call, result: result)

        case SET_DISPLAY_MESSAGE_WITH_LOCALE_POS: 
            setDisplayMessageWithLocalePos(call, result: result)
            
        case SET_DISPLAY_MESSAGE_ID_AND_READ_KEYPAD_POS:
            setDisplayMessageIdAndReadKeypadPos(call, result: result)
            
        case SET_DISPLAY_MESSAGE_AND_READ_KEYPAD_POS:
            setDisplayMessageAndReadKeypadPos(call, result: result)
            
        case SET_DISPLAY_MESSAGE_AND_SELECT_ITEM_POS:
            setDisplayMessageAndSelectItemPos(call, result: result)
            
        case CLEAR_DISPLAY_AND_CANCEL_KEYPAD_POS:
            clearDisplayAndCancelKeypadPos(call, result: result)
            
        default:
            break

        }
        return true
    }
    
    private func softwareTriggerPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.softwareTrigger_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }

    private func enableNFCPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.enableNFC_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func disableNFCPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.disableNFC_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func enableMSRPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.enableMSR_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func disableMSRPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.disableMSR_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func enableCardReaderPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let target = args[PARAM_NAME_TARGET] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.enableCardReader_POS(Int16(target))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func disableCardReaderPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let target = args[PARAM_NAME_TARGET] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.disableCardReader_POS(Int16(target))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }

    private func readCardPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let target = args[PARAM_NAME_TARGET] as? Int,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.readCard_POS(Int16(target), timeout: Int16(timeout))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    

    private func cancelReadCardPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let target = args[PARAM_NAME_TARGET] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.cancelReadCard_POS(Int16(target))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func selectEmvApplicationPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let aid = args[PARAM_NAME_AID] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.selectEMVApplication_POS(Int16(aid))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func initiateEmvTransactionPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pinBlockFormat = args[PARAM_NAME_PIN_BLOCK_FORMAT] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let transType = args[PARAM_NAME_TRANS_TYPE] as? Int,
              let amount = args[PARAM_NAME_AMOUNT] as? Int,
              let otherAmount = args[PARAM_NAME_OTHER_AMOUNT] as? Int,
              let operation = args[PARAM_NAME_OPERATION] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.initiateEMVTransaction_POS(Int16(pinBlockFormat), maxDigit: Int16(maxDigit), transType: Int16(transType),
                                                        amount: Int32(amount), otherAmount: Int32(otherAmount), additionalOperation: Int16(operation))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func selectApplicationAndInitiateEmvTransactionPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pinBlockFormat = args[PARAM_NAME_PIN_BLOCK_FORMAT] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let aid = args[PARAM_NAME_AID] as? Int,
              let transType = args[PARAM_NAME_TRANS_TYPE] as? Int,
              let amount = args[PARAM_NAME_AMOUNT] as? Int,
              let otherAmount = args[PARAM_NAME_OTHER_AMOUNT] as? Int,
              let operation = args[PARAM_NAME_OPERATION] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.selectApplicationAndInitiateEMVTransaction_POS(Int16(pinBlockFormat), maxDigit: Int16(maxDigit),
                                                                            aid: Int16(aid), transType: Int16(transType), amount: Int32(amount),
                                                                            otherAmount: Int32(otherAmount), additionalOperation: Int16(operation))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func replyEmvTransactionPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let tlv = args[PARAM_NAME_TLV] as? FlutterStandardTypedData else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
//        let tlvData = NSMutableData(data: tlv.data)
//        let emvTagList = KPOSEMVTagList(tlvs: tlvData.mutableBytes, length: Int16(tlvData.count))
//                
//        let retCode = reader.replyEMVTransaction_POS(emvTagList)
        
        var tlvData = Data(tlv.data)
        
        let emvTagList = tlvData.withUnsafeMutableBytes {
            return KPOSEMVTagList(tlvs: $0.baseAddress, length: Int16($0.count))
        }
        
        let retCode = reader.replyEMVTransaction_POS(emvTagList)
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    

    private func enterPinPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pan = args[PARAM_NAME_PAN] as? String,
              let pinBlockFormat = args[PARAM_NAME_PIN_BLOCK_FORMAT] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.enterPIN_POS(pan, pinblockFormat: Int16(pinBlockFormat),
                                          maxDigit: Int16(maxDigit), timeout: Int16(timeout))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func cancelEnterPinPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.cancelEnterPIN_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func getDeviceStatusPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let kposResult = reader.getDeviceStatus_POS(){
            let retCode = kposResult.getCode()
            
            if retCode == RCODE_SUCCESS {
                let status = converter.fromKPOSResult(kposResult, commandType: converter.COMMAND_GET_DEVICE_STATUS_POS)
                result(status)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setBeepSoundPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let keyToneVolume = args[PARAM_NAME_KEY_VOLUME] as? Int,
              let beepVolume = args[PARAM_NAME_BEEP_VOLUME] as? Int,
              let beepSoundFlag = args[PARAM_NAME_BEEP_SOUND] as? Bool,
              let beepPowerOn = args[PARAM_NAME_BEEP_POWER_ON] as? Bool,
              let beepBarcode = args[PARAM_NAME_BEEP_BARCODE] as? Bool,
              let beepConnection = args[PARAM_NAME_BEEP_CONNECTION] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.setBeepSound_POS(Int16(keyToneVolume), beepVolume: Int16(beepVolume), beepSoundFlag: beepSoundFlag,
                                              enableBeepPowerOn:beepPowerOn , enableBeepBarcode: beepBarcode, enableBeepConnection: beepConnection)
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func getBeepSoundPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let kposResult = reader.getBeepSound_POS(){
            let retCode = kposResult.getCode()
            
            if retCode == RCODE_SUCCESS {
                let sound = converter.fromKPOSResult(kposResult, commandType: converter.COMMAND_GET_BEEP_SOUND_POS)
                result(sound)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setKeypadMenuEntryPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.setKeypadMenuEntry_POS(enable)
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func syncDateTimePos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.syncDateTime_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func getDateTimePos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let kposResult = reader.getDateTime_POS(){
            let retCode = kposResult.getCode()
            
            if retCode == RCODE_SUCCESS {
                let time = converter.fromKPOSResult(kposResult, commandType: converter.COMMAND_GET_DATE_TIME_POS)
                result(time)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func enableBatteryAlarmPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let interval = args[PARAM_NAME_INTERVAL] as? Int,
              let level = args[PARAM_NAME_LEVEL] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.enableBatteryAlarm_POS(Int16(interval), level: Int16(level))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func disableBatteryAlarmPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.disableBatteryAlarm_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func readDataPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let titleId = args[PARAM_NAME_TITLE_ID] as? Int,
              let target = args[PARAM_NAME_TARGET] as? Int,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let enableMask = args[PARAM_NAME_MASK] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.readData_POS(Int16(titleId), target: Int16(target), timeout: Int16(timeout),
                                          maxDigit: Int16(maxDigit), enableMask: enableMask)
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func cancelReadDataPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.cancelReadData_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }

    private func findMyKDCPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let count = args[PARAM_NAME_COUNT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.findMyKDC_POS(Int16(count))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func setDisplayMessagePos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let line1Message = args[PARAM_NAME_LINE1] as? String ?? KConstants.EMPTY_STRING
        let line2Message = args[PARAM_NAME_LINE2] as? String ?? KConstants.EMPTY_STRING
        let line3Message = args[PARAM_NAME_LINE3] as? String ?? KConstants.EMPTY_STRING
        let line4Message = args[PARAM_NAME_LINE4] as? String ?? KConstants.EMPTY_STRING
        
        let retCode = reader.setDisplayMessage_POS(line1Message, line2Message: line2Message,
                                                   line3Message: line3Message, line4Message: line4Message, timeout: Int16(timeout))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func clearDisplayPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.clearDisplay_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func enableKeypadPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let line = args[PARAM_NAME_LINE] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let clearFlag = args[PARAM_NAME_CLEAR] as? Bool,
              let enableMask = args[PARAM_NAME_MASK] as? Bool,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.enableKeypad_POS(Int16(line), maxDigit: Int16(maxDigit),
                                              clearFlag: clearFlag, enableMask: enableMask, timeout: Int16(timeout))
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func enableKeypadEventOnlyPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.enableKeypadEventOnly_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func disableKeypadPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let clearFlag = args[PARAM_NAME_CLEAR] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.disableKeypad_POS(clearFlag)
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func readEmvCLCardPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let pinBlockFormat = args[PARAM_NAME_PIN_BLOCK_FORMAT] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let transType = args[PARAM_NAME_TRANS_TYPE] as? Int,
              let amount = args[PARAM_NAME_AMOUNT] as? Int,
              let otherAmount = args[PARAM_NAME_OTHER_AMOUNT] as? Int,
              let onlinePinSupport = args[PARAM_NAME_ONLINE] as? Int,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let retCode = reader.readEmvCLCard_POS(Int16(pinBlockFormat), maxDigit: Int16(maxDigit), transType: Int16(transType),
                                               amount: Int32(amount), otherAmount: Int32(otherAmount), onlinePINSupport: Int16(onlinePinSupport),
                                               timeout: Int16(timeout))

        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func stopEmvCLTransactionPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.stopEmvCLTransaction_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
    
    private func getSupportedLocales(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let kposResult = reader.getSupportedLocales_POS() {
            let retCode = kposResult.getCode()
            if retCode == RCODE_SUCCESS {
                let dict = converter.fromKPOSResult(kposResult, commandType: converter.COMMAND_GET_SUPPORTED_LOCALES_POS)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setDisplayMessageWithLocalePos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let locale = args[PARAM_NAME_LOCALE] as? Int,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let line1Message = args[PARAM_NAME_LINE1] as? String ?? KConstants.EMPTY_STRING
        let line2Message = args[PARAM_NAME_LINE2] as? String ?? KConstants.EMPTY_STRING
        let line3Message = args[PARAM_NAME_LINE3] as? String ?? KConstants.EMPTY_STRING
        let line4Message = args[PARAM_NAME_LINE4] as? String ?? KConstants.EMPTY_STRING
        
        if let kposLocale = KPOSLocale(rawValue: locale) {
            let retCode = reader.setDisplayMessage_POS(line1Message, line2Message: line2Message, line3Message: line3Message,
                                                       line4Message: line4Message, locale: kposLocale, timeout: Int16(timeout))

            if retCode == RCODE_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result: result)
        }
    }
    
    private func setDisplayMessageIdAndReadKeypadPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let locale = args[PARAM_NAME_LOCALE] as? Int,
              let keypadType = args[PARAM_NAME_KEYPAD_TYPE] as? Int,
              let enableMask = args[PARAM_NAME_MASK] as? Bool,
              let keyInoutLineNumber = args[PARAM_NAME_INPUT_LINE] as? Int,
              let align = args[PARAM_NAME_INPUT_ALIGN] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let line1Id = args[PARAM_NAME_LINE1] as? Int ?? Int(KT_MSG_NONE)
        let line2Id = args[PARAM_NAME_LINE2] as? Int ?? Int(KT_MSG_NONE)
        let line3Id = args[PARAM_NAME_LINE3] as? Int ?? Int(KT_MSG_NONE)
        let line4Id = args[PARAM_NAME_LINE4] as? Int ?? Int(KT_MSG_NONE)
        
        if let kposLocale = KPOSLocale(rawValue: locale),
           let kposAlign = KPOSAlign(rawValue: align) {
            let retCode = reader.setDisplayMessageAndReadKeypad_POS(Int16(line1Id), line2Id: Int16(line2Id), line3Id: Int16(line3Id),
                                                                    line4Id: Int16(line4Id), locale: kposLocale, keypadType: Int16(keypadType),
                                                                    enableMask: enableMask, keyInputLineNumber: Int16(keyInoutLineNumber), keyInputAlign: kposAlign,
                                                                    maxDigit: Int16(maxDigit), timeout: Int16(timeout))
 
            if retCode == RCODE_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result: result)
        }
    }
    
    private func setDisplayMessageAndReadKeypadPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let locale = args[PARAM_NAME_LOCALE] as? Int,
              let keypadType = args[PARAM_NAME_KEYPAD_TYPE] as? Int,
              let enableMask = args[PARAM_NAME_MASK] as? Bool,
              let keyInoutLineNumber = args[PARAM_NAME_INPUT_LINE] as? Int,
              let align = args[PARAM_NAME_INPUT_ALIGN] as? Int,
              let maxDigit = args[PARAM_NAME_MAX_DIGIT] as? Int,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let line1Message = args[PARAM_NAME_LINE1] as? String ?? KConstants.EMPTY_STRING
        let line2Message = args[PARAM_NAME_LINE2] as? String ?? KConstants.EMPTY_STRING
        let line3Message = args[PARAM_NAME_LINE3] as? String ?? KConstants.EMPTY_STRING
        let line4Message = args[PARAM_NAME_LINE4] as? String ?? KConstants.EMPTY_STRING
        
        if let kposLocale = KPOSLocale(rawValue: locale),
           let kposAlign = KPOSAlign(rawValue: align) {
            let retCode = reader.setDisplayMessageAndReadKeypad_POS(line1Message, line2Message: line2Message, line3Message: line3Message,
                                                                    line4Message: line4Message, locale: kposLocale, keypadType: Int16(keypadType),
                                                                    enableMask: enableMask, keyInputLineNumber: Int16(keyInoutLineNumber), keyInputAlign: kposAlign,
                                                                    maxDigit: Int16(maxDigit), timeout: Int16(timeout))

            if retCode == RCODE_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result: result)
        }
    }
    
    private func setDisplayMessageAndSelectItemPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let locale = args[PARAM_NAME_LOCALE] as? Int,
              let firstItemLine = args[PARAM_NAME_FIRST_ITEM_LINE] as? Int,
              let items = args[PARAM_NAME_ITEMS] as? Array<String>,
              let timeout = args[PARAM_NAME_TIMEOUT] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let line1Message = args[PARAM_NAME_LINE1] as? String ?? KConstants.EMPTY_STRING
        let line2Message = args[PARAM_NAME_LINE2] as? String ?? KConstants.EMPTY_STRING
        let line3Message = args[PARAM_NAME_LINE3] as? String ?? KConstants.EMPTY_STRING
        
        if let kposLocale = KPOSLocale(rawValue: locale) {
            let retCode = reader.setDisplayMessageAndSelectItem_POS(line1Message, line2Message: line2Message, line3Message: line3Message,
                                                                    locale: kposLocale, firstItemLineNumber: Int16(firstItemLine), items: items,
                                                                    timeout: Int16(timeout))

            if retCode == RCODE_SUCCESS {
                result(true)
            } else {
                var detail = Dictionary<String, Any>()
                detail[KConstants.ResultKey.OperationPos] = retCode
                sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
            }
        } else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result: result)
        }
    }
    
    private func clearDisplayAndCancelKeypadPos(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let retCode = reader.clearDisplayAndCancelKeypad_POS()
        
        if retCode == RCODE_SUCCESS {
            result(true)
        } else {
            var detail = Dictionary<String, Any>()
            detail[KConstants.ResultKey.OperationPos] = retCode
            sendErrorResult(KConstants.ErrorCode.FAILED, detail: detail, result: result)
        }
    }
}
