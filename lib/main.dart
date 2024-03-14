
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/core/infra/dtos/hive_dtos/hive_punch_the_clock_dto.dart';
import 'app/core/infra/dtos/hive_dtos/hive_user_dto.dart';
import 'app/core/infra/repositories/hive_clock_repository.dart';
import 'app/main_module.dart';
import 'app/ui/themes/themes.dart';


void main() async {
  Modular.setInitialRoute(MainModule.initialRoute);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserDTOAdapter());
  Hive.registerAdapter(HivePunchTheClockDTOAdapter());
  await Future.wait<void>([
    Hive.openBox<HiveUserDTO>('users'),
    Hive.openBox<HivePunchTheClockDTO>('punch-the-clocks'),
  ]);
  initializeDateFormatting();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
        (_) => runApp(
      ModularApp(
        module: MainModule(),
        child: MaterialApp.router(
          title: 'IPBC Palmas',
          theme: lightTheme,
          routerConfig: Modular.routerConfig,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}



