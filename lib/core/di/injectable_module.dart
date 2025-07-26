
import 'package:injectable/injectable.dart';

import '../network/dio_client.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  DioClient dioClient() => DioClient(baseUrl: 'http://195.35.3.92:9106');
}
