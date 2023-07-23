import 'package:sqflite/sqflite.dart';

import '../../../../../core/errors/exceptions.dart';
import '../models/history_model.dart';
import 'history_dao.dart';

abstract class IHistoryLocalDatasource {
  Future<List<HistoryModel>?> getHistory();
  Future<void> cacheHistory(List<HistoryModel>? word);
  Future<void> deleteAllHistory();
}

class HistoryLocalDatasource extends IHistoryLocalDatasource {
  final HistoryDao historyDao;

  HistoryLocalDatasource(this.historyDao);

  @override
  Future<void> cacheHistory(List<HistoryModel>? word) async {
    try {
      await historyDao.insertHistory(word ?? []);
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAllHistory() async {
    try {
      await historyDao.deleteAllHistory();
    } on DatabaseException {
      throw CacheException();
    }
  }

  @override
  Future<List<HistoryModel>?> getHistory() async {
    try {
      final response = await historyDao.getHistory();
      return response ?? [];
    } on DatabaseException {
      return [];
    }
  }
}
