import 'package:get_it/get_it.dart';

import '../api/api_client.dart';

import '../../features/profile/data/datasource/profile_remote_datasource.dart';
import '../../features/profile/data/datasource/address_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/data/repositories/address_repository_impl.dart';
import '../../features/profile/presentation/cubit/address/address_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Api
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // Profile Data Source
  sl.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasource(sl<ApiClient>()),
  );

  sl.registerLazySingleton<ProfileRepositoryImpl>(
    () => ProfileRepositoryImpl(sl<ProfileRemoteDatasource>()),
  );

  // Profile Cubit
  sl.registerFactory(() => ProfileCubit(sl<ProfileRepositoryImpl>()));
  // Address DataSource
  sl.registerLazySingleton<AddressRemoteDatasource>(
    () => AddressRemoteDatasource(sl<ApiClient>()),
  );
  // Address Repository
  sl.registerLazySingleton<AddressRepositoryImpl>(
    () => AddressRepositoryImpl(sl<AddressRemoteDatasource>()),
  );

  // Address Cubit
  sl.registerFactory(() => AddressCubit(sl<AddressRepositoryImpl>()));
}
