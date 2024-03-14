import 'package:intl/intl.dart';
import '../../domain/entities/punch_the_clock_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../dtos/hive_dtos/hive_punch_the_clock_dto.dart';
import '../dtos/hive_dtos/hive_user_dto.dart';

class ClockAdapter {
 static DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  static List<PunchTheClockEntity> fromDTOList(
      List<HivePunchTheClockDTO> data) {
    return data
        .map(
          (entity) => PunchTheClockEntity(
            id: entity.id,
            user: UserEntity(
              id: entity.user.id,
              name: entity.user.name,
            ),
            time: entity.time,
            date: dateFormat.parse(entity.date),
          ),
        )
        .toList();
  }

  static HivePunchTheClockDTO toDTO(PunchTheClockEntity clockEntity) {
    return HivePunchTheClockDTO(
      id: clockEntity.id,
      user: HiveUserDTO(
        id: clockEntity.user.id,
        name: clockEntity.user.name,
      ),
      time: clockEntity.time,
      date: DateFormat('dd/MM/yyyy').format(clockEntity.date),
    );
  }
}
