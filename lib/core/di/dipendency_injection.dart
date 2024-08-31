import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/login/data/datasource/login_remote_data_source.dart';
import 'package:chatapp/features/login/data/repostoriesImpl/login_repostories_impl.dart';
import 'package:chatapp/features/login/domain/repostories/login_repostories.dart';
import 'package:chatapp/features/login/domain/usecases/login_usecases.dart';
import 'package:chatapp/features/login/presentation/bloc/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getit = GetIt.instance;

Future<void> SetGetIt() async {
  // cubit
  getit.registerFactory<LoginCubit>(
    () => LoginCubit(loginUsecases: getit()),
  );
//  usecases
  getit.registerLazySingleton(
    () => LoginUsecases(loginrepostories: getit()),
  );
//  repo
  getit.registerLazySingleton<LoginRepostories>(
    () => LoginRepostoriesImpl(loginDataSource: getit(), networkInfo: getit()),
  );

// data Source
  getit.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(),
  );

  // core
  getit.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: getit()),
  );

  getit.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
