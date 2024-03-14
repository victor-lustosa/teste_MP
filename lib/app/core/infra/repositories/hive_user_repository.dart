
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/repository.dart';
import '../adapters/user_adapter.dart';
import '../dtos/hive_dtos/hive_user_dto.dart';
import 'hive_clock_repository.dart';
export 'package:hive_flutter/hive_flutter.dart';

class HiveUserRepository implements IRepository,IGetUsersRepository {
  late Box<HiveUserDTO> box;
  List<String> params = [];

  HiveUserRepository() {
    box = Hive.box('users');
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    var result = box.values.toList();
    return UserAdapter.fromDTOList(result);
  }

  @override
  Future<void> add(String path, data) async {}

  @override
  Future<void> update(String path, data) async {
    box.put(
      data.id,
      UserAdapter.toDTO(data),
    );
  }

  @override
  Future<void> delete(String path) async {
    box.delete(path);
  }
}
