import '../../data/model/chapter/chapter.dart';
import '../../data/model/juz/juz.dart';

abstract class ChapterRepository {
  Future<List<Chapter?>?> chapterApi();

  Future<List<Chapter?>?> chapterHive();
}

abstract class JuzRepository {
  Future<Juz?> juzFetchApi(num juzNumber);

  Future<Juz?> juzFetchHive(num juzNumber);
}
