part of 'bagging_item_section_bloc.dart';


class BaggingItemSectionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//insert
class ItemSectionInsertDataEvent extends BaggingItemSectionEvent {}

//get
class ItemSectionFetchAllDataEvent extends BaggingItemSectionEvent {}