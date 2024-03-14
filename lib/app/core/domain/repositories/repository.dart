import 'package:teste_mp/app/core/domain/entities/user_entity.dart';

import '../entities/punch_the_clock_entity.dart';

abstract class IRepository<R>
    implements
        IAddRepository,
        IUpdateRepository,
        IDeleteRepository {}

abstract class IGetCLocksRepository {
  Future<List<PunchTheClockEntity>> getClocks(String day, String user);
}

abstract class IGetUsersRepository {
  Future<List<UserEntity>> getUsers();
}

abstract class IAddRepository {
  Future<void> add(String path, data);
}

abstract class IUpdateRepository {
  Future<void> update(String path, data);
}

abstract class IDeleteRepository {
  Future<void> delete(String path);
}
