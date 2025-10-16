package koamtac.kdc.sdk.plugins

import android.graphics.Bitmap
import android.hardware.usb.UsbDevice
import android.os.Build
import koamtac.kdc.sdk.KDCBarcodeOption
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCData
import koamtac.kdc.sdk.KDCDevice
import koamtac.kdc.sdk.KDCDeviceInfo
import koamtac.kdc.sdk.KDCSWData
import koamtac.kdc.sdk.KDCSWDecoderActivationResult
import koamtac.kdc.sdk.KDCSWDecoderSetting
import koamtac.kdc.sdk.KDCSymbology
import koamtac.kdc.sdk.KPOSData
import koamtac.kdc.sdk.KPOSEMVApplication
import koamtac.kdc.sdk.KPOSEMVTagList
import koamtac.kdc.sdk.KPOSResult
import koamtac.kdc.sdk.UHFResult
import koamtac.kdc.sdk.UHFResult.QueryParameter
import java.io.ByteArrayOutputStream
import java.util.Locale

class KConverter {
    companion object {
        const val COMMAND_GET_DEVICE_STATUS_POS = 1
        const val COMMAND_GET_BEEP_SOUND_POS = 2
        const val COMMAND_GET_DATE_TIME_POS = 3
        const val COMMAND_GET_SUPPORTED_LOCALES_POS = 4

        fun toMap(info: KDCDeviceInfo?): Map<String, Any> {
            val map = HashMap<String, Any>()
            info?.let {
                map[KConstants.DeviceInfoKey.Name] = it.GetModelName()
                map[KConstants.DeviceInfoKey.Firmware] = it.GetFirmwareVersion()
                map[KConstants.DeviceInfoKey.SerialNumber] = it.GetSerialNumber()

                map[KConstants.DeviceInfoKey.IsFlash] = it.IsFlash()
                map[KConstants.DeviceInfoKey.IsBluetooth] = it.IsBluetooth()
                map[KConstants.DeviceInfoKey.IsBarcode] = it.IsBarcode()
                map[KConstants.DeviceInfoKey.Is2D] = it.IsModel2D()
                map[KConstants.DeviceInfoKey.IsMSR] = it.IsMSR()
                map[KConstants.DeviceInfoKey.IsNFC] = it.IsNFC()
                map[KConstants.DeviceInfoKey.IsGPS] = it.IsGPS()
                map[KConstants.DeviceInfoKey.IsUHF] = it.IsUHF()
                map[KConstants.DeviceInfoKey.IsWiFi] = it.IsWiFi()
                map[KConstants.DeviceInfoKey.IsKeypad] = it.IsKeypad()
                map[KConstants.DeviceInfoKey.IsVibrator] = it.IsVib()
                map[KConstants.DeviceInfoKey.IsDisplay] = it.IsDisp()
                map[KConstants.DeviceInfoKey.IsPassportReader] = it.IsPassportReader()
                map[KConstants.DeviceInfoKey.IsFingerPrint] = it.IsFingerPrint()
                map[KConstants.DeviceInfoKey.IsMsrIc] = it.IsMSRIC()

                if (it.IsFeatureInformationEx()) {
                    map[KConstants.DeviceInfoKey.IsSocialDistance] = it.IsSocialDistance()
                    map[KConstants.DeviceInfoKey.IsOCR] = it.IsOCR()
                    map[KConstants.DeviceInfoKey.IsMRZ] = it.IsMRZ()
                    map[KConstants.DeviceInfoKey.IsSLED] = it.IsSLED()
                }

                map[KConstants.DeviceInfoKey.IsNewArchitectureModel] = it.IsNewArchitectureModel()

                map[KConstants.DeviceInfoKey.IsPos] = it.IsPOS()
            }
            return map
        }

        fun toMap(device: KDCDevice<*>?): Map<String, Any?> {
            val map = HashMap<String, Any?>()
            device?.let {
                map[KConstants.DeviceKey.Type] = it.GetType()
                map[KConstants.DeviceKey.SubType] = it.GetSubType()
                map[KConstants.DeviceKey.DeviceName] = it.GetDeviceName()
                map[KConstants.DeviceKey.KDCName] = it.GetKdcName()
            }
            return map
        }

        fun toMap(device: UsbDevice?): Map<String, Any?> {
            val map = HashMap<String, Any?>()
            device?.let {
                map[KConstants.DeviceKey.Type] = KDCDevice.Type.USB
                map[KConstants.DeviceKey.SubType] = KDCDevice.Subtype.USB_DEVICE
                map[KConstants.DeviceKey.DeviceName] = it.deviceName
                map[KConstants.DeviceKey.KDCName] = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    it.productName ?: KConstants.EMPTY_STRING
                } else {
                    KConstants.EMPTY_STRING
                }
            }
            return map
        }

        fun toMap(data: KDCData?): Map<String, Any?> {
            val map = HashMap<String, Any?>()
            data?.let {
                // data type
                map[KConstants.DataKey.Type] = it.GetDataType().ordinal

                // data
                map[KConstants.DataKey.Data] = it.GetData()
                map[KConstants.DataKey.DataBytes] = it.GetDataBytes()

                // Record
                map[KConstants.DataKey.Record] = it.GetRecord()

                when (it.GetDataType()) {
                    KDCConstants.DataType.BARCODE -> {
                        map[KConstants.DataKey.Symbol] = it.GetBarcodeSymbology()?.let {
                            it.GetName() ?: KConstants.EMPTY_STRING
                        } ?: {
                            KConstants.EMPTY_STRING
                        }
                        map[KConstants.DataKey.Barcode] = it.GetBarcodeData()

                        if (it is KDCSWData) {
                            val boundsMap = HashMap<String, Any>()
                            val pointMap = HashMap<String, Any>()

                            val bounds = it.GetBounds()
                            pointMap[KConstants.SWDecoderBoundsKey.X] = bounds.GetTopLeft().x
                            pointMap[KConstants.SWDecoderBoundsKey.Y] = bounds.GetTopLeft().y
                            boundsMap[KConstants.SWDecoderBoundsKey.TopLeft] = pointMap

                            pointMap.clear()
                            pointMap[KConstants.SWDecoderBoundsKey.X] = bounds.GetTopRight().x
                            pointMap[KConstants.SWDecoderBoundsKey.Y] = bounds.GetTopRight().y
                            boundsMap[KConstants.SWDecoderBoundsKey.TopRight] = pointMap

                            pointMap.clear()
                            pointMap[KConstants.SWDecoderBoundsKey.X] = bounds.GetBottomLeft().x
                            pointMap[KConstants.SWDecoderBoundsKey.Y] = bounds.GetBottomLeft().y
                            boundsMap[KConstants.SWDecoderBoundsKey.BottomLeft] = pointMap

                            pointMap.clear()
                            pointMap[KConstants.SWDecoderBoundsKey.X] = bounds.GetBottomRight().x
                            pointMap[KConstants.SWDecoderBoundsKey.Y] = bounds.GetBottomRight().y
                            boundsMap[KConstants.SWDecoderBoundsKey.BottomRight] = pointMap

                            boundsMap[KConstants.SWDecoderBoundsKey.Width] = bounds.GetOriginalImageWidth()
                            boundsMap[KConstants.SWDecoderBoundsKey.Height] = bounds.GetOriginalImageHeight()
                            map[KConstants.SWDecoderDataKey.Bounds] = boundsMap
                        }
                    }

                    KDCConstants.DataType.MSR -> {
                        map[KConstants.DataKey.MSR] = it.GetMSRData()
                        map[KConstants.DataKey.MSRBytes] = it.GetMSRDataBytes()
                    }

                    KDCConstants.DataType.NFC -> {
                        map[KConstants.DataKey.NFCTagType] = it.GetNFCTagType().ordinal
                        map[KConstants.DataKey.NFCUid] = it.GetNFCUID()
                        map[KConstants.DataKey.NFC] = it.GetNFCData()
                        map[KConstants.DataKey.NFCBytes] = it.GetNFCDataBytes()
                    }

                    KDCConstants.DataType.GPS ->
                        map[KConstants.DataKey.GPS] = it.GetGPSData()

                    KDCConstants.DataType.KEY_EVENT ->
                        map[KConstants.DataKey.KeyEvent] = it.GetKeyEvent()

                    KDCConstants.DataType.UHF_LIST -> {
                        map[KConstants.DataKey.UHFListType] = it.GetUHFListDataType().ordinal
                        map[KConstants.DataKey.UHFList] = it.GetUHFList()
                        map[KConstants.DataKey.UHFRssiList] = it.GetUHFRssiList()
                    }

                    else -> {
                        // do nothing
                    }
                }
            }
            return map
        }

        fun toMap(symbol: KDCSymbology?): Map<String, Any> {
            val map = HashMap<String, Any>()
            symbol?.let {
                val symbolList = it.GetAvailableSymbologies()
                for (s in symbolList) {
                    map[s.name] = it.IsEnabled(s)
                }
            }
            return map
        }

        fun toMap(option: KDCBarcodeOption?): Map<String, Any> {
            val map = HashMap<String, Any>()
            option?.let {
                val optionList = it.GetAvailableBarcodeOptions()
                for (o in optionList) {
                    map[o.name] = it.IsEnabled(o)
                }
            }
            return map
        }

        fun toMap(parameter: UHFResult.SelectParameter?): Map<String, Any> {
            val map = HashMap<String, Any>()
            parameter?.let { param ->
                map[KConstants.SelectParameterKey.Target] = param.GetTarget()
                map[KConstants.SelectParameterKey.Action] = param.GetAction()

                val bank = param.GetMemoryBank()
                bank?.let {
                    map[KConstants.SelectParameterKey.Bank] = it.ordinal
                }

                map[KConstants.SelectParameterKey.Pointer] = param.GetPointer()
                map[KConstants.SelectParameterKey.Length] = param.GetLength()

                val mask = if (param.GetMaskData() != null) String(param.GetMaskData()) else null
                mask?.let {
                    map[KConstants.SelectParameterKey.MaskData] = it
                }

//                map[KConstants.SelectParameterKey.MaskDataBytes] = param.GetMaskData();
                map[KConstants.SelectParameterKey.Truncated] = param.IsTruncated()
            }

            return map
        }

        fun toMap(parameter: QueryParameter?): Map<String, Any> {
            val map = HashMap<String, Any>()
            parameter?.let {
                map[KConstants.QueryParameterKey.Dr] = it.GetDr()
                map[KConstants.QueryParameterKey.Cycle] = it.GetCycles()
                map[KConstants.QueryParameterKey.TRext] = it.GetTRext()
                map[KConstants.QueryParameterKey.Sel] = it.GetSel()
                map[KConstants.QueryParameterKey.Session] = it.GetSession()
                map[KConstants.QueryParameterKey.Target] = it.GetTarget()
                map[KConstants.QueryParameterKey.SlotNum] = it.GetSlotNum()
            }
            return map
        }

        private fun toMap(app: KPOSEMVApplication?): Map<String, Any> {
            val map = HashMap<String, Any>()
            app?.let {
                map[KConstants.PosEMVAppKey.Index] = it.GetIndex()
                map[KConstants.PosEMVAppKey.Priority] = it.GetPriority()
                map[KConstants.PosEMVAppKey.Name] = it.GetName()
            }
            return map
        }

        private fun toMap(list: KPOSEMVTagList?): Map<String, Any> {
            val map = HashMap<String, Any>()
            list?.let {
                map[KConstants.PosEMVTagKey.TLV] = it.GetTLVs()
                //map[KConstants.PosEMVTagKey.TLV, it.GetTLVs())
                map[KConstants.PosEMVTagKey.Brand] = String.format(Locale.ENGLISH, "%c", it.GetICCardBrand())
            }
            return map
        }

        fun toMap(data: KPOSData?): Map<String, Any?> {
            val map = HashMap<String, Any?>()
            data?.let {
                map[KConstants.PosDataKey.CommandCode] = it.GetCommandCode()
                map[KConstants.PosDataKey.EventCode] = it.GetEventCode()

                it.GetBarcodeBytes()?.let {bytes ->
                    map[KConstants.PosDataKey.Barcode] = String(bytes)
                    map[KConstants.PosDataKey.BarcodeBytes] = bytes
                }

                map[KConstants.PosDataKey.NFC] = it.GetNFCData()
                map[KConstants.PosDataKey.NFCUid] = it.GetNFCUID()
                map[KConstants.PosDataKey.NFCBytes] = it.GetNFCDataBytes()
                map[KConstants.PosDataKey.PinBlockBytes] = it.GetPinBlockBytes()
                map[KConstants.PosDataKey.CardDataKSN] = it.GetCardDataKSN()
                map[KConstants.PosDataKey.PinBlockKSN] = it.GetPinBlockKSN()
                map[KConstants.PosDataKey.DeviceSerialNumber] = it.GetDeviceSerialNumber()
                map[KConstants.PosDataKey.Track1] = it.GetTrack1()
                map[KConstants.PosDataKey.Track2] = it.GetTrack2()
                map[KConstants.PosDataKey.Track3] = it.GetTrack3()
                map[KConstants.PosDataKey.PosEntryMode] = it.GetPOSEntryMode()
                map[KConstants.PosDataKey.EncryptSpec] = it.GetEncryptionSpec()
                map[KConstants.PosDataKey.EncryptType] = it.GetEncryptionType()
                map[KConstants.PosDataKey.EncryptedDataSize] = it.GetEncryptedDataSize()

                map[KConstants.PosDataKey.maskedTrack1] = it.GetMaskedTrack1()
                map[KConstants.PosDataKey.maskedTrack2] = it.GetMaskedTrack2()
                map[KConstants.PosDataKey.maskedTrack3] = it.GetMaskedTrack3()

                map[KConstants.PosDataKey.UnencryptedTrack1Length] = it.GetUnencryptedTrack1Length()
                map[KConstants.PosDataKey.UnencryptedTrack2Length] = it.GetUnencryptedTrack2Length()
                map[KConstants.PosDataKey.UnencryptedTrack3Length] = it.GetUnencryptedTrack3Length()
                map[KConstants.PosDataKey.UnencryptedPANLength] = it.GetUnencryptedPANLength()

                map[KConstants.PosDataKey.EncryptedTrack1Bytes] = it.GetEncryptedTrack1Bytes()
                map[KConstants.PosDataKey.EncryptedTrack2Bytes] = it.GetEncryptedTrack2Bytes()
                map[KConstants.PosDataKey.EncryptedTrack3Bytes] = it.GetEncryptedTrack3Bytes()
                map[KConstants.PosDataKey.EncryptedPANBytes] = it.GetEncryptedPANBytes()

                map[KConstants.PosDataKey.DigestType] = it.GetDigestType()
                map[KConstants.PosDataKey.DigestTrack1Bytes] = it.GetTrack1DigestBytes()
                map[KConstants.PosDataKey.DigestTrack2Bytes] = it.GetTrack2DigestBytes()
                map[KConstants.PosDataKey.DigestTrack3Bytes] = it.GetTrack3DigestBytes()
                map[KConstants.PosDataKey.DigestPANBytes] = it.GetPANDigestBytes()

                map[KConstants.PosDataKey.IsAutoAppSelection] = it.IsAutoAppSelection()
                map[KConstants.PosDataKey.NumberOfAIDs] = it.GetNumberOfAIDs()

                map[KConstants.PosDataKey.EMVApplicationList] = toArray(it.GetEMVApplicationList())
                map[KConstants.PosDataKey.EMVTagList] = toMap(it.GetEMVTagList())

                map[KConstants.PosDataKey.EMVResultCode] = it.GetEMVResultCode()
                map[KConstants.PosDataKey.EMVFallbackType] = it.GetEMVFallbackType()
                map[KConstants.PosDataKey.ErrorCode] = it.GetErrorCode()
                map[KConstants.PosDataKey.BatteryStatus] = it.GetBatteryStatus()
                map[KConstants.PosDataKey.PressedKey] = it.GetPressedKey().code
                map[KConstants.PosDataKey.ValueEntered] = it.GetValueEntered()
                map[KConstants.PosDataKey.SelectedItemIndex] = it.GetSelectedItemIndex()
            }
            return map
        }

        fun toMap(result: KPOSResult?, commandType: Int): Map<String, Any> {
            val map = HashMap<String, Any>()
            result?.let {
                // common
                map[KConstants.PosResultKey.ResultCode] = it.GetResultCode()

                when (commandType) {
                    COMMAND_GET_DEVICE_STATUS_POS -> {
                        map[KConstants.PosResultKey.SerialNumber] = it.GetSerialNumber()
                        map[KConstants.PosResultKey.LoaderVersion] = it.GetLoaderVersion()
                        map[KConstants.PosResultKey.FirmwareVersion] = it.GetFirmwareVersion()
                        map[KConstants.PosResultKey.ApplicationVersion] = it.GetApplicationVersion()
                        map[KConstants.PosResultKey.BluetoothVersion] = it.GetBluetoothVersion()
                        map[KConstants.PosResultKey.BluetoothName] = it.GetBluetoothName()
                        map[KConstants.PosResultKey.BarcodeType] = it.GetBarcodeType()
                        map[KConstants.PosResultKey.BatteryStatus] = it.GetBatteryStatus()
                        map[KConstants.PosResultKey.MsrEnabled] = it.isMSREnabled
                        map[KConstants.PosResultKey.NfcEnabled] = it.isNFCEnabled
                        map[KConstants.PosResultKey.KeypadMenuEntryEnabled] = it.isKeypadMenuEntryEnabled
                        map[KConstants.PosResultKey.NumOfEMVBatchData] = it.GetNumOfEMVBatchData()
                    }

                    COMMAND_GET_BEEP_SOUND_POS -> {
                        map[KConstants.PosResultKey.KeyToneVolume] = it.GetKeyToneVolume()
                        map[KConstants.PosResultKey.BeepVolume] = it.GetBeepVolume()
                        map[KConstants.PosResultKey.BeepSoundFlag] = it.GetBeepSoundFlag()
                        map[KConstants.PosResultKey.BeepPowerOn] = it.IsBeepOnPowerOnEvent()
                        map[KConstants.PosResultKey.BeepBarcodeScan] = it.IsBeepOnBarcodeScanEvent()
                        map[KConstants.PosResultKey.BeepConnection] = it.IsBeepOnConnectionEvent()
                    }

                    COMMAND_GET_DATE_TIME_POS -> {
                        val calendar = it.GetDateTime()
                        calendar?.let {cal ->
                            map[KConstants.PosResultKey.Date] = cal.time.toString()
                        }
                    }

                    COMMAND_GET_SUPPORTED_LOCALES_POS ->
                        map[KConstants.PosResultKey.Locales] = it.GetSupportedLocales()

                    else -> {}
                }
            }
            return map
        }

        fun <T> toArray(list: List<T>?): List<Any> {
            val array = ArrayList<Any>()
            list?.let {
                for (item in list) {
                    if (item is KDCDevice<*>) {
                        toMap(item as KDCDevice<*>).let { array.add(it) }
                    } else if (item is Int) {
                        array.add(item as Int)
                    } else if (item is String) {
                        array.add(item as String)
                    }
                }
            }
            return array
        }

        private fun <T> toArray(arr: Array<T>?): List<Any> {
            val array = ArrayList<Any>()
            arr?.let {
                for (item in arr) {
                    if (item is KPOSEMVApplication) {
                        toMap(item as KPOSEMVApplication).let { array.add(it) }
                    } else if (item is KDCDevice<*>) {
                        toMap(item as KDCDevice<*>).let { array.add(it) }
                    } else if (item is Int) {
                        array.add(item as Int)
                    } else if (item is String) {
                        array.add(item as String)
                    } else if (item is Byte) {
                        array.add(item.toInt() and 0xFF)
                    }
                }
            }
            return array
        }

        // region SoftwareDecoder
        fun toMap(result: KDCSWDecoderActivationResult?): Map<String, Any> {
            val map = HashMap<String, Any>()

            result?.let {
                map[KConstants.SWDecoderActivationKey.Code] = it.GetResultCode()
                map[KConstants.SWDecoderActivationKey.Message] = it.GetResultMessage()
                map[KConstants.SWDecoderActivationKey.DeviceId] = it.GetDeviceId()
            }
            return map
        }

        fun toMap(setting: KDCSWDecoderSetting?): Map<String, Any> {
            val map = HashMap<String, Any>()
            setting?.let {
                map[KConstants.SWDecoderSettingKey.FlashOnDecode] = setting.IsFlashOnDecodeEnabled()
                map[KConstants.SWDecoderSettingKey.Decode] = setting.IsDecodingEnabled()
                //map[KConstants.SWDecoderSettingKey.Window] = toArray(setting.GetWindow())
                map[KConstants.SWDecoderSettingKey.Window] = setting.GetWindow()
                map[KConstants.SWDecoderSettingKey.WindowMode] = setting.GetWindowMode().ordinal
            }
            return map
        }

        fun toMap(bitmap: Bitmap?): Map<String, Any> {
            val map = HashMap<String, Any>()
            bitmap?.let {
                map[KConstants.SWDecoderImageKey.Width] = it.width
                map[KConstants.SWDecoderImageKey.Height] = it.height

                val stream = ByteArrayOutputStream()
                it.compress(Bitmap.CompressFormat.PNG, 100, stream)
                map[KConstants.SWDecoderImageKey.Png] = stream.toByteArray()
                it.recycle()
            }
            return map
        }
        // endregion SoftwareDecoder
    }
}