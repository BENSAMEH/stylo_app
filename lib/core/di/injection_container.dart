import 'package:get_it/get_it.dart';
import 'package:stylo_app/features/home/data/datasource/home_remote_datasource.dart';

import '../../features/home/data/datasource/product_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository.dart';
import '../../features/home/data/repositories/product_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/product_detail_cubit.dart';
import '../api/api_client.dart';
import '../../features/profile/presentation/cubit/address/address_cubit.dart';

import '../../features/profile/data/datasource/profile_remote_datasource.dart';
import '../../features/profile/data/datasource/address_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/data/repositories/address_repository_impl.dart';

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

  sl.registerLazySingleton<HomeRemoteDatasource>(
        () => HomeRemoteDatasource(sl<ApiClient>()),
  );
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepository(sl<HomeRemoteDatasource>()),
  );
  sl.registerFactory<HomeCubit>(
        () => HomeCubit(sl<HomeRepository>()),
  );
  sl.registerLazySingleton<ProductRemoteDatasource>(
        () => ProductRemoteDatasource(sl<ApiClient>()),
  );
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepository(sl<ProductRemoteDatasource>()),
  );
  sl.registerFactory<ProductDetailCubit>(
        () => ProductDetailCubit(sl<ProductRepository>()),
  );

}
