// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_company.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchlistCompanyCollection on Isar {
  IsarCollection<WatchlistCompany> get watchlistCompanys => this.collection();
}

const WatchlistCompanySchema = CollectionSchema(
  name: r'WatchlistCompany',
  id: -2858029081081706646,
  properties: {
    r'addedAt': PropertySchema(
      id: 0,
      name: r'addedAt',
      type: IsarType.dateTime,
    ),
    r'companyId': PropertySchema(
      id: 1,
      name: r'companyId',
      type: IsarType.long,
    ),
    r'watchlistId': PropertySchema(
      id: 2,
      name: r'watchlistId',
      type: IsarType.long,
    )
  },
  estimateSize: _watchlistCompanyEstimateSize,
  serialize: _watchlistCompanySerialize,
  deserialize: _watchlistCompanyDeserialize,
  deserializeProp: _watchlistCompanyDeserializeProp,
  idName: r'id',
  indexes: {
    r'watchlistId': IndexSchema(
      id: 8154124886978871830,
      name: r'watchlistId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'watchlistId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'companyId': IndexSchema(
      id: 482756417767355356,
      name: r'companyId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'companyId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _watchlistCompanyGetId,
  getLinks: _watchlistCompanyGetLinks,
  attach: _watchlistCompanyAttach,
  version: '3.1.0+1',
);

int _watchlistCompanyEstimateSize(
  WatchlistCompany object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _watchlistCompanySerialize(
  WatchlistCompany object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.addedAt);
  writer.writeLong(offsets[1], object.companyId);
  writer.writeLong(offsets[2], object.watchlistId);
}

WatchlistCompany _watchlistCompanyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WatchlistCompany();
  object.addedAt = reader.readDateTimeOrNull(offsets[0]);
  object.companyId = reader.readLong(offsets[1]);
  object.id = id;
  object.watchlistId = reader.readLong(offsets[2]);
  return object;
}

P _watchlistCompanyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchlistCompanyGetId(WatchlistCompany object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _watchlistCompanyGetLinks(WatchlistCompany object) {
  return [];
}

void _watchlistCompanyAttach(
    IsarCollection<dynamic> col, Id id, WatchlistCompany object) {
  object.id = id;
}

extension WatchlistCompanyQueryWhereSort
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QWhere> {
  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhere>
      anyWatchlistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'watchlistId'),
      );
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhere> anyCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'companyId'),
      );
    });
  }
}

extension WatchlistCompanyQueryWhere
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QWhereClause> {
  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      watchlistIdEqualTo(int watchlistId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'watchlistId',
        value: [watchlistId],
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      watchlistIdNotEqualTo(int watchlistId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'watchlistId',
              lower: [],
              upper: [watchlistId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'watchlistId',
              lower: [watchlistId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'watchlistId',
              lower: [watchlistId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'watchlistId',
              lower: [],
              upper: [watchlistId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      watchlistIdGreaterThan(
    int watchlistId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'watchlistId',
        lower: [watchlistId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      watchlistIdLessThan(
    int watchlistId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'watchlistId',
        lower: [],
        upper: [watchlistId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      watchlistIdBetween(
    int lowerWatchlistId,
    int upperWatchlistId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'watchlistId',
        lower: [lowerWatchlistId],
        includeLower: includeLower,
        upper: [upperWatchlistId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      companyIdEqualTo(int companyId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'companyId',
        value: [companyId],
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      companyIdNotEqualTo(int companyId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [],
              upper: [companyId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [companyId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [companyId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'companyId',
              lower: [],
              upper: [companyId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      companyIdGreaterThan(
    int companyId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'companyId',
        lower: [companyId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      companyIdLessThan(
    int companyId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'companyId',
        lower: [],
        upper: [companyId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterWhereClause>
      companyIdBetween(
    int lowerCompanyId,
    int upperCompanyId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'companyId',
        lower: [lowerCompanyId],
        includeLower: includeLower,
        upper: [upperCompanyId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchlistCompanyQueryFilter
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QFilterCondition> {
  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      addedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'addedAt',
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      addedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'addedAt',
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      addedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      addedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      addedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      addedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      companyIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      companyIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      companyIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      companyIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      watchlistIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watchlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      watchlistIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'watchlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      watchlistIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'watchlistId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterFilterCondition>
      watchlistIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'watchlistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchlistCompanyQueryObject
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QFilterCondition> {}

extension WatchlistCompanyQueryLinks
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QFilterCondition> {}

extension WatchlistCompanyQuerySortBy
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QSortBy> {
  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      sortByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      sortByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      sortByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      sortByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      sortByWatchlistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchlistId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      sortByWatchlistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchlistId', Sort.desc);
    });
  }
}

extension WatchlistCompanyQuerySortThenBy
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QSortThenBy> {
  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      thenByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      thenByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      thenByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      thenByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      thenByWatchlistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchlistId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QAfterSortBy>
      thenByWatchlistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchlistId', Sort.desc);
    });
  }
}

extension WatchlistCompanyQueryWhereDistinct
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QDistinct> {
  QueryBuilder<WatchlistCompany, WatchlistCompany, QDistinct>
      distinctByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedAt');
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QDistinct>
      distinctByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId');
    });
  }

  QueryBuilder<WatchlistCompany, WatchlistCompany, QDistinct>
      distinctByWatchlistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'watchlistId');
    });
  }
}

extension WatchlistCompanyQueryProperty
    on QueryBuilder<WatchlistCompany, WatchlistCompany, QQueryProperty> {
  QueryBuilder<WatchlistCompany, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WatchlistCompany, DateTime?, QQueryOperations>
      addedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedAt');
    });
  }

  QueryBuilder<WatchlistCompany, int, QQueryOperations> companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<WatchlistCompany, int, QQueryOperations> watchlistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'watchlistId');
    });
  }
}
