import '../../domain/entities/user_entity.dart';
import '../dtos/hive_dtos/hive_user_dto.dart';

class UserAdapter{

  static List<UserEntity> fromDTOList(List<HiveUserDTO> data) {
    return data.map((entity) => UserEntity(name: entity.name, id: entity.id)).toList();
  }

  static HiveUserDTO toDTO(UserEntity userEntity) {
    return HiveUserDTO(name: userEntity.name, id: userEntity.id);
  }
}
