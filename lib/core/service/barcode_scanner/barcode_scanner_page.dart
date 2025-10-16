import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_name.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/widgets/custom_dropdown_type_page_navigator.dart';
import '../../../features/bagging_tagging_confirmtaion/presentation/widgets/custom_search_field_bottom_sheet_textfeild.dart';
import '../../../features/widgets/app_text_form_field.dart';
import '../../../features/widgets/app_two_row_button_widget.dart';
import '../../../features/widgets/custom_app_bar.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_size.dart';
import '../../extensions/localization_extension.dart';
import '../../extensions/theme_extension.dart';
import 'presentation/bloc/barcode_bloc.dart';
import 'presentation/widget/barcode_scanner_view.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _robController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  String? _selectedStorageLocation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BarcodeBloc>().add(RequestCameraPermission());
    });
  }

  @override
  void dispose() {
    _itemDescriptionController.dispose();
    _quantityController.dispose();
    _robController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BarcodeBloc, BarcodeState>(
      listener: (context, state) {
        // Listen for specific states and show messages or navigate
        if (state.isBarCodeScanSuccess && state.barcode != null) {
          debugPrint("inside the listener condition ***********");
          _itemDescriptionController.text = state.barcode?.rawValue ?? 'N/A';
          _unitController.text = 'Box'; // Example: pre-fill unit
          _quantityController.text = '1'; // Example: pre-fill quantity
          _robController.text = '0'; // Example: pre-fill ROB
          _showMessageBox(
            context,
            'Barcode Scanned!',
            'Type: ${state.barcode?.type}\nValue: ${state.barcode?.rawValue}',
          );
          context.read<BarcodeBloc>().add(StopScan());
        } else if (state.isBarCodeScanFailed) {
          _showMessageBox(context, 'Error', state.message);
        } else if (!state.isPermissionGranted &&
            !state.isBarCodeScannerReady &&
            !state.isLoading) {
          _showMessageBox(context, 'Permission Denied', state.message);
        } else if (state.isBarCodeScannerReady &&
            state.isBarCodeScannerScanning) {
          context.read<BarcodeBloc>().add(StartScan());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              context.isDarkMode
                  ? AppColor.colorBGBlack
                  : AppColor.colorSecondary,
          appBar: CustomAppBar(
            title: context.l.scanBarcode,
            arrowBackColor: AppColor.colorWhite,
            appBarTitleColor: AppColor.colorWhite,
            actions: [
              if (state.controller != null)
                GestureDetector(
                  onTap: () {
                    context.read<BarcodeBloc>().add(ToggleFlashLightEvent());
                  },
                  child: SvgPicture.asset(
                    state.isTorchOn
                        ? AppIcons.torchOnIcon
                        : AppIcons.torchOffIcon,
                    height: AppSize.size35,
                    width: AppSize.size35,
                    colorFilter: ColorFilter.mode(
                      AppColor.colorWhite,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(), // Hide if no controller
            ],
            onBack: () {
              context.pop();
            },
            // arrowBackColor: AppColor.colorWhite,
            // appBarTitleColor: AppColor.colorWhite,
          ),
          body: Center(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: AppSize.size25),
                    // Barcode Scanner View (top part)
                    state.isBarCodeScannerScanning
                        ? BarcodeScannerView(
                          scannerController: state.controller,
                          isScanning: state.isBarCodeScannerScanning,
                          statusWidget: _buildScannerStatusWidget(state),
                        )
                        : state.barcode?.image != null
                        ? Container(
                          color: AppColor.colorWhite,
                          child: SvgPicture.string(
                            state.barcode?.image ?? '',
                            width: 300,
                            height: 100,
                          ),
                        )
                        : SizedBox(),
                    if (state.barcode?.image != null) ...[
                      SizedBox(height: AppSize.size25),
                    ],
                    // Show form content when not in scan mode
                    if (!state.isBarCodeScannerScanning &&
                        state.barcode != null)
                      Expanded(
                        child: Container(
                          color: AppColor.colorBackground,
                          child: Padding(
                            padding: const EdgeInsets.all(
                              AppPadding.scaffoldPadding,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.colorWhite,
                                borderRadius: BorderRadius.circular(
                                  AppBorderRadius.borderRadius15,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.colorGrey,
                                    offset: const Offset(0, 1),
                                    blurRadius: 1.5,
                                    spreadRadius: 0.5,
                                  ),
                                ],
                              ),
                              child: IntrinsicHeight(
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    AppPadding.scaffoldPadding,
                                  ),
                                  child: SingleChildScrollView(
                                    child: _buildFormModeContent(context),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // 👇 Bottom content only shown in scan mode
                if (state.isBarCodeScannerScanning)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: _buildScanModeContent(state),
                  ),
              ],
            ),
          ),
          bottomNavigationBar:
              state.isBarCodeScannerScanning
                  ? null // No bottom navigation bar in initial scan mode
                  : AppTwoRowButtonWidget(
                    buttonSecondTitle: context.l.saveAddAnother,
                    buttonFirstOnPress: _clearFormAndResetScanner,
                    buttonSecondOnPress: _handleSaveAndAddAnother,
                  ),
        );
      },
    );
  }

  Widget _buildScanModeContent(BarcodeState state) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          const SizedBox(height: 20),
          if (state.isBarCodeScannerReady || state.isBarCodeScannerScanning)
            Text(
              context.l.scanAnyItemBarcode,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.fontSize14,
                fontWeight: FontWeight.w400,
                color: AppColor.colorWhite,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  // Content for the form entry mode
  Widget _buildFormModeContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSize.size15),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 56),
          child: dropDownPageNavigator(
            labelText: context.l.defaultStorageLocation,
            hintText: context.l.select,
            value: null,
            context: context,
            onPressed: () {
              context.push(AppRoute.chooseStorageLocationPage.path,extra: {'screenType': 'barCodeScanner'});
            },
          ),
        ),
        SizedBox(height: AppSize.size18),
        CustomTypeAheadFieldBottomSheet(
          label: context.l.item,
          hint: context.l.search,
          controller: _itemDescriptionController,
          errorText: '',
          onTap: () {
            // Handle item search/selection if needed
          },
        ),
        SizedBox(height: AppSize.size1),
        AppTextFormField(
          controller: _quantityController,
          labelText: context.l.quantity,
          hintText: context.l.enterQuantity,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: AppSize.size20),
        AppTextFormField(
          controller: _robController,
          fillColor: AppColor.colorBlack5,
          filled: true,
          enabled: false,
          labelText: context.l.rob,
          hintText: context.l.rob,
          // Added hint text
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: AppSize.size16),
        AppTextFormField(
          controller: _unitController,
          labelText: context.l.unit,
          hintText: context.l.enterUnit,
        ),
        SizedBox(height: AppSize.size20),
      ],
    );
  }

  void _clearFormAndResetScanner() {
    _itemDescriptionController.clear();
    _quantityController.clear();
    _robController.clear();
    _unitController.clear();
    context.read<BarcodeBloc>().add(ResetScanner());
    // Immediately try to start scanning again if permission is granted
    context.read<BarcodeBloc>().add(RequestCameraPermission());
  }

  void _handleSaveAndAddAnother() {
    _showMessageBox(
      context,
      'Saved!',
      'Item: ${_itemDescriptionController.text}\n'
          'Quantity: ${_quantityController.text}\n'
          'ROB: ${_robController.text}\n'
          'Unit: ${_unitController.text}\n'
          'Location: ${_selectedStorageLocation ?? 'N/A'}',
    );
    _clearFormAndResetScanner(); // Clear form and return to scan mode
  }

  Widget _buildScannerStatusWidget(BarcodeState state) {
    if (state.isLoading) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt_outlined, size: 80, color: Colors.white70),
          SizedBox(height: 10),
          Text(
            'Initializing scanner...',
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ],
      );
    } else if (state.isLoading) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else if (!state.isPermissionGranted) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.no_photography_outlined,
            size: 80,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 10),
          Text(
            state.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.redAccent),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              context.read<BarcodeBloc>().add(RequestCameraPermission());
            },
            icon: const Icon(Icons.settings, color: Colors.white),
            label: const Text(
              'Grant Permission',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      );
    } else if (state.isBarCodeScanFailed) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.redAccent),
          const SizedBox(height: 10),
          Text(
            'Error: ${state.message}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.redAccent),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink(); // Hide status when scanner is ready/scanning
    }
  }

  void _showMessageBox(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//     required this.title,
//     required this.arrowBackColor,
//     required this.appBarTitleColor,
//   });
//
//   final String title;
//   final Color arrowBackColor;
//   final Color appBarTitleColor;
//
//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
//
// class _CustomAppBarState extends State<CustomAppBar> {
//   // Local state to track torch status for the icon
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leadingWidth: AppSize.appBarLeadingWidth,
//       leading: InkWell(
//         onTap: () {
//           context.pop();
//         },
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: AppPadding.scaffoldPadding,
//             left: AppPadding.scaffoldPadding,
//           ),
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: widget.arrowBackColor,
//             size: AppFontSize.fontSize18,
//           ),
//         ),
//       ),
//       title: Padding(
//         padding: EdgeInsets.only(top: AppPadding.scaffoldPadding),
//         child: AppBarTitleWidget(text: widget.title),
//       ),
//       backgroundColor: AppColor.colorSecondary,
//       elevation: 0,
//       centerTitle: false,
//       actionsPadding: EdgeInsets.only(
//         top: AppPadding.scaffoldPadding,
//         right: AppPadding.scaffoldPadding,
//       ),
//       actions: [
//         // Only show torch icon if a controller is available
//         if (context.read<BarcodeBloc>().state.controller != null)
//           GestureDetector(
//             onTap: () {
//               context.read<BarcodeBloc>().add(ToggleFlashLightEvent());
//             },
//             child: SvgPicture.asset(
//               context.read<BarcodeBloc>().state.isTorchOn
//                   ? AppIcons.torchOnIcon
//                   : AppIcons.torchOffIcon,
//               height: AppSize.size35,
//               width: AppSize.size35,
//               colorFilter: ColorFilter.mode(
//                 context.isDarkMode ? AppColor.colorWhite : AppColor.colorWhite,
//                 BlendMode.srcIn,
//               ),
//             ),
//           )
//         else
//           const SizedBox.shrink(), // Hide if no controller
//       ],
//     );
//   }
// }
