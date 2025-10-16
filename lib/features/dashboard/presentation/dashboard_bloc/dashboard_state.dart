part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {}

final class DashboardFailure extends DashboardState {}

final class LogoutSuccess extends DashboardState {}

final class LogoutFailed extends DashboardState {}
