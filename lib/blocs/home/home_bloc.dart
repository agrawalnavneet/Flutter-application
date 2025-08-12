import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findoc_assignment/blocs/home/home_event.dart';
import 'package:findoc_assignment/blocs/home/home_state.dart';
import 'package:findoc_assignment/services/api_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _apiService = ApiService();

  HomeBloc() : super(HomeInitial()) {
    on<LoadImages>(_onLoadImages);
    on<RefreshImages>(_onRefreshImages);
  }

  void _onLoadImages(
    LoadImages event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final images = await _apiService.getImages(limit: 10);
      emit(HomeSuccess(images));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  void _onRefreshImages(
    RefreshImages event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final images = await _apiService.getImages(limit: 10);
      emit(HomeSuccess(images));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
} 