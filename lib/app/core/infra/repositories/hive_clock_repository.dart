import '../../domain/entities/punch_the_clock_entity.dart';
import '../../domain/repositories/repository.dart';
import '../adapters/clock_adapter.dart';
import '../dtos/hive_dtos/hive_punch_the_clock_dto.dart';
import 'hive_clock_repository.dart';
export 'package:hive_flutter/hive_flutter.dart';

class HiveClockRepository implements IRepository,IGetCLocksRepository {
  late Box<HivePunchTheClockDTO> box;
  List<String> params = [];

  HiveClockRepository() {
    box = Hive.box('punch-the-clocks');
  }

  @override
  Future<List<PunchTheClockEntity>> getClocks(String day, String userName) async {
    var result = box.values.where((entity) => entity.date == day && entity.user.name == userName).toList();
    result.sort((a, b) => b.date.compareTo(a.date));
    return ClockAdapter.fromDTOList(result);
  }

  @override
  Future<void> add(String path, data) async {}

  @override
  Future<void> update(String path, data) async {
    box.put(
      data.id,
      ClockAdapter.toDTO(data),
    );
  }

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }
}
