  import 'package:bloc/bloc.dart';
  import 'package:injectable/injectable.dart';
  import 'package:meta/meta.dart';
  import 'package:recogenie/Features/home/data/model/menu_item_model.dart';

  import '../../../../../core/error/result.dart';
  import '../../../domain/repository/home_repository.dart';

  part 'home_state.dart';

  @injectable
  class HomeCubit extends Cubit<HomeState> {
    final HomeRepository _homeRepository;
    HomeCubit(this._homeRepository) : super(HomeInitial());

    List<MenuItem> menuItems = [];
    List<MenuItem> filteredItems = [];

    Future<void> getMenuItems() async {
      emit(HomeLoading());
      final result = await _homeRepository.fetchAllMenuItems();

      if (result is Success) {
        menuItems = result.data;
        filteredItems = menuItems; // Initially show all
        emit(HomeSuccess());
      } else {
        emit(HomeError((result as FailureResult).failure.message));
      }
    }

    void search(String query) {
      if (query.trim().isEmpty) {
        filteredItems = menuItems;
      } else {
        filteredItems = menuItems
            .where((item) =>
        item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      emit(HomeSearchUpdated());
    }

    void clearSearch() {
      filteredItems = menuItems;
      emit(HomeSearchUpdated());
    }
  }
