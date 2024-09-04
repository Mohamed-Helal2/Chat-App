import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/bottomNavBar/presentation/bloc/bottom_nav_bar_cubit.dart';
import 'package:chatapp/features/home/data/datasource/get_user_local_data_source.dart';
import 'package:chatapp/features/home/data/datasource/get_user_remote_data_source.dart';
import 'package:chatapp/features/home/data/repostories/user_repostories_impl.dart';
import 'package:chatapp/features/home/domain/repostories/user_repostories.dart';
import 'package:chatapp/features/home/domain/usecases/get_all_user_usecase.dart';
import 'package:chatapp/features/home/presentation/bloc/users_cubit.dart';
import 'package:chatapp/features/login/data/datasource/login_remote_data_source.dart';
import 'package:chatapp/features/login/data/repostoriesImpl/login_repostories_impl.dart';
import 'package:chatapp/features/login/domain/repostories/login_repostories.dart';
import 'package:chatapp/features/login/domain/usecases/login_usecases.dart';
import 'package:chatapp/features/login/presentation/bloc/login_cubit.dart';
import 'package:chatapp/features/signup/data/datasource/signup_remote_data_source.dart';
import 'package:chatapp/features/signup/data/repostories/signup_repostoriesimpl.dart';
import 'package:chatapp/features/signup/domain/repostories/signup_repostories.dart';
import 'package:chatapp/features/signup/domain/usecases/signup_usecase.dart';
import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getit = GetIt.instance;

Future<void> SetGetIt() async {
  // cubit
  getit.registerFactory<LoginCubit>(() => LoginCubit(loginUsecases: getit()));
  getit.registerFactory<SignupCubit>(() => SignupCubit(signupUsecase: getit()));
  getit.registerFactory<BottomNavBarCubit>(() => BottomNavBarCubit());
  getit.registerFactory<UsersCubit>(
      () => UsersCubit(getAllUserUsecase: getit()));

//  usecases
  getit.registerLazySingleton(() => LoginUsecases(loginrepostories: getit()));
  getit.registerLazySingleton(() => SignupUsecase(signUpRepostories: getit()));
  getit
      .registerLazySingleton(() => GetAllUserUsecase(userRepostories: getit()));

//  repo
  getit.registerLazySingleton<LoginRepostories>(() =>
      LoginRepostoriesImpl(loginDataSource: getit(), networkInfo: getit()));
  getit.registerLazySingleton<SignUpRepostories>(() => SignupRepostoriesimpl(
      signupRemoteDataSource: getit(), networkInfo: getit()));
  getit.registerLazySingleton<UserRepostories>(() => UserRepostoriesImpl(
      getUserRemoteDataSource: getit(),
      getUserLocalDataSource: getit(),
      networkInfo: getit()));
// data Source
  getit.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
  getit.registerLazySingleton<SignupRemoteDataSource>(
      () => SignupRemoteDataSourceImpl());
  getit.registerLazySingleton<GetUserRemoteDataSource>(
      () => GetUserRemoteDataSourceImple());
  getit.registerLazySingleton<GetUserLocalDataSource>(
      () => GetUserLocalDataSourceImpl(sharedPreferences: getit()));
  // core
  getit.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: getit()),
  );
  final sharedPreferences = await SharedPreferences.getInstance();

  getit.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
  getit.registerLazySingleton(
    () => sharedPreferences,
  );
}
