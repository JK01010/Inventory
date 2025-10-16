import 'package:flutter/material.dart';

import '../../../../core/constants/app_size.dart';
import '../../../../core/extensions/localization_extension.dart';

class SerialNumbersListingHeaderWidget extends StatelessWidget {
  const SerialNumbersListingHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.scaffoldPadding,
          ),
          child: Row(
            children: <Widget>[
              Text(
                context.l.qty,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: AppFontSize.fontSize14,
                ),
              ),
              SizedBox(width: AppSize.size10),
              Text(
                context.l.serialNo,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: AppFontSize.fontSize14,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(height: AppSize.size10),
      ],
    );
  }
}
