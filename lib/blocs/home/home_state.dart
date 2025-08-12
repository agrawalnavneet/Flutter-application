import 'package:equatable/equatable.dart';
import 'package:findoc_assignment/models/image_item.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ImageItem> images;

  const HomeSuccess(this.images);

  @override
  List<Object?> get props => [images];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
} 