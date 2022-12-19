import 'dart:async';

import 'package:al_quran/data/Repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/chapter/chapter.dart';
import '../../../domain/Repository/repository.dart';

part 'state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  static ChapterCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ChapterCubit>(context, listen: listen);

  ChapterCubit() : super(ChapterDefault());

  final ChapterRepository repo = ChapterRepositoryImp();

  Future<void> fetch({bool? api = false}) async {
    emit(const ChapterFetchLoading());
    try {
      List<Chapter?>? cached;

      if (api!) {
        cached = await repo.chapterApi();
      } else {
        cached = await repo.chapterHive();
      }

      if (cached == null) {
        List<Chapter?>? data = await repo.chapterApi();
        emit(ChapterFetchSuccess(data: data));
      } else {
        emit(ChapterFetchSuccess(data: cached));
      }
    } catch (e) {
      emit(ChapterFetchFailed(message: e.toString()));
    }
  }
}
