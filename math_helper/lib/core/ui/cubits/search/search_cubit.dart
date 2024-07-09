import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:math_helper/core/functionalities.dart';
import 'package:math_helper/core/ui/components/search/search_item.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void search(BuildContext context, String clue) {
    emit(SearchLoading());
    try {
      if (clue == '') {
        emit(SearchLoaded(searchItems: const []));
      } else {
        final searchItems = Functionalities.getsearchItems(context)
            .entries
            .where((element) => element.key.contains(clue))
            .map((e) => e.value)
            .toList();
        emit(SearchLoaded(searchItems: searchItems));
      }
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }
}
