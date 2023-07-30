import 'package:get_it/get_it.dart';

import 'data/datasources/chat_datasourse.dart';
import 'data/repositories/chat_repositories_impl.dart';
import 'domain/repositories/chat_repositories.dart';
import 'domain/usecases/add_message_usecase.dart';
import 'domain/usecases/fetch_channel_id_usecase.dart';
import 'domain/usecases/get_all_messages_usecase.dart';
import 'domain/usecases/get_list_message_usescae.dart';
import 'domain/usecases/remove_all_list_usecase.dart';
import 'domain/usecases/remove_one_list_usecase.dart';
import 'presentation/cubit/chat_cubit.dart';
import 'presentation/cubit/dend_message_cubit/send_message_cubit.dart';
import 'presentation/cubit/remove_list_cubit/remove_list_cubit.dart';

Future<void> initChatInjection(GetIt sl) async {
  //* cubit
  sl.registerFactory(() => ChatCubit(
      getAllMessageUsecase: sl(),
      getListMessageUsecase: sl(),
      addMessageUsecase: sl(),
      fetchChannelIdUsecase: sl()));

  sl.registerFactory(() => SendMessageCubit(
        addMessageUsecase: sl(),
      ));

  sl.registerFactory(() =>
      RemoveListCubit(removeAllListUsecase: sl(), removeOneListUsecase: sl()));

  //* Use cases

  sl.registerLazySingleton(() => GetAllMessageUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetListMessageUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddMessageUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchChannelIdUsecase(repository: sl()));
  sl.registerLazySingleton(() => RemoveAllListUsecase(repository: sl()));
  sl.registerLazySingleton(() => RemoveOneListUsecase(repository: sl()));

  //* Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImp(
      appRepository: sl(),
      chatDataSource: sl(),
    ),
  );

  //* Data sources
  sl.registerLazySingleton<ChatDataSource>(
    () => ChatDataSourceImpl(
      apiConsumer: sl(),
    ),
  );
}
