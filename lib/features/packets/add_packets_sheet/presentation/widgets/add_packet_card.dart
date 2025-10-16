import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_size.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../widgets/app_decorated_box_shadow_widget.dart';
import '../../../../widgets/app_text_form_field.dart';
import '../../../../widgets/app_title_widget.dart';
import '../../domain/entities/packets_entity.dart';
import '../bloc/add_packets_sheet_bloc.dart';
import '../bloc/add_packets_sheet_bloc_event.dart';

class AddPacketCard extends StatefulWidget {
  const AddPacketCard({super.key, required this.packetEntity});

  final PacketEntity packetEntity;

  @override
  State<AddPacketCard> createState() => _AddPacketCardState();
}

class _AddPacketCardState extends State<AddPacketCard> {
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _actualVolumeController = TextEditingController();
  final TextEditingController _packetNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _actualVolumeController.text =
        widget.packetEntity.actualVolume == 0
            ? ''
            : widget.packetEntity.actualVolume.toString();
    _widthController.text =
        widget.packetEntity.width == 0
            ? ''
            : widget.packetEntity.width.toString();
    _lengthController.text =
        widget.packetEntity.length == 0
            ? ''
            : widget.packetEntity.length.toString();
    _heightController.text =
        widget.packetEntity.height == 0
            ? ''
            : widget.packetEntity.height.toString();
    _weightController.text =
        widget.packetEntity.weight == 0
            ? ''
            : widget.packetEntity.weight.toString();
    _packetNameController.text = widget.packetEntity.packetName;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.size10,
        vertical: AppSize.size5,
      ),
      child: AppDecoratedBoxShadowWidget(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: AppTextFormField(
                  maxLine: 1,
                  // labelText: context.l.width,
                  // suffixIcon: UnconstrainedBox(child: AppTitleWidget(text: "M")),
                  controller: _packetNameController,
                  onChanged: (value) {
                    context.read<AddPacketsSheetBloc>().add(
                      PacketValueChangeEvent(
                        newValue: value,
                        packetTextFieldType: PacketTextFieldType.packetName,
                        packetEntity: widget.packetEntity,
                      ),
                    );
                  },

                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              // DecoratedBox(
              //   // height: AppSize.size30,
              //   child: Text(
              //     widget.packetEntity.packetName,
              //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(height: AppSize.size15),
              Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.width,
                      suffixIcon: UnconstrainedBox(
                        child: AppTitleWidget(text: "M"),
                      ),
                      controller: _widthController,
                      onChanged: (value) {
                        context.read<AddPacketsSheetBloc>().add(
                          PacketValueChangeEvent(
                            newValue: value,
                            packetTextFieldType: PacketTextFieldType.width,
                            packetEntity: widget.packetEntity,
                          ),
                        );
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(width: AppSize.size10),
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.length,
                      suffixIcon: UnconstrainedBox(
                        child: AppTitleWidget(text: "M"),
                      ),
                      controller: _lengthController,
                      onChanged: (value) {
                        context.read<AddPacketsSheetBloc>().add(
                          PacketValueChangeEvent(
                            newValue: value,
                            packetTextFieldType: PacketTextFieldType.length,
                            packetEntity: widget.packetEntity,
                          ),
                        );
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(width: AppSize.size10),
                  Expanded(
                    child: AppTextFormField(
                      labelText: context.l.height,
                      suffixIcon: UnconstrainedBox(
                        child: AppTitleWidget(text: "M"),
                      ),
                      enabled: true,
                      controller: _heightController,
                      onChanged: (value) {
                        context.read<AddPacketsSheetBloc>().add(
                          PacketValueChangeEvent(
                            newValue: value,
                            packetTextFieldType: PacketTextFieldType.height,
                            packetEntity: widget.packetEntity,
                          ),
                        );
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.size20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AppTextFormField(
                      labelText: context.l.weight,
                      suffixIcon: UnconstrainedBox(
                        child: AppTitleWidget(text: "Kg"),
                      ),
                      controller: _weightController,
                      onChanged: (value) {
                        context.read<AddPacketsSheetBloc>().add(
                          PacketValueChangeEvent(
                            newValue: value,
                            packetTextFieldType: PacketTextFieldType.weight,
                            packetEntity: widget.packetEntity,
                          ),
                        );
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(width: AppSize.size10),
                  Expanded(
                    flex: 2,
                    child: AppTextFormField(
                      labelText: context.l.actualVolume,
                      readOnly: true,
                      suffixIcon: UnconstrainedBox(
                        child: AppTitleWidget(text: "Mtq"),
                      ),
                      controller: _actualVolumeController,
                      onChanged: (value) {
                        context.read<AddPacketsSheetBloc>().add(
                          PacketValueChangeEvent(
                            newValue: value,
                            packetTextFieldType:
                                PacketTextFieldType.actualVolume,
                            packetEntity: widget.packetEntity,
                          ),
                        );
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
