
import 'package:injectable/injectable.dart';
import 'package:recogenie/Features/home/domain/repository/home_repository.dart';
import 'package:recogenie/core/error/result.dart';
import 'package:recogenie/core/helper/SupabaseNamesHelper/names_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/helper/Connectivity/connectivity_helper.dart';
import '../model/menu_item_model.dart';


@Injectable(as: HomeRepository)
class HomeRepositoryImp implements HomeRepository  {
  final SupabaseClient _supabase;
  HomeRepositoryImp(this._supabase);


  @override
  Future<Result> fetchAllMenuItems() async {

    if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{

      final items = await _supabase.from(SupabaseNamesHelper.tables.menuItemsTable.tableName).select();

      return Success(data: MenuItemsModel.fromJson(items).menuItems);

    }on PostgrestException catch (e){
    return FailureResult(Failure(message: e.message, type: FailureType.general, responseCode: e.code));
    }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }
  }


}