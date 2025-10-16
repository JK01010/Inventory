part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class FetchAllCommonApi extends DashboardEvent {}

class LogoutEvent extends DashboardEvent {}