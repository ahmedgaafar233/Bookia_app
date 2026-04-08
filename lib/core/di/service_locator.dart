import 'package:bookia/core/network/dio_consumer.dart';

// ── Auth ──────────────────────────────────────────────────────────────────
import 'package:bookia/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bookia/feature/auth/data/repos/auth_repository.dart';
import 'package:bookia/feature/auth/domain/repos/base_auth_repo.dart';
import 'package:bookia/feature/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/feature/auth/domain/usecases/logout_usecase.dart';
import 'package:bookia/feature/auth/domain/usecases/password_usecases.dart';
import 'package:bookia/feature/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';

// ── Home ──────────────────────────────────────────────────────────────────
import 'package:bookia/feature/home/data/datasources/home_remote_data_source.dart';
import 'package:bookia/feature/home/data/repos/home_repo.dart';
import 'package:bookia/feature/home/domain/repos/base_home_repo.dart';
import 'package:bookia/feature/home/domain/usecases/get_best_seller_usecase.dart';
import 'package:bookia/feature/home/domain/usecases/get_sliders_usecase.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';

// ── Cart ──────────────────────────────────────────────────────────────────
import 'package:bookia/feature/cart/data/datasources/cart_remote_data_source.dart';
import 'package:bookia/feature/cart/data/repos/cart_repo.dart';
import 'package:bookia/feature/cart/domain/repos/base_cart_repo.dart';
import 'package:bookia/feature/cart/domain/usecases/cart_usecases.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';

// ── Wishlist ──────────────────────────────────────────────────────────────
import 'package:bookia/feature/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'package:bookia/feature/wishlist/data/repos/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/domain/repos/base_wishlist_repo.dart';
import 'package:bookia/feature/wishlist/domain/usecases/wishlist_usecases.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';

// ── Details Cubits ────────────────────────────────────────────────────────
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_cubit.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/cubit/wishlist_action_cubit.dart';

// ── Search ────────────────────────────────────────────────────────────────
import 'package:bookia/feature/search/data/datasources/search_remote_data_source.dart';
import 'package:bookia/feature/search/data/repos/search_repo.dart';
import 'package:bookia/feature/search/domain/repos/base_search_repo.dart';
import 'package:bookia/feature/search/domain/usecases/search_usecase.dart';
import 'package:bookia/feature/search/presentation/cubit/search_cubit.dart';

// ── Profile ───────────────────────────────────────────────────────────────
import 'package:bookia/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:bookia/feature/profile/data/repos/profile_repo.dart';
import 'package:bookia/feature/profile/domain/repos/base_profile_repo.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';

// ── Settings ──────────────────────────────────────────────────────────────
import 'package:bookia/feature/settings/data/datasources/settings_remote_data_source.dart';
import 'package:bookia/feature/settings/data/repos/settings_repo.dart';
import 'package:bookia/feature/settings/domain/repos/base_settings_repo.dart';
import 'package:bookia/feature/settings/presentation/cubit/settings_cubit.dart';

// ── PlaceOrder ────────────────────────────────────────────────────────────
import 'package:bookia/feature/place_order/data/datasources/place_order_remote_data_source.dart';
import 'package:bookia/feature/place_order/data/repository/place_order_repo.dart';
import 'package:bookia/feature/place_order/domain/repos/base_place_order_repo.dart';
import 'package:bookia/feature/place_order/presentation/cubit/place_order_cubit.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ── Core ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer());

  // ── Auth ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BaseAuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BaseAuthRepo>(
    () => AuthRepository(sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => CheckForgetPasswordCodeUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerFactory(() => AuthCubit(sl()));

  // ── Home ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BaseHomeRemoteDataSource>(
    () => HomeRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BaseHomeRepo>(
    () => HomeRepository(sl()),
  );
  sl.registerLazySingleton(() => GetBestSellerUseCase(sl()));
  sl.registerLazySingleton(() => GetSlidersUseCase(sl()));
  sl.registerFactory(() => HomeCubit(sl()));

  // ── Cart ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BaseCartRemoteDataSource>(
    () => CartRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BaseCartRepo>(
    () => CartRepository(sl()),
  );
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerFactory(() => CartCubit(sl()));
  sl.registerFactory(() => CartActionCubit(sl()));

  // ── Wishlist ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BaseWishlistRemoteDataSource>(
    () => WishlistRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BaseWishlistRepo>(
    () => WishlistRepository(sl()),
  );
  sl.registerLazySingleton(() => GetWishlistUseCase(sl()));
  sl.registerLazySingleton(() => AddToWishlistUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromWishlistUseCase(sl()));
  sl.registerFactory(() => WishlistCubit(sl()));
  sl.registerFactory(() => WishlistActionCubit(sl()));

  // ── Search ────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BaseSearchRemoteDataSource>(
    () => SearchRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BaseSearchRepo>(
    () => SearchRepository(sl()),
  );
  sl.registerLazySingleton(() => SearchUseCase(sl()));
  sl.registerFactory(() => SearchCubit(sl()));

  // ── Profile ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BaseProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BaseProfileRepo>(
    () => ProfileRepository(sl()),
  );
  sl.registerFactory(() => ProfileCubit(sl()));

  // ── Settings ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BaseSettingsRemoteDataSource>(
    () => SettingsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BaseSettingsRepo>(
    () => SettingsRepository(sl()),
  );
  sl.registerFactory(() => SettingsCubit(sl()));

  // ── PlaceOrder ────────────────────────────────────────────────────────────
  sl.registerLazySingleton<BasePlaceOrderRemoteDataSource>(
    () => PlaceOrderRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<BasePlaceOrderRepo>(
    () => PlaceOrderRepository(sl()),
  );
  sl.registerFactory(() => PlaceOrderCubit(sl()));
}
