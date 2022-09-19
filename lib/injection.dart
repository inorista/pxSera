import 'package:get_it/get_it.dart';
import 'package:pxsera/src/network/dio_client.dart';

final locator = GetIt.instance;

void configInjection() {
  locator.registerFactory<DioClient>(() => DioClient());
}
