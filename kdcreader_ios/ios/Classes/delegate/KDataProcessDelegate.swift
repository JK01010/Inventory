//
//  KDataProcessDelegate.swift
//  kdcreader_ios
//
//  Created by koamtac on 3/21/24.
//

import Flutter

class KDataProcessDelegate: KReaderDelegate {
    private let GET_DATA_PREFIX = "getDataPrefix"
    private let SET_DATA_PREFIX = "setDataPrefix"

    private let GET_DATA_SUFFIX = "getDataSuffix"
    private let SET_DATA_SUFFIX = "setDataSuffix"

    private let GET_SYMBOLOGY = "getSymbology"
    private let SET_SYMBOLOGY = "setSymbology"
    private let ENABLE_ALL_SYMBOLOGY = "enableAllSymbology"
    private let DISABLE_ALL_SYMBOLOGY = "disableAllSymbology"

    private let GET_BARCODE_OPTION = "getBarcodeOption"
    private let SET_BARCODE_OPTION = "setBarcodeOption"
    private let ENABLE_ALL_OPTIONS = "enableAllOptions"
    private let DISABLE_ALL_OPTIONS = "disableAllOptions"

    private let GET_MINIMUM_BARCODE_LENGTH = "getMinimumBarcodeLength"
    private let SET_MINIMUM_BARCODE_LENGTH = "setMinimumBarcodeLength"

    private let GET_NUMBER_OF_STORED_BARCODE = "getNumberOfStoredBarcode"

    private let GET_STORED_DATA_SINGLE = "getStoredDataSingle"

    private let GET_DATA_FORMAT = "getDataFormat"
    private let SET_DATA_FORMAT = "setDataFormat"

    private let GET_DATA_PROCESS_MODE = "getDataProcessMode"
    private let SET_DATA_PROCESS_MODE = "setDataProcessMode"

    private let GET_SECURITY_LEVEL = "getSecurityLevel"
    private let SET_SECURITY_LEVEL = "setSecurityLevel"

    private let ENABLE_AGE_VERIFY = "enableAgeVerify"
    private let IS_AGE_VERIFY_ENABLED = "isAgeVerifyEnabled"

    private let GET_AIMID_SETTING = "getAIMIDSetting"
    private let SET_AIMID_SETTING = "setAIMIDSetting"

    private let GET_PARTIAL_DATA_START_POSITION = "getPartialDataStartPosition"
    private let SET_PARTIAL_DATA_START_POSITION = "setPartialDataStartPosition"

    private let GET_PARTIAL_DATA_LENGTH = "getPartialDataLength"
    private let SET_PARTIAL_DATA_LENGTH = "setPartialDataLength"

    private let GET_PARTIAL_DATA_ACTION = "getPartialDataAction"
    private let SET_PARTIAL_DATA_ACTION = "setPartialDataAction"

    private let START_SYNCHRONIZATION = "startSynchronization"
    private let FINISH_SYNCHRONIZATION = "finishSynchronization"

    private let GET_DATA_TERMINATOR = "getDataTerminator"
    private let SET_DATA_TERMINATOR = "setDataTerminator"
    
    /* PARAM */
    private let PARAM_NAME_PREFIX = "prefix"
    private let PARAM_NAME_SUFFIX = "suffix"
    private let PARAM_NAME_LENGTH = "length"
    private let PARAM_NAME_SYMBOLS = "symbols"
    private let PARAM_NAME_OPTIONS = "options"
    private let PARAM_NAME_FORMAT = "format"
    private let PARAM_NAME_MODE = "mode"
    private let PARAM_NAME_LEVEL = "level"
    private let PARAM_NAME_ENABLE = "enable"
    private let PARAM_NAME_AIMID = "aimid"
    private let PARAM_NAME_POSITION = "position"
    private let PARAM_NAME_ACTION = "action"
    private let PARAM_NAME_TERMINATOR = "terminator"
    private let PARAM_NAME_COUNT = "count"
    
    //************************************************************************
    //
    //  Barcode 1D Symbol
    //
    //************************************************************************
    private let LASER_SYMBOL_EAN13          = 0x00000001
    private let LASER_SYMBOL_EAN8           = 0x00000002
    private let LASER_SYMBOL_UPCA           = 0x00000004
    private let LASER_SYMBOL_UPCE           = 0x00000008
    private let LASER_SYMBOL_CODE39         = 0x00000010
    private let LASER_SYMBOL_ITF14          = 0x00000020
    private let LASER_SYMBOL_CODE128        = 0x00000040
    private let LASER_SYMBOL_I2OF5          = 0x00000080
    private let LASER_SYMBOL_CODABAR        = 0x00000100
    private let LASER_SYMBOL_GS1128         = 0x00000200
    private let LASER_SYMBOL_CODE93         = 0x00000400
    private let LASER_SYMBOL_CODE35         = 0x00000800

    private let LASER_SYMBOL_BOOKLAND       = 0x00001000
    private let LASER_SYMBOL_EAN13_ADDON    = 0x00002000
    private let LASER_SYMBOL_EAN8_ADDON     = 0x00004000
    private let LASER_SYMBOL_UPCA_ADDON     = 0x00008000
    private let LASER_SYMBOL_UPCE_ADDON     = 0x00010000
    private let LASER_SYMBOL_GS1OMNI        = 0x00020000
    private let LASER_SYMBOL_GS1LIMIT       = 0x00040000
    private let LASER_SYMBOL_GS1EXPAND      = 0x00080000

    //************************************************************************
    //
    //  Barcode 2D Symbol
    //
    //************************************************************************
    /* First */
    private let IMAGER_SYMBOL_CODABAR       = 0x00000001
    private let IMAGER_SYMBOL_CODE11        = 0x00000002
    private let IMAGER_SYMBOL_CODE32        = 0x00000004
    private let IMAGER_SYMBOL_CODE39        = 0x00000008
    private let IMAGER_SYMBOL_CODE93        = 0x00000010
    private let IMAGER_SYMBOL_CODE128       = 0x00000020
    private let IMAGER_SYMBOL_EAN8          = 0x00000040
    private let IMAGER_SYMBOL_EAN13         = 0x00000080
    private let IMAGER_SYMBOL_GS1128        = 0x00000100
    private let IMAGER_SYMBOL_I2OF5         = 0x00000200
    private let IMAGER_SYMBOL_MATRIX2OF5    = 0x00000400
    private let IMAGER_SYMBOL_MSI           = 0x00000800
    private let IMAGER_SYMBOL_PLESSEY       = 0x00001000
    private let IMAGER_SYMBOL_POSICODE      = 0x00002000
    private let IMAGER_SYMBOL_GS1OMNI       = 0x00004000
    private let IMAGER_SYMBOL_GS1LIMIT      = 0x00008000
    private let IMAGER_SYMBOL_GS1EXPAND     = 0x00010000
    private let IMAGER_SYMBOL_S2OF5ID       = 0x00020000
    private let IMAGER_SYMBOL_S2OF5IA       = 0x00040000
    private let IMAGER_SYMBOL_TLC39         = 0x00080000
    private let IMAGER_SYMBOL_TELEPEN       = 0x00100000
    private let IMAGER_SYMBOL_TRIOPTIC      = 0x00200000
    private let IMAGER_SYMBOL_UPCA          = 0x00400000
    private let IMAGER_SYMBOL_UPCE0         = 0x00800000
    private let IMAGER_SYMBOL_UPCE1         = 0x01000000

    /* Second */
    private let IMAGER_SYMBOL_AZTECCODE     = 0x00000001
    private let IMAGER_SYMBOL_AZTECRUNES    = 0x00000002
    private let IMAGER_SYMBOL_CODABLOCKF    = 0x00000004
    private let IMAGER_SYMBOL_CODE16K       = 0x00000008
    private let IMAGER_SYMBOL_CODE49        = 0x00000010
    private let IMAGER_SYMBOL_DATAMATRIX    = 0x00000020
    private let IMAGER_SYMBOL_MAXICODE      = 0x00000040
    private let IMAGER_SYMBOL_MICROPDF      = 0x00000080
    private let IMAGER_SYMBOL_PDF417        = 0x00000100
    private let IMAGER_SYMBOL_QRCODE        = 0x00000200
    private let IMAGER_SYMBOL_HANXIN        = 0x00000400

    private let IMAGER_SYMBOL_POSTNET       = 0x00001000
    private let IMAGER_SYMBOL_PLANETCODE    = 0x00002000
    private let IMAGER_SYMBOL_UKPOST        = 0x00004000
    private let IMAGER_SYMBOL_CANADAPOST    = 0x00008000
    private let IMAGER_SYMBOL_KIXPOST       = 0x00010000
    private let IMAGER_SYMBOL_AUSPOST       = 0x00020000
    private let IMAGER_SYMBOL_JAPANPOST     = 0x00040000
    private let IMAGER_SYMBOL_CHINAPOST     = 0x00080000
    private let IMAGER_SYMBOL_KOREAPOST     = 0x00100000

    private let IMAGER_SYMBOL_OCR_MASK      = 0x07000000

    private let IMAGER_SYMBOL_OCROFF        = 0x00000000
    private let IMAGER_SYMBOL_OCRA          = 0x01000000
    private let IMAGER_SYMBOL_OCRB          = 0x02000000
    private let IMAGER_SYMBOL_OCRUSC        = 0x03000000
    private let IMAGER_SYMBOL_OCRMICR       = 0x04000000
    private let IMAGER_SYMBOL_OCRSEMI       = 0x05000000

    private let IMAGER_SYMBOL_MRZ           = 0x01000000
    private let IMAGER_SYMBOL_MRZ_NA        = 0x40000000

    //************************************************************************
    //
    //  Barcode 1D Option
    //
    //************************************************************************
    private let LASER_CODABAR_NO_START_STOP_CHARS   = 0x00000001

    private let LASER_REVERSE_DIRECTION             = 0x00000010

    private let LASER_UPCE_AS_UPCA                  = 0x00000200
    private let LASER_EAN8_AS_EAN13                 = 0x00000400
    private let LASER_UPCE_AS_EAN13                 = 0x00000800

    private let LASER_RETURN_CHECK_DIGIT            = 0x00001000
    private let LASER_VERIFY_CHECK_DIGIT            = 0x00002000
    private let LASER_WIDE_SCAN_ANGLE               = 0x00004000
    private let LASER_HIGH_FILTER_MODE              = 0x00008000

    private let LASER_UPCA_AS_EAN13                 = 0x00080000

    private let LASER_I2OF5_VERIFY_CHECK_DIGIT      = 0x00400000
    private let LASER_CODE39_VERIFY_CHECK_DIGIT     = 0x00800000

    private let LASER_I2OF5_RETURN_CHECK_DIGIT      = 0x04000000
    private let LASER_CODE39_RETURN_CHECK_DIGIT     = 0x08000000

    private let LASER_UPCE_RETURN_CHECK_DIGIT       = 0x10000000
    private let LASER_UPCA_RETURN_CHECK_DIGIT       = 0x20000000
    private let LASER_EAN8_RETURN_CHECK_DIGIT       = 0x40000000
    private let LASER_EAN13_RETURN_CHECK_DIGIT      = 0x80000000

    //************************************************************************
    //
    //  Barcode 2D Option
    //
    //************************************************************************
    /* First */
    private let    CB_TXSTARTSTOP_MASK              = 0x00000001

    private let    CB_CHKDGTNOTX                    = 0x00000002
    private let    CB_CHKDGTTX                      = 0x00000004

    private let    CB_CONCATENATE_ON                = 0x00000008
    private let    CB_CONCATENATE_REQ               = 0x00000010

    private let    C39_TXSTARTSTOP_MASK             = 0x00000100

    private let    C39_CHKDGTNOTX                   = 0x00000200
    private let    C39_CHKDGTTX                     = 0x00000400

    private let    C39_APPEND_MASK                  = 0x00000800
    private let    C39_FULLASCII_MASK               = 0x00001000

    private let    I2OF5_CHKDGTNOTX                 = 0x00010000
    private let    I2OF5_CHKDGTTX                   = 0x00020000

    private let    CODE11_OPTION_MASK               = 0x00100000

    private let    CODE128_OPTION_MASK              = 0x00200000

    private let    TELEPEN_OPTION_MASK              = 0x00400000

    private let    CONV_UPCE_AS_EAN13_MASK          = 0x02000000
    private let    CONV_EAN8_AS_EAN13_MASK          = 0x04000000
    private let    CONV_UPCA_AS_EAN13_MASK          = 0x08000000
    private let    CONV_UPCE_AS_UPCA_MASK           = 0x10000000

    private let    POSI_AB_LMTA_MASK                = 0x40000000
    private let    POSI_AB_LMTB_MASK                = 0x80000000

    /* Second */
    private let    UPCA_VERIFYCHKDGT_MASK           = 0x00000001
    private let    UPCA_NUMBERSYS_MASK              = 0x00000002
    private let    UPCA_2ADDENDA_MASK               = 0x00000004
    private let    UPCA_5ADDENDA_MASK               = 0x00000008
    private let    UPCA_REQADDENDA_MASK             = 0x00000010
    private let    UPCA_ADDENDASEP_MASK             = 0x00000020
    private let    UPCA_COUPONCODE_MASK             = 0x00000040

    private let    UPCE_EXPAND_MASK                 = 0x00000080
    private let    UPCE_REQADDENDA_MASK             = 0x00000100
    private let    UPCE_ADDENDASEP_MASK             = 0x00000200
    private let    UPCE_CHECKDGT_MASK               = 0x00000400
    private let    UPCE_NUMBERSYS_MASK              = 0x00000800
    private let    UPCE_2ADDENDA_MASK               = 0x00001000
    private let    UPCE_5ADDENDA_MASK               = 0x00002000

    private let    E13_VERIFYCHKDGT_MASK            = 0x00004000
    private let    E13_2ADDENDA_MASK                = 0x00008000
    private let    E13_5ADDENDA_MASK                = 0x00010000
    private let    E13_REQADDENDA_MASK              = 0x00020000
    private let    E13_ADDENDASEP_MASK              = 0x00040000
    private let    E13_ISBNTRANS_MASK               = 0x00080000

    private let    POSTNET_OPTION_MASK              = 0x00100000

    private let    PLANET_OPTION_MASK               = 0x00200000

    private let    E8_VERIFYCHKDGT_MASK             = 0x00400000
    private let    E8_2ADDENDA_MASK                 = 0x00800000
    private let    E8_5ADDENDA_MASK                 = 0x01000000
    private let    E8_REQADDENDA_MASK               = 0x02000000
    private let    E8_ADDENDASEP_MASK               = 0x04000000

    private let    MSI_OPTION_MASK                  = 0x08000000

    private let    UPC_EAN_VERSION_MASK             = 0x10000000

    private let    EAN_UCC_128EMUL                  = 0x20000000
    private let    EAN_UCC_RSSEMUL                  = 0x40000000

    
    /* Lazer(1D) Barcode Symbol Map */
    private lazy var lazerBarcodeMap = {
        [
            LASER_SYMBOL_EAN13           : "EAN13",
            LASER_SYMBOL_EAN8            : "EAN8",
            LASER_SYMBOL_UPCA            : "UPCA",
            LASER_SYMBOL_UPCE            : "UPCE",
            LASER_SYMBOL_CODE39          : "CODE39",
            LASER_SYMBOL_ITF14           : "ITF14",
            LASER_SYMBOL_CODE128         : "CODE128",
            LASER_SYMBOL_I2OF5           : "I2OF5",
            LASER_SYMBOL_CODABAR         : "CODABAR",
            LASER_SYMBOL_GS1128          : "GS1128",
            LASER_SYMBOL_CODE93          : "CODE93",
            LASER_SYMBOL_CODE35          : "CODE35",
            
            LASER_SYMBOL_BOOKLAND        : "BOOKLANDEAN",
            LASER_SYMBOL_EAN13_ADDON     : "EAN13WADDON",
            LASER_SYMBOL_EAN8_ADDON      : "EAN8WADDON",
            LASER_SYMBOL_UPCA_ADDON      : "UPCAWADDON",
            LASER_SYMBOL_UPCE_ADDON      : "UPCEWADDON",
            LASER_SYMBOL_GS1OMNI         : "GS1_OMNI",
            LASER_SYMBOL_GS1LIMIT        : "GS1_LIMITED",
            LASER_SYMBOL_GS1EXPAND       : "GS1_EXPANDED",
        ]
    }()

    /* Imager(2D) Barcode Symbol Map */
    // Imager First
    private lazy var imagerFirstBarcodeMap = {
        [
            IMAGER_SYMBOL_CODABAR        : "CODABAR",
            IMAGER_SYMBOL_CODE11         : "CODE11",
            IMAGER_SYMBOL_CODE32         : "CODE32",
            IMAGER_SYMBOL_CODE39         : "CODE39",
            IMAGER_SYMBOL_CODE93         : "CODE93",
            IMAGER_SYMBOL_CODE128        : "CODE128",
            IMAGER_SYMBOL_EAN8           : "EAN8",
            IMAGER_SYMBOL_EAN13          : "EAN13",
            IMAGER_SYMBOL_GS1128         : "GS1128",
            IMAGER_SYMBOL_I2OF5          : "I2OF5",
            
            IMAGER_SYMBOL_MATRIX2OF5     : "MATRIX2OF5",
            IMAGER_SYMBOL_MSI            : "MSI",
            IMAGER_SYMBOL_PLESSEY        : "PLESSEY",
            IMAGER_SYMBOL_POSICODE       : "POSICODE",
            IMAGER_SYMBOL_GS1OMNI        : "GS1_OMNI",
            IMAGER_SYMBOL_GS1LIMIT       : "GS1_LIMITED",
            IMAGER_SYMBOL_GS1EXPAND      : "GS1_EXPANDED",
            IMAGER_SYMBOL_S2OF5ID        : "S2OF5IND",
            IMAGER_SYMBOL_S2OF5IA        : "S2OF5IATA",
            IMAGER_SYMBOL_TLC39          : "TLC39",
            
            IMAGER_SYMBOL_TELEPEN        : "TELEPEN",
            IMAGER_SYMBOL_TRIOPTIC       : "TRIOPTIC",
            IMAGER_SYMBOL_UPCA           : "UPCA",
            IMAGER_SYMBOL_UPCE0          : "UPCE0",
            IMAGER_SYMBOL_UPCE1          : "UPCE1",
        ]
    }()
    
    // Imager Second
    private lazy var imagerSecondBarcodeMap = {
        [
            IMAGER_SYMBOL_AZTECCODE      : "AZTEC_CODE",
            IMAGER_SYMBOL_AZTECRUNES     : "AZTEC_RUNES",
            IMAGER_SYMBOL_CODABLOCKF     : "CODABLOCK_F",
            IMAGER_SYMBOL_CODE16K        : "CODE16K",
            IMAGER_SYMBOL_CODE49         : "CODE49",
            IMAGER_SYMBOL_DATAMATRIX     : "DATA_MATRIX",
            IMAGER_SYMBOL_MAXICODE       : "MAXICODE",
            IMAGER_SYMBOL_MICROPDF       : "MICROPDF417",
            IMAGER_SYMBOL_PDF417         : "PDF417",
            IMAGER_SYMBOL_QRCODE         : "QR_CODE",
            IMAGER_SYMBOL_HANXIN         : "HANXIN",
            
            IMAGER_SYMBOL_POSTNET        : "POSTNET",
            IMAGER_SYMBOL_PLANETCODE     : "PLANET_CODE",
            IMAGER_SYMBOL_UKPOST         : "BRITISH_POST",
            IMAGER_SYMBOL_CANADAPOST     : "CANADIAN_POST",
            IMAGER_SYMBOL_KIXPOST        : "KIX_POST",
            IMAGER_SYMBOL_AUSPOST        : "AUSTRALIAN_POST",
            IMAGER_SYMBOL_JAPANPOST      : "JAPANESE_POST",
            IMAGER_SYMBOL_CHINAPOST      : "CHINA_POST",
            IMAGER_SYMBOL_KOREAPOST      : "KOREA_POST",
        ]
    }()
    
    // OCR
    private lazy var imagerOCRMap = {
        [
            IMAGER_SYMBOL_OCROFF         : "OCR_OFF",
            IMAGER_SYMBOL_OCRA           : "OCR_A",
            IMAGER_SYMBOL_OCRB           : "OCR_B",
            IMAGER_SYMBOL_OCRUSC         : "OCR_US_CURRENCY",
            IMAGER_SYMBOL_OCRMICR        : "OCR_MICR_E13B",
            IMAGER_SYMBOL_OCRSEMI        : "OCR_SEMI_FONT",
        ]
    }()
    
    // MRZ
    private lazy var imagerMRZMap = {
        [
            IMAGER_SYMBOL_MRZ            : "MRZ",
        ]
    }()
    
    // MRZ NA(New Architecture Model)
    private lazy var imagerMRZNAMap = {
        [
            IMAGER_SYMBOL_MRZ_NA         : "MRZ",
        ]
    }()

    /* Lazer(1D) Barcode Symbol Inverse Map */
    private lazy var lazerBarcodeInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(lazerBarcodeMap.values, lazerBarcodeMap.keys))
    }()

    /* Imager(2D) Barcode Symbol Inverse Map */
    // Imager First Barcode Inverse Map
    private lazy var imagerFirstBarcodeInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(imagerFirstBarcodeMap.values, imagerFirstBarcodeMap.keys))
    }()
    
    // Imager Second Barcode Inverse Map
    private lazy var imagerSecondBarcodeInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(imagerSecondBarcodeMap.values, imagerSecondBarcodeMap.keys))
    }()
    
    // OCR Inverse Map
    private lazy var imagerOCRInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(imagerOCRMap.values, imagerOCRMap.keys))
    }()

    // MRZ Inverse Map
    private lazy var imagerMRZInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(imagerMRZMap.values, imagerMRZMap.keys))
    }()

    // MRZ NA Inverse Map
    private lazy var imagerMRZNAInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(imagerMRZNAMap.values, imagerMRZNAMap.keys))
    }()
    
    /* Lazer(1D) Barcode Option Map */
    private lazy var lazerOptionMap = {
        [
            LASER_CODABAR_NO_START_STOP_CHARS        : "CODABAR_NO_START_STOP_CHARS",
            
            LASER_REVERSE_DIRECTION                  : "REVERSE_DIRECTION",
            
            LASER_UPCE_AS_UPCA                       : "UPCE_AS_UPCA",
            LASER_EAN8_AS_EAN13                      : "EAN8_AS_EAN13",
            LASER_UPCE_AS_EAN13                      : "UPCE_AS_EAN13",
            
            LASER_RETURN_CHECK_DIGIT                 : "RETURN_CHECK_DIGIT",
            LASER_VERIFY_CHECK_DIGIT                 : "VERIFY_CHECK_DIGIT",
            LASER_WIDE_SCAN_ANGLE                    : "WIDE_SCAN_ANGLE",
            LASER_HIGH_FILTER_MODE                   : "HIGH_FILTER_MODE",
            
            LASER_UPCA_AS_EAN13                      : "UPCA_AS_EAN13",
            
            LASER_I2OF5_VERIFY_CHECK_DIGIT           : "I2OF5_VERIFY_CHECK_DIGIT",
            LASER_CODE39_VERIFY_CHECK_DIGIT          : "CODE39_VERIFY_CHECK_DIGIT",
            
            LASER_I2OF5_RETURN_CHECK_DIGIT           : "I2OF5_RETURN_CHECK_DIGIT",
            LASER_CODE39_RETURN_CHECK_DIGIT          : "CODE39_RETURN_CHECK_DIGIT",
            
            LASER_UPCE_RETURN_CHECK_DIGIT            : "UPCE_RETURN_CHECK_DIGITRZ",
            LASER_UPCA_RETURN_CHECK_DIGIT            : "UPCA_RETURN_CHECK_DIGIT",
            LASER_EAN8_RETURN_CHECK_DIGIT            : "EAN8_RETURN_CHECK_DIGIT",
            LASER_EAN13_RETURN_CHECK_DIGIT           : "EAN13_RETURN_CHECK_DIGIT",
        ]
    }()

    /* Imager(2D) Barcode Option Map */
    // Iamger First
    private lazy var imagerFirstOptionMap = {
        [
            CB_TXSTARTSTOP_MASK                      : "CODABAR_TRANSMIT_START_STOP",
            
            CB_CHKDGTNOTX                            : "CODABAR_CHECK_DIGIT_VERIFY_NO_TRANSMIT",
            CB_CHKDGTTX                              : "CODABAR_CHECK_DIGIT_VERIFY_TRANSMIT",
            
            CB_CONCATENATE_ON                        : "CODABAR_CONCATENATION_ON",
            CB_CONCATENATE_REQ                       : "CODABAR_CONCATENATION_REQUIRE",
            
            C39_TXSTARTSTOP_MASK                     : "CODE39_TRANSMIT_START_STOP",

            C39_CHKDGTNOTX                           : "CODE39_CHECK_DIGIT_VERIFY_NO_TRANSMIT",
            C39_CHKDGTTX                             : "CODE39_CHECK_DIGIT_VERIFY_TRANSMIT",
            
            C39_APPEND_MASK                          : "CODE39_APPEND_ON",
            C39_FULLASCII_MASK                       : "CODE39_FULL_ASCII_ON",
            
            I2OF5_CHKDGTNOTX                         : "I2OF5_CHECK_DIGIT_VERIFY_NO_TRANSMIT",
            I2OF5_CHKDGTTX                           : "I2OF5_CHECK_DIGIT_VERIFY_TRANSMIT",
            
            CODE11_OPTION_MASK                       : "CODE11_CHECK_DIGIT",
            
            CODE128_OPTION_MASK                      : "CODE128_ISBT_CONCATENATION_ON",
            
            TELEPEN_OPTION_MASK                      : "TELEPEN_AIM_OUTPUT_AIM",
            
            CONV_UPCE_AS_EAN13_MASK                  : "UPCE_AS_EAN13",
            CONV_EAN8_AS_EAN13_MASK                  : "EAN8_AS_EAN13",
            CONV_UPCA_AS_EAN13_MASK                  : "UPCA_AS_EAN13",
            CONV_UPCE_AS_UPCA_MASK                   : "UPCE_AS_UPCA",
            
            POSI_AB_LMTA_MASK                        : "POSI_CODE_AB_LIMITED_A_ON",
            POSI_AB_LMTB_MASK                        : "POSI_CODE_AB_LIMITED_B_ON",
        ]
    }()
    
    // Imager Second
    private lazy var imagerSecondOptionMap = {
        [
            UPCA_VERIFYCHKDGT_MASK                   : "UPCA_CHECK_DIGIT_VERIFY",
            UPCA_NUMBERSYS_MASK                      : "UPCA_NUMBER_SYSTEM_ON",
            UPCA_2ADDENDA_MASK                       : "UPCA_2DIGIT_ADDENDA_ON",
            UPCA_5ADDENDA_MASK                       : "UPCA_5DIGIT_ADDENDA_ON",
            UPCA_REQADDENDA_MASK                     : "UPCA_ADDENDA_REQUIRED",
            UPCA_ADDENDASEP_MASK                     : "UPCA_ADDENDA_SEPARATOR_ON",
            UPCA_COUPONCODE_MASK                     : "UPCA_EXTENDED_COUPON_CODE_ON",
            
            UPCE_EXPAND_MASK                         : "UPCE_EXPAND_ON",
            UPCE_REQADDENDA_MASK                     : "UPCE_ADDENDA_REQUIRED",
            UPCE_ADDENDASEP_MASK                     : "UPCE_ADDENDA_SEPARATOR_ON",
            UPCE_CHECKDGT_MASK                       : "UPCE_CHECK_DIGIT_ON",
            UPCE_NUMBERSYS_MASK                      : "UPCE_NUMBER_SYSTEM_ON",
            UPCE_2ADDENDA_MASK                       : "UPCE_2DIGIT_ADDENDA_ON",
            UPCE_5ADDENDA_MASK                       : "UPCE_5DIGIT_ADDENDA_ON",
            
            E13_VERIFYCHKDGT_MASK                    : "EAN13_CHECK_DIGIT_VERIFY",
            E13_2ADDENDA_MASK                        : "EAN13_2DIGIT_ADDENDA_ON",
            E13_5ADDENDA_MASK                        : "EAN13_5DIGIT_ADDENDA_ON",
            E13_REQADDENDA_MASK                      : "EAN13_ADDENDA_REQUIRED",
            E13_ADDENDASEP_MASK                      : "EAN13_ADDENDA_SEPARATOR_ON",
            E13_ISBNTRANS_MASK                       : "EAN13_ISBN_TRANSLATOR_ON",
            
            POSTNET_OPTION_MASK                      : "POSTNET_CHECK_DIGIT_TRANSMIT",
            
            PLANET_OPTION_MASK                       : "PLANETCODE_CHECK_DIGIT_TRANSMIT",
            
            E8_VERIFYCHKDGT_MASK                     : "EAN8_VERIFY_CHECK_DIGIT",
            E8_2ADDENDA_MASK                         : "EAN8_2DIGIT_ADDENDA_ON",
            E8_5ADDENDA_MASK                         : "EAN8_5DIGIT_ADDENDA_ON",
            E8_REQADDENDA_MASK                       : "EAN8_ADDENDA_REQUIRED",
            E8_ADDENDASEP_MASK                       : "EAN8_ADDENDA_SEPARATOR_ON",

            MSI_OPTION_MASK                          : "MSI_VERIFY_CHECK_CHARACTER_TRANSMIT",
            
            UPC_EAN_VERSION_MASK                     : "MSI_VERSION_ON",
            
            EAN_UCC_128EMUL                          : "MSI_128_EMULATION",
            EAN_UCC_RSSEMUL                          : "MSI_RSS_EMULATION",
        ]
    }()

    /* Lazer(1D) Barcode Option Inverse Map */
    private lazy var lazerOptionInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(lazerOptionMap.values, lazerOptionMap.keys))
    }()

    /* Imager(2D) Barcode Option Inverse Map */
    // Imager First Option Inverse Map
    private lazy var imagerFirstOptionInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(imagerFirstOptionMap.values, imagerFirstOptionMap.keys))
    }()
    
    // Imager Second Option Inverse Map
    private lazy var imagerSecondOptionInverseMap = {
        Dictionary<String, Int>(uniqueKeysWithValues:
                    zip(imagerSecondOptionMap.values, imagerSecondOptionMap.keys))
    }()
    
    override init(reader: KDCReader, converter: KConverter) {
        super.init(reader: reader, converter: converter)
                
        self.SUPPORTED_ACTIONS.append(contentsOf: [
            GET_DATA_PREFIX,
            SET_DATA_PREFIX,
            
            GET_DATA_SUFFIX,
            SET_DATA_SUFFIX,
            
            GET_SYMBOLOGY,
            SET_SYMBOLOGY,
            ENABLE_ALL_SYMBOLOGY,
            DISABLE_ALL_SYMBOLOGY,
            
            GET_BARCODE_OPTION,
            SET_BARCODE_OPTION,
            ENABLE_ALL_OPTIONS,
            DISABLE_ALL_OPTIONS,
            
            GET_MINIMUM_BARCODE_LENGTH,
            SET_MINIMUM_BARCODE_LENGTH,
            
            GET_NUMBER_OF_STORED_BARCODE,
            
            GET_STORED_DATA_SINGLE,
            
            GET_DATA_FORMAT,
            SET_DATA_FORMAT,
            
            GET_DATA_PROCESS_MODE,
            SET_DATA_PROCESS_MODE,
            
            GET_SECURITY_LEVEL,
            SET_SECURITY_LEVEL,
            
            ENABLE_AGE_VERIFY,
            IS_AGE_VERIFY_ENABLED,
            
            GET_AIMID_SETTING,
            SET_AIMID_SETTING,
            
            GET_PARTIAL_DATA_START_POSITION,
            SET_PARTIAL_DATA_START_POSITION,
            
            GET_PARTIAL_DATA_LENGTH,
            SET_PARTIAL_DATA_LENGTH,
            
            GET_PARTIAL_DATA_ACTION,
            SET_PARTIAL_DATA_ACTION,
            
            START_SYNCHRONIZATION,
            FINISH_SYNCHRONIZATION,
            
            GET_DATA_TERMINATOR,
            SET_DATA_TERMINATOR,
        ])
    }
    
    override func run(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> Bool {
        guard isConnected() else {
            sendErrorResult(KConstants.ErrorCode.NOT_CONNECTED, result:result)
            return true
        }
        
        switch call.method {
        case GET_DATA_PREFIX:
            getDataPrefix(call, result: result)
            
        case SET_DATA_PREFIX:
            setDataPrefix(call, result: result)

        case GET_DATA_SUFFIX:
            getDataSuffix(call, result: result)
            
        case SET_DATA_SUFFIX:
            setDataSuffix(call, result: result)

        case GET_SYMBOLOGY:
            getSymbology(call, result: result)
            
        case SET_SYMBOLOGY:
            setSymbology(call, result: result)
            
        case ENABLE_ALL_SYMBOLOGY:
            enableAllSymbology(call, result: result)
            
        case DISABLE_ALL_SYMBOLOGY:
            disableAllSymbology(call, result: result)

        case GET_BARCODE_OPTION:
            getBarcodeOption(call, result: result)
            
        case SET_BARCODE_OPTION:
            setBarcodeOption(call, result: result)
            
        case ENABLE_ALL_OPTIONS:
            enableAllOptions(call, result: result)
            
        case DISABLE_ALL_OPTIONS:
            disableAllOptions(call, result: result)

        case GET_MINIMUM_BARCODE_LENGTH:
            getMinimumBarcodeLength(call, result: result)
            
        case SET_MINIMUM_BARCODE_LENGTH:
            setMinimumBarcodeLength(call, result: result)

        case GET_NUMBER_OF_STORED_BARCODE:
            getNumberOfStoredBarcode(call, result: result)

        case GET_STORED_DATA_SINGLE:
            getStoredDataSingle(call, result: result)

        case GET_DATA_FORMAT:
            getDataFormat(call, result: result)
            
        case SET_DATA_FORMAT:
            setDataFormat(call, result: result)

        case GET_DATA_PROCESS_MODE:
            getDataProcessMode(call, result: result)
            
        case SET_DATA_PROCESS_MODE:
            setDataProcessMode(call, result: result)

        case GET_SECURITY_LEVEL:
            getSecurityLevel(call, result: result)
            
        case SET_SECURITY_LEVEL:
            setSecurityLevel(call, result: result)

        case ENABLE_AGE_VERIFY:
            enableAgeVerify(call, result: result)
            
        case IS_AGE_VERIFY_ENABLED:
            isAgeVerifyEnabled(call, result: result)

        case GET_AIMID_SETTING:
            getAIMIDSetting(call, result: result)
            
        case SET_AIMID_SETTING:
            setAIMIDSetting(call, result: result)

        case GET_PARTIAL_DATA_START_POSITION:
            getPartialDataStartPosition(call, result: result)
            
        case SET_PARTIAL_DATA_START_POSITION:
            setPartialDataStartPosition(call, result: result)

        case GET_PARTIAL_DATA_LENGTH:
            getPartialDataLength(call, result: result)
            
        case SET_PARTIAL_DATA_LENGTH:
            setPartialDataLength(call, result: result)

        case GET_PARTIAL_DATA_ACTION:
            getPartialDataAction(call, result: result)
            
        case SET_PARTIAL_DATA_ACTION:
            setPartialDataAction(call, result: result)

        case START_SYNCHRONIZATION:
            startSynchronization(call, result: result)
            
        case FINISH_SYNCHRONIZATION:
            finishSynchronization(call, result: result)

        case GET_DATA_TERMINATOR:
            getDataTerminator(call, result: result)
            
        case SET_DATA_TERMINATOR:
            setDataTerminator(call, result: result)

        default:
            break
        }
        
        return true
    }
    
    private func getDataPrefix(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let prefix = reader.getDataPrefix() {
            result(String(cString: prefix))
        } else {
            result(KConstants.EMPTY_STRING)
        }
    }
    
    private func setDataPrefix(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, Any>
        let prefix = args?[PARAM_NAME_PREFIX] as? String ?? KConstants.EMPTY_STRING
        
        let bRet = reader.setDataPrefix(
            UnsafeMutablePointer<Int8>.init(mutating: (prefix as NSString).utf8String)
        )
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getDataSuffix(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let suffix = reader.getDataSuffix() {
            result(String(cString: suffix))
        } else {
            result(KConstants.EMPTY_STRING)
        }
    }

    private func setDataSuffix(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, Any>
        let prefix = args?[PARAM_NAME_SUFFIX] as? String ?? KConstants.EMPTY_STRING
        
        let bRet = reader.setDataSuffix(
            UnsafeMutablePointer<Int8>.init(mutating: (prefix as NSString).utf8String)
        )
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getSymbology(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let symbol = reader.getSymbology()
        
        var dict = [String: Bool]()
        
        if reader.isModel2D() {
            let mrzMode = reader.getMRZMode()
            let mrzMap = if reader.isNewArchitectureModel() { imagerMRZNAMap } else { imagerMRZMap }

            // First Symbol
            imagerFirstBarcodeMap.forEach { (key: Int, value: String) in
                dict[value] = (symbol.FirstSymbols & UInt32(key)) > 0
            }

            // Second Symbol
            imagerSecondBarcodeMap.forEach { (key: Int, value: String) in
                dict[value] = (symbol.SecondSymbols & UInt32(key)) > 0
            }

            // OCR
            if mrzMode == .MODE_OCR || mrzMode == .MODE_OCR_MRZ {
                imagerOCRMap.forEach { (key: Int, value: String) in
                    dict[value] = (Int(symbol.SecondSymbols) & IMAGER_SYMBOL_OCR_MASK) == key
                }
            }

            // MRZ
            if mrzMode == .MODE_MRZ || mrzMode == .MODE_OCR_MRZ {
                mrzMap.forEach { (key: Int, value: String) in
                    dict[value] = (symbol.SecondSymbols & UInt32(key)) > 0
                }
            }
        } else {
            lazerBarcodeMap.forEach { (key: Int, value: String) in
                dict[value] = (symbol.FirstSymbols & UInt32(key)) > 0
            }
        }

        result(dict)
    }

    private func setSymbology(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let syms = args[PARAM_NAME_SYMBOLS] as? Dictionary<String, Bool?> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }

        var symbol = reader.getSymbology()
        
        if reader.isModel2D() {
            let mrzMode = reader.getMRZMode()
            let mrzMap = if reader.isNewArchitectureModel() { imagerMRZNAInverseMap } else { imagerMRZInverseMap }
            
            syms.forEach { (key: String, value: Bool?) in
                if let isEnable = value {
                    if let symbolValue = imagerFirstBarcodeInverseMap[key] {
                        if isEnable {
                            symbol.FirstSymbols = symbol.FirstSymbols | UInt32(symbolValue)
                        } else {
                            symbol.FirstSymbols = symbol.FirstSymbols & ~UInt32(symbolValue)
                        }
                    }

                    if let symbolValue = imagerSecondBarcodeInverseMap[key] {
                        if isEnable {
                            symbol.SecondSymbols = symbol.SecondSymbols | UInt32(symbolValue)
                        } else {
                            symbol.SecondSymbols = symbol.SecondSymbols & ~UInt32(symbolValue)
                        }
                    }

                    // OCR
                    if let symbolValue = imagerOCRInverseMap[key] {
                        if mrzMode == .MODE_OCR || mrzMode == .MODE_OCR_MRZ {
                            symbol.SecondSymbols = symbol.SecondSymbols & ~UInt32(IMAGER_SYMBOL_OCR_MASK)

                            if isEnable {
                                symbol.SecondSymbols = symbol.SecondSymbols | UInt32(symbolValue);
                            }
                        }
                    }
                    
                    // MRZ
                    if let symbolValue = mrzMap[key] {
                        if mrzMode == .MODE_MRZ || mrzMode == .MODE_OCR_MRZ {
                            if isEnable {
                                symbol.SecondSymbols = symbol.SecondSymbols | UInt32(symbolValue)
                            } else {
                                symbol.SecondSymbols = symbol.SecondSymbols & ~UInt32(symbolValue)
                            }
                        }
                    }
                }
            }
        } else {
            syms.forEach { (key: String, value: Bool?) in
                if let isEnable = value, let symbolValue = lazerBarcodeInverseMap[key] {
                    if isEnable {
                        symbol.FirstSymbols = symbol.FirstSymbols | UInt32(symbolValue)
                    } else {
                        symbol.FirstSymbols = symbol.FirstSymbols & ~UInt32(symbolValue)
                    }
                }
            }
        }
        let bRet = reader.setSymbology(symbol)

        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func enableAllSymbology(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.enableAllSymbologies()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func disableAllSymbology(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.disableAllSymbologies()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getBarcodeOption(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let option = reader.getBarcodeOption()
        
        var dict = [String: Bool]()
        
        if reader.isModel2D() {
            // First Option
            imagerFirstOptionMap.forEach { (key: Int, value: String) in
                dict[value] = (option.FirstOptions & UInt32(key)) > 0
            }

            // Second Option
            imagerSecondOptionMap.forEach { (key: Int, value: String) in
                dict[value] = (option.FirstOptions & UInt32(key)) > 0
            }
        } else {
            
            lazerOptionMap.forEach { (key: Int, value: String) in
                dict[value] = (option.FirstOptions & UInt32(key)) > 0
            }
        }
    
        result(dict)
    }

    private func setBarcodeOption(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let opts = args[PARAM_NAME_OPTIONS] as? Dictionary<String, Bool?> else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        var option = reader.getBarcodeOption()
        
        if reader.isModel2D() {
            opts.forEach { (key: String, value: Bool?) in
                if let isEnable = value {
                    // First Option
                    if let optionValue = imagerFirstOptionInverseMap[key] {
                        if isEnable {
                            option.FirstOptions = option.FirstOptions | UInt32(optionValue)
                        } else {
                            option.FirstOptions = option.FirstOptions & ~UInt32(optionValue)
                        }
                    }
                  
                    // Second Option
                    if let optionValue = imagerSecondOptionInverseMap[key] {
                        if isEnable {
                            option.SecondOptions = option.SecondOptions | UInt32(optionValue)
                        } else {
                            option.SecondOptions = option.SecondOptions & ~UInt32(optionValue)
                        }
                    }
                }
            }
        } else {
            opts.forEach { (key: String, value: Bool?) in
                if let isEnable = value, let optionValue = lazerOptionInverseMap[key] {
                    if isEnable {
                        option.FirstOptions = option.FirstOptions | UInt32(optionValue)
                    } else {
                        option.FirstOptions = option.FirstOptions & ~UInt32(optionValue)
                    }
                }
            }
        }

        let bRet = reader.setBarcodeOption(option)

        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func enableAllOptions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.enableAllOptions()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func disableAllOptions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.disableAllOptions()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getMinimumBarcodeLength(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let length = reader.getMinimumBarcodeLength()
        
        if length > -1 {
            result(length)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setMinimumBarcodeLength(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let length = args[PARAM_NAME_LENGTH] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setMinimumBarcodeLength(Int32(length))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getNumberOfStoredBarcode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let size = reader.getNumberOfStoredBarcode()
        
        if size > -1 {
            result(size)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getStoredDataSingle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        reader.getStoredDataSingle()
        result(true)
    }

    private func getDataFormat(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let format = reader.getDataFormat()
        
        if let _ = DataFormat(rawValue: Int(format)) {
            result(format)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setDataFormat(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_FORMAT] as? Int,
              let format = DataFormat(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setDataFormat(Int32(format.rawValue))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getDataProcessMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let mode = reader.getDataProcessMode().rawValue
        
        if let _ = WedgeMode(rawValue: mode) {
            result(mode)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setDataProcessMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_MODE] as? Int,
              let mode = WedgeMode(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setDataProcessMode(mode)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getSecurityLevel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let level = reader.getSecurityLevel()
        
        if level > -1 {
            result(level)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setSecurityLevel(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let level = args[PARAM_NAME_LEVEL] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setSecurityLevel(Int32(level))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func enableAgeVerify(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let enable = args[PARAM_NAME_ENABLE] as? Bool else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.enableAgeVerify(enable ? .ENABLE : .DISABLE)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func isAgeVerifyEnabled(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let enable = reader.isAgeVerifyEnabled()
        result(enable == .ENABLE)
    }

    private func getAIMIDSetting(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let status = reader.getAIMIDSetting().rawValue
        
        if let _ = AIMID(rawValue: status) {
            result(status)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
    
    private func setAIMIDSetting(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_AIMID] as? Int,
              let status = AIMID(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setAIMIDSetting(status)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getPartialDataStartPosition(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let position = reader.getPartialDataStartPosition()
        
        if position > -1 {
            result(position)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setPartialDataStartPosition(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let position = args[PARAM_NAME_POSITION] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setPartialDataStartPosition(Int32(position))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getPartialDataLength(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let length = reader.getPartialDataLength()
        
        if length > -1 {
            result(length)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setPartialDataLength(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let length = args[PARAM_NAME_LENGTH] as? Int else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setPartialDataLength(Int32(length))
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getPartialDataAction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let action = reader.getPartialDataAction().rawValue
        
        if let _ = PartialAction(rawValue: action) {
            result(action)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setPartialDataAction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_ACTION] as? Int,
              let action = PartialAction(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setPartialDataAction(action)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func startSynchronization(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.startSynchronization()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func finishSynchronization(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let bRet = reader.finishSynchronization()
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func getDataTerminator(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let terminator = reader.getDataTerminator().rawValue
        
        if let _ = DataTerminator(rawValue: terminator) {
            result(terminator)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }

    private func setDataTerminator(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? Dictionary<String, Any>,
              let v = args[PARAM_NAME_TERMINATOR] as? Int,
              let terminator = DataTerminator(rawValue: v) else {
            sendErrorResult(KConstants.ErrorCode.INVALID_PARAMETER, result:result)
            return
        }
        
        let bRet = reader.setDataTerminator(terminator)
        
        if bRet {
            result(true)
        } else {
            sendErrorResult(KConstants.ErrorCode.FAILED, result: result)
        }
    }
}
