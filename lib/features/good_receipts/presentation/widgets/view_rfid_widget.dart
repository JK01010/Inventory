import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../widgets/bottom_sheet_header_widget.dart';

class ViewRfidWidget extends StatelessWidget {
  const ViewRfidWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.scaffoldPadding),
              child: BottomSheetHeaderWidget(title: context.l.viewRfid),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.all(AppPadding.scaffoldPadding),
                itemBuilder: (context, index) {
                  return _RfidDataWidget(
                    rfid: "RFID $index",
                    rfidSerialNumber: "A9776123-12122024-JAX-30087GRN24",
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RfidDataWidget extends StatelessWidget {
  const _RfidDataWidget({required this.rfid, required this.rfidSerialNumber});
  final String rfid;
  final String rfidSerialNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rfid,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: AppFontSize.fontSize13),
        ),
        Text(
          rfidSerialNumber,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColor.colorPrimary),
        ),
        SizedBox(height: AppSize.size10),
      ],
    );
  }
}
