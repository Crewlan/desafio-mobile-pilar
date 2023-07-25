import 'package:floor/floor.dart';

import '../models/history_model.dart';

@dao
abstract class HistoryDao {
  @Query('SELECT * FROM History')
  Future<List<HistoryModel>?> getHistory();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertHistory(List<HistoryModel> word);

  @Query('DELETE FROM History')
  Future<void> deleteAllHistory();
}
