import 'package:flutter_modular/flutter_modular.dart';

import 'core/infra/repositories/hive_clock_repository.dart';
import 'core/infra/repositories/hive_user_repository.dart';
import 'ui/blocs/calendar_bloc.dart';
import 'ui/calendar_view.dart';
import 'ui/view_models/data_view_model.dart';

class MainModule extends Module {
  static const String initialRoute = '/';
  static const String splashRoute = '/splash';
  static const String eventsListRoute = '/events';

  @override
  void binds(i) {
    i.addSingleton(HiveUserRepository.new);
    i.addSingleton(HiveClockRepository.new);
    i.addSingleton(
      () => CalendarBloc(
        hiveRepository: i.get(),
      ),
    );
    i.addSingleton(
      () => DataViewModel(
        userRepository: i.get(),
        clockRepository: i.get(),
      ),
    );
  }

  @override
  void routes(r) {
    r.child(initialRoute, child: (_) => const CalendarView());
  }
}
