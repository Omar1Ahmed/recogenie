import 'package:recogenie/core/error/result.dart';

abstract class HomeRepository {

  Future<Result> fetchAllMenuItems();
}