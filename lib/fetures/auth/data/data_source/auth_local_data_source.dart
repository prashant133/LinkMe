import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/core/failure/failure.dart';
import 'package:room_finder_app/fetures/auth/data/model/auth_hive_model.dart';
import 'package:room_finder_app/fetures/auth/domain/entity/user_entity.dart';

import '../../../../core/network/local/hive_service.dart';

final authLocalDataSourceProvider = Provider((ref) => AuthLocalDataSource(
      ref.read(hiveServiceProvider),
      ref.read(authHiveModelProvider),
    ));

class AuthLocalDataSource {
  final HiveService _hiveService;
  final AuthHiveModel _authHiveModel;

  AuthLocalDataSource(this._hiveService, this._authHiveModel);

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    try {
      await _hiveService.addUser(_authHiveModel.toHiveModel(user));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      AuthHiveModel? user = await _hiveService.login(email, password);
      if (user == null) {
        return Left(Failure(error: 'email or password is wrong'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
