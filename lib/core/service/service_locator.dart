import '../../features/posts/data/repositories/post_Repositories_impl.dart';
import '../../features/posts/domin/repositories/post_repositories.dart';
import '../../features/posts/domin/usecases/add_posts.dart';
import '../../features/posts/domin/usecases/delet_posts.dart';
import '../../features/posts/domin/usecases/get_all_posts.dart';
import '../../features/posts/domin/usecases/update_posts.dart';
import '../../features/posts/presentaion/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/posts/data/datasources/post_local_datasource.dart';
import '../../features/posts/data/datasources/post_remote_datasource.dart';
import '../../features/posts/presentaion/bloc/add_update_delet_posts_bloc/add_update_delet_posts_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //bloc
  sl.registerFactory(() => PostsBloc(getAllPostsUsecases: sl()));
  sl.registerFactory(
    () => AddUpdateDeletPostsBloc(
      addPostsUsecase: sl(),
      updatePostsUsecase: sl(),
      deletPostsUsecase: sl(),
    ),
  );

// usecase
  sl.registerLazySingleton(() => GetAllPostsUsecases(sl()));
  sl.registerLazySingleton(() => UpdatePostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostsUsecase(sl()));
  sl.registerLazySingleton(() => DeletPostsUsecase(sl()));

// repository
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoriesImpl(
      networkInfo: sl(),
      postlocalDataSource: sl(),
      postRemoteDataSource: sl(),
    ),
  );

// Data Source
// local Data Source
  sl.registerLazySingleton<PostlocalDataSource>(
    () => PostImplWithLocalData(
      sharedPreferences: sl(),
    ),
  );
  // remote Data Source
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostImplWithHttp(client: sl()));
// core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: sl(),
    ),
  );
  // External
  final shearedPrefrences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => (shearedPrefrences));
  sl.registerLazySingleton(() => (http.Client()));
  sl.registerLazySingleton(() => (InternetConnectionChecker()));
}
