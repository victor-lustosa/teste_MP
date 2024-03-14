

import '../entities/punch_the_clock_entity.dart';
import '../entities/user_entity.dart';

abstract class ICLocksRepository
    implements
        IUpdateRepository,
        IDeleteRepository,
        IGetCLocksRepository {}

abstract class IUsersRepository
    implements
        IUpdateRepository,
        IDeleteRepository,
        IGetUsersRepository {}


abstract class IGetCLocksRepository {
  Future<List<PunchTheClockEntity>> getClocks(String day, String user);
}

abstract class IGetUsersRepository {
  Future<List<UserEntity>> getUsers();
}

abstract class IUpdateRepository {
  Future<void> update(data);
}

abstract class IDeleteRepository {
  Future<void> delete(String path);
}
