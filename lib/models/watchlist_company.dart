import 'package:isar/isar.dart';

part 'watchlist_company.g.dart';

@collection
class WatchlistCompany {
  Id id = Isar.autoIncrement;

  @Index()
  int watchlistId = 0;

  @Index()
  int companyId = 0;

  DateTime? addedAt;

  WatchlistCompany();

  WatchlistCompany.fromData({
    required int watchlistId,
    required int companyId,
    required DateTime addedAt,
  }) {
    this.watchlistId = watchlistId;
    this.companyId = companyId;
    this.addedAt = addedAt;
  }
}
