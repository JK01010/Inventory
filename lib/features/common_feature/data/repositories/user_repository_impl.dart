import '../../domain/repositories/user_repository.dart';
import '../../../../core/service/db_service/user_local_datasource.dart';

class UserRepositoryImpl implements UserRepository {

  UserRepositoryImpl(this.localDataSource);
  final UserLocalDataSource localDataSource;

  @override
  Future<void> createUser(String name) {
    return localDataSource.addUser(name);
  }

}
