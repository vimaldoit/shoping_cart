part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomePageLoading extends HomeState {}

class HomePageSuccess extends HomeState {
  final List<dynamic> productdata;

  HomePageSuccess(this.productdata);
}

class HomePageFailure extends HomeState {
  final String error;

  HomePageFailure(this.error);
}
