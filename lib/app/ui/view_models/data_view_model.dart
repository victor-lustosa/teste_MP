
import '../../core/domain/entities/punch_the_clock_entity.dart';
import '../../core/domain/entities/user_entity.dart';
import '../../core/domain/repositories/repository.dart';
import '../../core/infra/repositories/hive_clock_repository.dart';
import '../../core/infra/repositories/hive_user_repository.dart';

class DataViewModel {
  DataViewModel(
      {required HiveClockRepository clockRepository,
      required HiveUserRepository userRepository})
      : _userRepository = userRepository,
        _clockRepository = clockRepository;

  final ICLocksRepository _clockRepository;
  final IUsersRepository _userRepository;

  DateTime focusedDay = DateTime.now();

  DateTime? selectedDay;

  registerUser(UserEntity user) async {
    _userRepository.update(user);
  }

  Future<List<PunchTheClockEntity>> getClocks(String day, String userName) async {
    var entities = await _clockRepository.getClocks(day, userName);
    return entities;
  }

  getUsers() {
    return _userRepository.getUsers();
  }

  registerClock(PunchTheClockEntity clock) {
    _clockRepository.update(clock);
  }
}
