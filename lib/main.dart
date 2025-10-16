import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';
import 'app/app_providers.dart';
import 'core/constants/api_constant.dart';
import 'core/initialization/app_initializer.dart';

void main() async {
  await AppInitializer.initialize();
  await GetStorage.init();
  ApiConstant();
  runApp(
    // DevicePreview(
    //   builder:
    //       (context) =>
    MultiBlocProvider(providers: appBlocProviders, child: const InventoryApp()),
  );
}
