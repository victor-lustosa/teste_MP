
import '../../repositories/hive_clock_repository.dart';
import 'hive_user_dto.dart';

part 'hive_punch_the_clock_dto.g.dart';

@HiveType(typeId: 1)
class HivePunchTheClockDTO {
  @HiveField(0)
  String id;

  @HiveField(1)
  HiveUserDTO user;

  @HiveField(2)
  String time;

  @HiveField(3)
  String date;

  HivePunchTheClockDTO(
      {required this.user, required this.id, required this.time, required this.date});

  factory HivePunchTheClockDTO.empty() => HivePunchTheClockDTO

  (

  user:HiveUserDTO(id: '',name: ''), id:'', time: '', date:'');
}
