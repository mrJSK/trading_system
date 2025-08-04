import 'package:isar/isar.dart';

part 'watchlist.g.dart';

@collection
class Watchlist {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String name = '';

  DateTime? createdAt;

  Watchlist();

  Watchlist.fromData({
    required String name,
    required DateTime createdAt,
  }) {
    this.name = name;
    this.createdAt = createdAt;
  }
}
