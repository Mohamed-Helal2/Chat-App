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
import 'package:chatapp/features/message/data/datasource/location_data_source.dart';
import 'package:chatapp/features/message/data/datasource/message_local_data_source.dart';
import 'package:chatapp/features/message/data/datasource/message_remote_data_source.dart';
import 'package:chatapp/features/message/data/repostories/location_repostories.dart';
import 'package:chatapp/features/message/data/repostories/mesagerpostories.dart';
import 'package:chatapp/features/message/data/repostories/record_repostories.dart';
import 'package:chatapp/features/message/domain/repostories/location_repostories.dart';
import 'package:chatapp/features/message/domain/repostories/message_repostories.dart';
import 'package:chatapp/features/message/domain/usecases/get_message_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/send_message_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_audio_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_images_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_my_location_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_pdf_usecase.dart';
import 'package:chatapp/features/message/presentation/bloc/message_cubit.dart';
import 'package:chatapp/features/mychats/data/datasource/my_chats_remote_data_source.dart';
import 'package:chatapp/features/mychats/data/repostories/mychats_repostories.dart';
import 'package:chatapp/features/mychats/domain/repostories/mychats_repostories.dart';
import 'package:chatapp/features/mychats/domain/usecases/get_mychats_usecase.dart';
import 'package:chatapp/features/mychats/presentation/bloc/allmychats_cubit.dart';
import 'package:chatapp/features/profile/data/datasouce/profile_remote_data_source.dart';
import 'package:chatapp/features/profile/data/repostories/profile_repo_impl.dart';
import 'package:chatapp/features/profile/domain/repostories/profile_repo.dart';
import 'package:chatapp/features/profile/domain/usecases/profile_use_case.dart';
import 'package:chatapp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chatapp/features/signup/data/datasource/signup_remote_data_source.dart';
import 'package:chatapp/features/signup/data/repostories/signup_repostoriesimpl.dart';
import 'package:chatapp/features/signup/domain/repostories/signup_repostories.dart';
import 'package:chatapp/features/signup/domain/usecases/signup_usecase.dart';
import 'package:chatapp/features/signup/presentation/bloc/signup_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getit = GetIt.instance;

Future<void> SetGetIt() async {
  // cubit
  getit.registerFactory<LoginCubit>(() => LoginCubit(loginUsecases: getit()));
  getit.registerFactory<SignupCubit>(() => SignupCubit(signupUsecase: getit()));
  getit.registerFactory<BottomNavBarCubit>(() => BottomNavBarCubit());
  getit.registerFactory<UsersCubit>(
      () => UsersCubit(getAllUserUsecase: getit()));
  getit.registerFactory<MessageCubit>(() => MessageCubit(
        sendMessageUsecase: getit(),
        getMessageUsecase: getit(),
        uploadImagesUsecase: getit(),
        uploadAudioUsecase: getit(),
        recordRepository: getit(),
        getMyLocationUseCase: getit(),
        uploadPdfUsecase: getit(),
      ));
  getit.registerFactory<AllmychatsCubit>(
      () => AllmychatsCubit(getMychatsUsecase: getit()));
  getit.registerFactory<ProfileCubit>(
      () => ProfileCubit(profileUseCase: getit()));
//  usecases
  getit.registerLazySingleton(() => LoginUsecases(loginrepostories: getit()));
  getit.registerLazySingleton(() => SignupUsecase(signUpRepostories: getit()));
  getit
      .registerLazySingleton(() => GetAllUserUsecase(userRepostories: getit()));
  getit.registerLazySingleton(
      () => SendMessageUsecase(messageRepostories: getit()));
  getit.registerLazySingleton(
      () => GetMessageUsecase(messageRepostories: getit()));
  getit.registerLazySingleton(
      () => UploadImagesUsecase(messageRepostories: getit()));
  getit.registerLazySingleton(
    () => UploadAudioUsecase(messageRepostories: getit()),
  );
  getit.registerLazySingleton(
      () => GetMyLocationUseCase(locationRepostories: getit()));
  getit.registerLazySingleton(
      () => UploadPdfUsecase(messageRepostories: getit()));
  getit.registerLazySingleton(
      () => GetMychatsUsecase(mychatsRepostories: getit()));
  getit.registerLazySingleton(() => ProfileUseCase(profilerepo: getit()));
//  repo
  getit.registerLazySingleton<LoginRepostories>(() =>
      LoginRepostoriesImpl(loginDataSource: getit(), networkInfo: getit()));
  getit.registerLazySingleton<SignUpRepostories>(() => SignupRepostoriesimpl(
      signupRemoteDataSource: getit(), networkInfo: getit()));
  getit.registerLazySingleton<UserRepostories>(() => UserRepostoriesImpl(
      getUserRemoteDataSource: getit(),
      getUserLocalDataSource: getit(),
      networkInfo: getit()));
  getit.registerLazySingleton<MessageRepostories>(() => MesagerpostoriesImpl(
      messageRemoteDatSource: getit(),
      networkInfo: getit(),
      messageLocalDataSource: getit()));
  getit.registerLazySingleton(() => RecordRepository());
  getit.registerLazySingleton<LocationRepostories>(
      () => LocationRepostoriesImpl(locationDataSource: getit()));
  getit.registerLazySingleton<MychatsRepostories>(() => MychatsRepostoriesImpl(
      myChatsRemoteDataSource: getit(), networkInfo: getit()));
  getit.registerLazySingleton<Profilerepo>(() => ProfileRepoImpl(
      getprofileremoteDatasource: getit(), networkInfo: getit()));
// data Source
  getit.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
  getit.registerLazySingleton<SignupRemoteDataSource>(
      () => SignupRemoteDataSourceImpl());
  getit.registerLazySingleton<GetUserRemoteDataSource>(
      () => GetUserRemoteDataSourceImple());
  getit.registerLazySingleton<GetUserLocalDataSource>(
      () => GetUserLocalDataSourceImpl(sharedPreferences: getit()));
  getit.registerLazySingleton<MessageRemoteDataSource>(
      () => MessageRemoteDatSourceImpl());
  getit.registerLazySingleton<MessageLocalDataSource>(
      () => MessageLocalDataSourceImpl(sharedPreferences: getit()));
  getit.registerLazySingleton<LocationDataSource>(
    () => LocationDataSourceImpl(location: getit()),
  );
  getit.registerLazySingleton<MyChatsRemoteDataSource>(
      () => MyChatsRemoteDataSourceImpl());
     getit.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl()); 
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
  getit.registerLazySingleton(
    () => Location(),
  );
}
