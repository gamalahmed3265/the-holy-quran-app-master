import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../model/chapter/chapter.dart';
import '../model/juz/juz.dart';

class BookmarksDataProvider {
  static final cache = Hive.box('data');

  static Future<List<Chapter?>?> fetch() async {
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <Chapter?>[];
        await cache.put('bookmarks', bookmarks);
      }

      final List<Chapter?>? cachedBookmarks = List.from(bookmarks);
      return cachedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Chapter?>?> addBookmark(Chapter? chapter) async {
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <Chapter?>[];
        await cache.put('bookmarks', bookmarks);
      }

      final List<Chapter?>? updatedBookmarks = List.from(bookmarks);
      updatedBookmarks!.add(chapter);

      await cache.put('bookmarks', updatedBookmarks);
      return updatedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Chapter?>?> removeBookmark(Chapter? chapter) async {
    try {
      List bookmarks = await cache.get('bookmarks');

      final List<Chapter?>? updatedBookmarks = List.from(bookmarks);
      updatedBookmarks!.remove(chapter);

      await cache.put('bookmarks', updatedBookmarks);
      return updatedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<bool?> checkBookmarked(Chapter? chapter) async {
    try {
      List bookmarks = await cache.get('bookmarks');

      final List<Chapter?>? updatedBookmarks = List.from(bookmarks);
      return updatedBookmarks!.contains(chapter);
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}

class ChapterDataProvider {
  static final cache = Hive.box('data');

  static Dio ins = Dio();

  static Future<List<Chapter?>?> chapterApi() async {
    try {
      final resp = await ins.get(
        'http://api.alquran.cloud/v1/quran/quran-uthmani',
      );
      final Map<String, dynamic> raw = resp.data['data'];

      final List data = raw['surahs'];
      final List<Chapter> chapters = List.generate(
        data.length,
        (index) => Chapter.fromMap(data[index]),
      );
      await cache.put(
        'chapters',
        chapters,
      );

      return chapters;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw Exception('Problem with internet connection');
      } else {
        throw Exception('Problem on our side, Please try again');
      }
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<Chapter?>?> chapterHive() async {
    try {
      final chapter = await cache.get('chapters');

      if (chapter == null) return null;

      final List<Chapter?>? chapters = List.from(chapter);

      return chapters;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
