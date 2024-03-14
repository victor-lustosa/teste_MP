
import '../../repositories/hive_clock_repository.dart';

part 'hive_user_dto.g.dart';

@HiveType(typeId: 0)
class HiveUserDTO {
  @HiveField(0)
  String name;

  @HiveField(1)
  String id;

  HiveUserDTO({required this.name, required this.id,});

  factory HiveUserDTO.empty() => HiveUserDTO(name: '', id: '');
}
