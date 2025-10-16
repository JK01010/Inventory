import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode/barcode.dart';

import '../../../../../core/constants/app_enum.dart';
import '../../../domain/entities/grn_create_label_entity.dart';

Future<Uint8List> generateBarcodesPdf({
  required List<GRNCreateLabelEntity> grnCreateLabelEntity,
  required PrintMode? selectedPrintMode,
  required String? labelType,
  required String? printPosition,
}) async {
  final pdf = pw.Document();
  debugPrint('selectedPrintMode: $selectedPrintMode');
  debugPrint('labelType: $labelType');
  debugPrint('printPosition: $printPosition');

  final effectiveLabelType=labelType??'1.5in*3.5in';

  for (int i = 0; i < grnCreateLabelEntity.length; i += 3) {
    final items = [
      grnCreateLabelEntity[i],
      i + 1 < grnCreateLabelEntity.length ? grnCreateLabelEntity[i + 1] : null,
      i + 2 < grnCreateLabelEntity.length ? grnCreateLabelEntity[i + 2] : null,
    ];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(0),
            child: pw.Column(
              children: [
                pw.Center(
                  child: pw.Text(
                    'PRODUCT LABELS',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),

                _buildLabelRow(items[0]!, selectedPrintMode),
                pw.SizedBox(height: 15),

                // Divider
                if (items[1] != null)
                  pw.Divider(thickness: 0.5, color: PdfColors.grey300),
                if (items[1] != null) pw.SizedBox(height: 15),

                // Second item
                if (items[1] != null)
                  _buildLabelRow(items[1]!, selectedPrintMode),
                if (items[1] != null) pw.SizedBox(height: 15),
                if (items[1] != null && items[2] != null)
                  pw.Divider(thickness: 0.5, color: PdfColors.grey300),
                if (items[1] != null && items[2] != null)
                  pw.SizedBox(height: 15),

                // Third item
                if (items[2] != null)
                  _buildLabelRow(items[2]!, selectedPrintMode),

                // Print mode indicator at bottom
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Generated with: ${selectedPrintMode?.name.toUpperCase() ?? 'BARCODE'}',
                    style: pw.TextStyle(fontSize: 9, color: PdfColors.grey),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  return pdf.save();
}

pw.Row _buildLabelRow(
  GRNCreateLabelEntity labelData,
  PrintMode? selectedPrintMode,
) {
  final String barcodeData = labelData.partNumber.isNotEmpty
      ? labelData.partNumber
      : labelData.articleCode;

  final Barcode barcode = selectedPrintMode == PrintMode.qrCode
      ? Barcode.qrCode()
      : Barcode.code128();

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Barcode/QR Code Section (Left)
      pw.Container(
        width: 120,
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.BarcodeWidget(
              barcode: barcode,
              data: barcodeData.length > 30
                  ? barcodeData.substring(0, 30)
                  : barcodeData,
              height: 100,
            ),
            pw.SizedBox(height: 6),
            pw.Text(
              _truncateText(barcodeData, 20),
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
              maxLines: 2,
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              _truncateText(labelData.itemName, 25),
              style: pw.TextStyle(fontSize: 9),
              textAlign: pw.TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),

      pw.SizedBox(width: 10),

      pw.Expanded(
        child: pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey, width: 0.5),
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'PRODUCT INFO',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue700,
                ),
              ),
              pw.SizedBox(height: 6),

              // Two-column layout for details
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left column of details
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildCompactInfoRow(
                          'ID:',
                          labelData.itemId.toString(),
                          15,
                        ),
                        _buildCompactInfoRow(
                          'Art Code:',
                          _truncateText(labelData.articleCode, 20),
                          20,
                        ),
                        _buildCompactInfoRow(
                          'UOM:',
                          _truncateText(labelData.uom, 15),
                          15,
                        ),
                        if (labelData.partNumber.isNotEmpty)
                          _buildCompactInfoRow(
                            'Part No:',
                            _truncateText(labelData.partNumber, 20),
                            20,
                          ),
                        _buildCompactInfoRow(
                          'Name:',
                          _truncateText(labelData.itemName, 25),
                          25,
                        ),
                        if (labelData.drawingNumber.isNotEmpty)
                          _buildCompactInfoRow(
                            'Draw No:',
                            _truncateText(labelData.drawingNumber, 15),
                            15,
                          ),
                        if (labelData.drawingPositionNumber.isNotEmpty)
                          _buildCompactInfoRow(
                            'Draw Pos:',
                            _truncateText(labelData.drawingPositionNumber, 15),
                            15,
                          ),
                        if (labelData.storageLocationName.isNotEmpty)
                          _buildCompactInfoRow(
                            'Storage:',
                            _truncateText(labelData.storageLocationName, 20),
                            20,
                          ),
                        if (labelData.serialNumber.isNotEmpty)
                          _buildCompactInfoRow(
                            'Serial:',
                            _truncateText(labelData.serialNumber, 15),
                            15,
                          ),
                        _buildCompactInfoRow(
                          'GRN:',
                          labelData.grnHdId.toString(),
                          15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

pw.Row _buildCompactInfoRow(String label, String value, int maxChars) {
  final displayValue = value.length > maxChars
      ? '${value.substring(0, maxChars)}...'
      : value;

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: 45, // Fixed width for labels
        child: pw.Text(
          label,
          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.SizedBox(width: 3),
      pw.Expanded(
        child: pw.Text(
          displayValue,
          style: pw.TextStyle(fontSize: 9),
          maxLines: 2,
          overflow: pw.TextOverflow.span,
        ),
      ),
    ],
  );
}

String _truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  }
  return '${text.substring(0, maxLength)}...';
}

/*Future<Uint8List> generateBarcodesPdf({
  required List<GRNCreateLabelEntity> grnCreateLabelEntity,
  required PrintMode? selectedPrintMode,
}) async {
  final pdf = pw.Document();
  debugPrint('selectedPrintMode: $selectedPrintMode');

  // Sample data (remove this if you're passing actual data)
  grnCreateLabelEntity = [
    GRNCreateLabelEntity(
      itemId: 50135090,
      articleCode: "000029",
      itemName: "Marc TmT E",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "ERT NEWT",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 1',
      serialNumber: '',
      grnHdId: 48204,
    ),
    GRNCreateLabelEntity(
      itemId: 2016222060918155,
      articleCode: "000099",
      itemName: "Tester123",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 2',
      serialNumber: 'SN123456',
      grnHdId: 48204,
    ),
    GRNCreateLabelEntity(
      itemId: 50135090,
      articleCode: "000029",
      itemName: "Marc TmT E",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "ERT NEWT",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 1',
      serialNumber: '',
      grnHdId: 48204,
    ),
    GRNCreateLabelEntity(
      itemId: 2016222060918155,
      articleCode: "000099",
      itemName: "Tester123",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 2',
      serialNumber: 'SN123456',
      grnHdId: 48204,
    ),
    GRNCreateLabelEntity(
      itemId: 50135090,
      articleCode: "000029",
      itemName: "Marc TmT E",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "ERT NEWT",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 1',
      serialNumber: '',
      grnHdId: 48204,
    ),
    GRNCreateLabelEntity(
      itemId: 2016222060918155,
      articleCode: "000099",
      itemName: "Tester123",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 2',
      serialNumber: 'SN123456',
      grnHdId: 48204,
    ),
    GRNCreateLabelEntity(
      itemId: 50135090,
      articleCode: "000029",
      itemName: "Marc TmT E",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "ERT NEWT",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 1',
      serialNumber: '',
      grnHdId: 48204,
    ),
    GRNCreateLabelEntity(
      itemId: 2016222060918155,
      articleCode: "000099",
      itemName: "Tester123",
      uomId: 534,
      uom: "BOTTLE",
      partNumber: "",
      drawingNumber: '99',
      drawingPositionNumber: '88',
      receiptDate: '',
      storageLocationId: 5,
      storageLocationName: 'Storage Location 2',
      serialNumber: 'SN123456',
      grnHdId: 48204,
    ),
  ];

  // Process items in pairs (two per page)
  for (int i = 0; i < grnCreateLabelEntity.length; i += 3) {
    final firstItem = grnCreateLabelEntity[i];
    final secondItem = i + 1 < grnCreateLabelEntity.length ? grnCreateLabelEntity[i + 1] : null;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              children: [
                // Page header
                pw.Center(
                  child: pw.Text(
                    'PRODUCT LABELS',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 15),

                // First item row
                _buildLabelRow(firstItem, selectedPrintMode),
                pw.SizedBox(height: 20),

                // Divider
                pw.Divider(thickness: 1),
                pw.SizedBox(height: 20),

                // Second item row (if exists)
                if (secondItem != null) _buildLabelRow(secondItem, selectedPrintMode),

                // Print mode indicator at bottom
                pw.SizedBox(height: 15),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Generated with: ${selectedPrintMode?.name.toUpperCase() ?? 'BARCODE'}',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  return pdf.save();
}

// Helper method to build a single label row (barcode left, details right)
pw.Row _buildLabelRow(GRNCreateLabelEntity labelData, PrintMode? selectedPrintMode) {
  final String barcodeData = labelData.partNumber.isNotEmpty
      ? labelData.partNumber
      : labelData.articleCode;

  final Barcode barcode = selectedPrintMode == PrintMode.qrCode
      ? Barcode.qrCode()
      : Barcode.code128();

  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Barcode/QR Code Section (Left)
      pw.Container(
        width: 150,
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.BarcodeWidget(
              barcode: barcode,
              data: barcodeData,
              height: 70,
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              barcodeData,
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              labelData.itemName,
              style: pw.TextStyle(fontSize: 10),
              textAlign: pw.TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),

      pw.SizedBox(width: 15),

      // Details Section (Right)
      pw.Expanded(
        child: pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey, width: 0.5),
            borderRadius: pw.BorderRadius.circular(5),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'PRODUCT DETAILS',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue700,
                ),
              ),
              pw.SizedBox(height: 8),
              _buildCompactInfoRow('Item ID:', labelData.itemId.toString()),
              _buildCompactInfoRow('Article Code:', labelData.articleCode),
              _buildCompactInfoRow('Item Name:', labelData.itemName),
              _buildCompactInfoRow('UOM:', labelData.uom),

              if (labelData.partNumber.isNotEmpty)
                _buildCompactInfoRow('Part Number:', labelData.partNumber),

              if (labelData.drawingNumber.isNotEmpty)
                _buildCompactInfoRow('Drawing No:', labelData.drawingNumber),

              if (labelData.drawingPositionNumber.isNotEmpty)
                _buildCompactInfoRow('Drawing Pos:', labelData.drawingPositionNumber),

              if (labelData.storageLocationName.isNotEmpty)
                _buildCompactInfoRow('Storage:', labelData.storageLocationName),

              if (labelData.serialNumber.isNotEmpty)
                _buildCompactInfoRow('Serial No:', labelData.serialNumber),

              _buildCompactInfoRow('GRN ID:', labelData.grnHdId.toString()),
            ],
          ),
        ),
      ),
    ],
  );
}

pw.Row _buildCompactInfoRow(String label, String value) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        label,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(width: 4),
      pw.Expanded(
        child: pw.Text(
          value,
          style: pw.TextStyle(fontSize: 10),
          maxLines: 2,
        ),
      ),
    ],
  );
}*/
