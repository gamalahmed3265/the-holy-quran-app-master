import '../../domain/Repository/repository.dart';
import '../../presention/cubits/chapter/cubit.dart';
import '../../presention/cubits/juz/cubit.dart';
import '../data_source/local.dart';
import '../data_source/remote.dart';
import '../model/chapter/chapter.dart';
import '../model/juz/juz.dart';

class ChapterRepositoryImp implements ChapterRepository {
  @override
  Future<List<Chapter?>?> chapterApi() => ChapterDataProvider.chapterApi();

  @override
  Future<List<Chapter?>?> chapterHive() => ChapterDataProvider.chapterHive();
}

class JuzRepositoryImp implements JuzRepository {
  @override
  Future<Juz?> juzFetchApi(num juzNumber) =>
      JuzDataProvider.juzFetchApi(juzNumber);
  @override
  Future<Juz?> juzFetchHive(num juzNumber) =>
      JuzDataProvider.juzFetchHive(juzNumber);
}
