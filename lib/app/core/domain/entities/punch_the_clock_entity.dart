import 'user_entity.dart';

class PunchTheClockEntity {
  final String id;
  final UserEntity user;
  final String time;
  final DateTime date;

  PunchTheClockEntity(
      {required this.id,
      required this.user,
      required this.time,
      required this.date});
}
