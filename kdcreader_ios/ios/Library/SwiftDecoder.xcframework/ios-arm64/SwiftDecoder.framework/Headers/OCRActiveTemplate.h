/* HONEYWELL CONFIDENTIAL AND PROPRIETARY!
 *
 * SwiftDecoder Mobile Decoding Software
 * 2015 Hand Held Products, Inc. d/b/a
 * Honeywell Scanning and Mobility
 * Patent(s): https://www.honeywellaidc.com/Pages/patents.aspx
 */

/**
 *  @brief This enumeration represents all available OCR templates.
 */
typedef enum
{
    /** @brief This is the user defined OCR template*/
    OCR_USER                        = 1,
    /** @brief This is the internally defined Passport template */
    OCR_PASSPORT                    = 2,
    /** @brief This is the internally defined ISBN template */
    OCR_ISBN                        = 4,
    /** @brief This is the internally defined Price Field template */
    OCR_PRICE_FIELD                 = 8,
    /** @brief This is the internally defined MICR template */
    OCR_MICR                        = 16,
    
    OCR_PRICE_LABEL = 0x00010000,

    //Subtypes for Price Label
    OCR_PRICE_LABEL_TYPE1 = 1,
    OCR_PRICE_LABEL_TYPE2 = 2,
    //Support for Advanced template based OCR detection
    OCR_ADVANCED_TEMPLATE     = 0x00020000
}OCRActiveTemplate;
