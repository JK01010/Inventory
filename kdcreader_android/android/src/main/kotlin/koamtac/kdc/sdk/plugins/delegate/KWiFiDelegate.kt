package koamtac.kdc.sdk.plugins.delegate

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import koamtac.kdc.sdk.KDCConstants
import koamtac.kdc.sdk.KDCReader
import koamtac.kdc.sdk.plugins.KConstants
import koamtac.kdc.sdk.plugins.KConverter
import java.lang.ref.WeakReference

class KWiFiDelegate(reader: KDCReader): KReaderDelegate() {
    companion object {
        private const val IS_WIFI_INSTALLED = "isWiFiInstalled"

        private const val ENABLE_WIFI_POWER = "enableWiFiPower"
        private const val IS_WIFI_POWER_ENABLED = "isWiFiPowerEnabled"

        private const val ENABLE_WIFI_AUTO_CONNECT = "enableWiFiAutoConnect"
        private const val IS_WIFI_AUTO_CONNECT_ENABLED = "isWiFiAutoConnectEnabled"

        private const val SET_WIFI_SERVER_IP_ADDRESS = "setWiFiServerIPAddress"
        private const val GET_WIFI_SERVER_IP_ADDRESS = "getWiFiServerIPAddress"

        private const val SET_WIFI_SERVER_URL_ADDRESS = "setWiFiServerURLAddress"
        private const val GET_WIFI_SERVER_URL_ADDRESS = "getWiFiServerURLAddress"

        private const val SET_WIFI_SERVER_PORT_NUMBER = "setWiFiServerPortNumber"
        private const val GET_WIFI_SERVER_PORT_NUMBER = "getWiFiServerPortNumber"

        private const val SET_WIFI_PROTOCOL = "setWiFiProtocol"
        private const val GET_WIFI_PROTOCOL = "getWiFiProtocol"

        private const val ENABLE_WIFI_SSL = "enableWiFiSSL"
        private const val IS_WIFI_SSL_ENABLED = "isWiFiSSLEnabled"

        private const val SET_WIFI_SERVER_PAGE = "setWiFiServerPage"
        private const val GET_WIFI_SERVER_PAGE = "getWiFiServerPage"

        private const val SET_WIFI_CERTIFICATION = "setWiFiCertification"
        private const val GET_WIFI_CERTIFICATION = "getWiFiCertification"

        private const val SET_WIFI_AP_SSID = "setWiFiApSSID"
        private const val GET_WIFI_AP_SSID = "getWiFiApSSID"

        private const val SET_WIFI_AP_PASSCODE = "setWiFiApPasscode"
        private const val GET_WIFI_AP_PASSCODE = "getWiFiApPasscode"

        private val SUPPORTED_ACTIONS = HashSet(
            listOf(
                IS_WIFI_INSTALLED,
                ENABLE_WIFI_POWER,
                IS_WIFI_POWER_ENABLED,
                ENABLE_WIFI_AUTO_CONNECT,
                IS_WIFI_AUTO_CONNECT_ENABLED,
                SET_WIFI_SERVER_IP_ADDRESS,
                GET_WIFI_SERVER_IP_ADDRESS,
                SET_WIFI_SERVER_URL_ADDRESS,
                GET_WIFI_SERVER_URL_ADDRESS,
                SET_WIFI_SERVER_PORT_NUMBER,
                GET_WIFI_SERVER_PORT_NUMBER,
                SET_WIFI_PROTOCOL,
                GET_WIFI_PROTOCOL,
                ENABLE_WIFI_SSL,
                IS_WIFI_SSL_ENABLED,
                SET_WIFI_SERVER_PAGE,
                GET_WIFI_SERVER_PAGE,
                SET_WIFI_CERTIFICATION,
                GET_WIFI_CERTIFICATION,
                SET_WIFI_AP_SSID,
                GET_WIFI_AP_SSID,
                SET_WIFI_AP_PASSCODE,
                GET_WIFI_AP_PASSCODE,
            )
        )

        private const val PARAM_NAME_ENABLE = "enable"
        private const val PARAM_NAME_IP = "ip"
        private const val PARAM_NAME_URL = "url"
        private const val PARAM_NAME_PORT = "port"
        private const val PARAM_NAME_PROTOCOL = "protocol"
        private const val PARAM_NAME_SERVER_PAGE = "page"
        private const val PARAM_NAME_CERTIFICATION = "cert"
        private const val PARAM_NAME_SSID = "ssid"
        private const val PARAM_NAME_PASSCODE = "passcode"
    }

    init {
        wrReader = WeakReference(reader)
    }

    override fun isSupported(action: String): Boolean {
        return SUPPORTED_ACTIONS.contains(action)
    }

    override fun run(context: Context, call: MethodCall, result: MethodChannel.Result): Boolean {
        val reader = wrReader.get();

        if (reader == null) {
            sendErrorResult(KConstants.ErrorCode.instance.NULL, result)
            return true
        }

        when (call.method) {
            IS_WIFI_INSTALLED -> isWiFiInstalled(reader, call, result)

            ENABLE_WIFI_POWER -> enableWiFiPower(reader, call, result)
            IS_WIFI_POWER_ENABLED -> isWiFiPowerEnabled(reader, call, result)

            ENABLE_WIFI_AUTO_CONNECT -> enableWiFiAutoConnect(reader, call, result)
            IS_WIFI_AUTO_CONNECT_ENABLED -> isWiFiAutoConnectEnabled(reader, call, result)

            SET_WIFI_SERVER_IP_ADDRESS -> setWiFiServerIPAddress(reader, call, result)
            GET_WIFI_SERVER_IP_ADDRESS -> getWiFiServerIPAddress(reader, call, result)

            SET_WIFI_SERVER_URL_ADDRESS -> setWiFiServerURLAddress(reader, call, result)
            GET_WIFI_SERVER_URL_ADDRESS -> getWiFiServerURLAddress(reader, call, result)

            SET_WIFI_SERVER_PORT_NUMBER -> setWiFiServerPortNumber(reader, call, result)
            GET_WIFI_SERVER_PORT_NUMBER -> getWiFiServerPortNumber(reader, call, result)

            SET_WIFI_PROTOCOL -> setWiFiProtocol(reader, call, result)
            GET_WIFI_PROTOCOL -> getWiFiProtocol(reader, call, result)

            ENABLE_WIFI_SSL -> enableWiFiSSL(reader, call, result)
            IS_WIFI_SSL_ENABLED -> isWiFiSSLEnabled(reader, call, result)

            SET_WIFI_SERVER_PAGE -> setWiFiServerPage(reader, call, result)
            GET_WIFI_SERVER_PAGE -> getWiFiServerPage(reader, call, result)

            SET_WIFI_CERTIFICATION -> setWiFiCertification(reader, call, result)
            GET_WIFI_CERTIFICATION -> getWiFiCertification(reader, call, result)

            SET_WIFI_AP_SSID -> setWiFiApSSID(reader, call, result)
            GET_WIFI_AP_SSID -> getWiFiApSSID(reader, call, result)

            SET_WIFI_AP_PASSCODE -> setWiFiApPasscode(reader, call, result)
            GET_WIFI_AP_PASSCODE -> getWiFiApPasscode(reader, call, result)
        }
        return true
    }

    private fun isWiFiInstalled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val attached = reader.IsWiFiInstalled()
        result.success(attached)
    }

    private fun enableWiFiPower(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableWiFiPower(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isWiFiPowerEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsWiFiPowerEnabled()
        result.success(enable)
    }

    private fun enableWiFiAutoConnect(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableWiFiAutoConnect(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isWiFiAutoConnectEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsWiFiAutoConnectEnabled()
        result.success(enable)
    }

    private fun setWiFiServerIPAddress(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val ip = call.argument<String>(PARAM_NAME_IP)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetWiFiServerIPAddress(ip ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getWiFiServerIPAddress(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val ip = reader.GetWiFiServerIPAddress()

        ip?.let {
            result.success(it)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setWiFiServerURLAddress(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val url = call.argument<String>(PARAM_NAME_URL)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetWiFiServerURLAddress(url ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getWiFiServerURLAddress(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val url = reader.GetWiFiServerURLAddress()

        url?.let {
            result.success(it)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setWiFiServerPortNumber(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val port = call.argument<Int>(PARAM_NAME_PORT)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        port?.let {
            val bRet = reader.SetWiFiServerPortNumber(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getWiFiServerPortNumber(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val port = reader.GetWiFiServerPortNumber()

        if (port > -1) {
            result.success(port)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun setWiFiProtocol(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val protocol = call.argument<Int>(PARAM_NAME_PROTOCOL)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val wifiProtocol = protocol?.let {
            for (p in KDCConstants.WiFiProtocol.values()) {
                if (it == p.ordinal) {
                    return@let p
                }
            }
            null
        }

        wifiProtocol?.let {
            val bRet = reader.SetWiFiProtocol(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun getWiFiProtocol(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val protocol = reader.GetWiFiProtocol()

        protocol?.let {
            result.success(it.ordinal)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun enableWiFiSSL(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val enable = call.argument<Boolean>(PARAM_NAME_ENABLE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        enable?.let {
            val bRet = reader.EnableWiFiSSL(it)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)
    }

    private fun isWiFiSSLEnabled(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val enable = reader.IsWiFiSSLEnabled()
        result.success(enable)
    }

    private fun setWiFiServerPage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val page = call.argument<String>(PARAM_NAME_SERVER_PAGE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetWiFiServerPage(page ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getWiFiServerPage(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val page = reader.GetWiFiServerPage()

        page?.let {
            result.success(it)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setWiFiCertification(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val certification = call.argument<ByteArray>(PARAM_NAME_CERTIFICATION)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        certification?.let {
            val bRet = reader.SetWiFiCertification(certification)

            if (bRet) {
                result.success(true)
            } else {
                sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
            }
        } ?: sendErrorResult(KConstants.ErrorCode.instance.INVALID_PARAMETER, result)

        TODO("Not yet implemented : Test Required")
    }

    private fun getWiFiCertification(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val cert = reader.GetWiFiCertification()

        cert?.let {
            result.success(cert)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)

        TODO("Not yet implemented : Test Required")
    }

    private fun setWiFiApSSID(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val ssid = call.argument<String>(PARAM_NAME_SSID)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetWiFiApSSID(ssid ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getWiFiApSSID(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val ssid = reader.GetWiFiApSSID()

        ssid?.let {
            result.success(it)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }

    private fun setWiFiApPasscode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        val passcode = call.argument<String>(PARAM_NAME_PASSCODE)

        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val bRet = reader.SetWiFiApPasscode(passcode ?: KConstants.EMPTY_STRING)

        if (bRet) {
            result.success(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
        }
    }

    private fun getWiFiApPasscode(reader: KDCReader, call: MethodCall, result: MethodChannel.Result) {
        if (!isConnected(reader)) {
            sendErrorResult(KConstants.ErrorCode.instance.NOT_CONNECTED, result)
            return
        }

        val passcode = reader.GetWiFiApPasscode()

        passcode?.let {
            result.success(it)
        } ?: sendErrorResult(KConstants.ErrorCode.instance.FAILED, result)
    }
}