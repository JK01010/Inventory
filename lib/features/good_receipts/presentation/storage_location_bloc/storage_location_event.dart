part of 'storage_location_bloc.dart';

class StorageLocationEvent extends Equatable {
  const StorageLocationEvent();

  @override
  List<Object?> get props => [];
}

class InsertStorageLocationEvent extends StorageLocationEvent {}

class FetchStorageLocationByParentIdEvent extends StorageLocationEvent {
  FetchStorageLocationByParentIdEvent(
    this.parentId,
    this.storageLocationEntity,
  );

  int parentId;
  StorageLocationEntity? storageLocationEntity;
}

class ResetStorageLocationEvent extends StorageLocationEvent {}

class NavigateToStorageLocationEvent extends StorageLocationEvent {
  NavigateToStorageLocationEvent(this.selectedBreadCrumbLocation);

  StorageLocationEntity selectedBreadCrumbLocation;
}

class StorageLocationListSearchEvent extends StorageLocationEvent {
  StorageLocationListSearchEvent({required this.searchText});

  final String searchText;
}

