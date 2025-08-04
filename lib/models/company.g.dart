// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompanyCollection on Isar {
  IsarCollection<Company> get companys => this.collection();
}

const CompanySchema = CollectionSchema(
  name: r'Company',
  id: -3921622125198845844,
  properties: {
    r'currentPrice': PropertySchema(
      id: 0,
      name: r'currentPrice',
      type: IsarType.double,
    ),
    r'formattedMarketCap': PropertySchema(
      id: 1,
      name: r'formattedMarketCap',
      type: IsarType.string,
    ),
    r'formattedPrice': PropertySchema(
      id: 2,
      name: r'formattedPrice',
      type: IsarType.string,
    ),
    r'hasValidMarketCap': PropertySchema(
      id: 3,
      name: r'hasValidMarketCap',
      type: IsarType.bool,
    ),
    r'hasValidPrice': PropertySchema(
      id: 4,
      name: r'hasValidPrice',
      type: IsarType.bool,
    ),
    r'hashCode': PropertySchema(
      id: 5,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'isRecentlyUpdated': PropertySchema(
      id: 6,
      name: r'isRecentlyUpdated',
      type: IsarType.bool,
    ),
    r'lastUpdated': PropertySchema(
      id: 7,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'marketCap': PropertySchema(
      id: 8,
      name: r'marketCap',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 9,
      name: r'name',
      type: IsarType.string,
    ),
    r'screenerUrl': PropertySchema(
      id: 10,
      name: r'screenerUrl',
      type: IsarType.string,
    ),
    r'symbol': PropertySchema(
      id: 11,
      name: r'symbol',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 12,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _companyEstimateSize,
  serialize: _companySerialize,
  deserialize: _companyDeserialize,
  deserializeProp: _companyDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'url': IndexSchema(
      id: -5756857009679432345,
      name: r'url',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'url',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'symbol': IndexSchema(
      id: -7050953154795990356,
      name: r'symbol',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'symbol',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _companyGetId,
  getLinks: _companyGetLinks,
  attach: _companyAttach,
  version: '3.1.0+1',
);

int _companyEstimateSize(
  Company object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.formattedMarketCap.length * 3;
  bytesCount += 3 + object.formattedPrice.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.screenerUrl.length * 3;
  bytesCount += 3 + object.symbol.length * 3;
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _companySerialize(
  Company object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.currentPrice);
  writer.writeString(offsets[1], object.formattedMarketCap);
  writer.writeString(offsets[2], object.formattedPrice);
  writer.writeBool(offsets[3], object.hasValidMarketCap);
  writer.writeBool(offsets[4], object.hasValidPrice);
  writer.writeLong(offsets[5], object.hashCode);
  writer.writeBool(offsets[6], object.isRecentlyUpdated);
  writer.writeDateTime(offsets[7], object.lastUpdated);
  writer.writeDouble(offsets[8], object.marketCap);
  writer.writeString(offsets[9], object.name);
  writer.writeString(offsets[10], object.screenerUrl);
  writer.writeString(offsets[11], object.symbol);
  writer.writeString(offsets[12], object.url);
}

Company _companyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Company();
  object.currentPrice = reader.readDoubleOrNull(offsets[0]);
  object.id = id;
  object.lastUpdated = reader.readDateTimeOrNull(offsets[7]);
  object.marketCap = reader.readDoubleOrNull(offsets[8]);
  object.name = reader.readString(offsets[9]);
  object.symbol = reader.readString(offsets[11]);
  object.url = reader.readString(offsets[12]);
  return object;
}

P _companyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _companyGetId(Company object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _companyGetLinks(Company object) {
  return [];
}

void _companyAttach(IsarCollection<dynamic> col, Id id, Company object) {
  object.id = id;
}

extension CompanyByIndex on IsarCollection<Company> {
  Future<Company?> getByUrl(String url) {
    return getByIndex(r'url', [url]);
  }

  Company? getByUrlSync(String url) {
    return getByIndexSync(r'url', [url]);
  }

  Future<bool> deleteByUrl(String url) {
    return deleteByIndex(r'url', [url]);
  }

  bool deleteByUrlSync(String url) {
    return deleteByIndexSync(r'url', [url]);
  }

  Future<List<Company?>> getAllByUrl(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return getAllByIndex(r'url', values);
  }

  List<Company?> getAllByUrlSync(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'url', values);
  }

  Future<int> deleteAllByUrl(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'url', values);
  }

  int deleteAllByUrlSync(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'url', values);
  }

  Future<Id> putByUrl(Company object) {
    return putByIndex(r'url', object);
  }

  Id putByUrlSync(Company object, {bool saveLinks = true}) {
    return putByIndexSync(r'url', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUrl(List<Company> objects) {
    return putAllByIndex(r'url', objects);
  }

  List<Id> putAllByUrlSync(List<Company> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'url', objects, saveLinks: saveLinks);
  }
}

extension CompanyQueryWhereSort on QueryBuilder<Company, Company, QWhere> {
  QueryBuilder<Company, Company, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompanyQueryWhere on QueryBuilder<Company, Company, QWhereClause> {
  QueryBuilder<Company, Company, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Company, Company, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> idBetween(
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

  QueryBuilder<Company, Company, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> urlEqualTo(String url) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'url',
        value: [url],
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> urlNotEqualTo(String url) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [],
              upper: [url],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [url],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [url],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [],
              upper: [url],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> symbolEqualTo(
      String symbol) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'symbol',
        value: [symbol],
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> symbolNotEqualTo(
      String symbol) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [],
              upper: [symbol],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [symbol],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [symbol],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [],
              upper: [symbol],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CompanyQueryFilter
    on QueryBuilder<Company, Company, QFilterCondition> {
  QueryBuilder<Company, Company, QAfterFilterCondition> currentPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentPrice',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      currentPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentPrice',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> currentPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> currentPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> currentPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> currentPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedMarketCap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedMarketCap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedMarketCap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedMarketCap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedMarketCap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedMarketCap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedMarketCap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedMarketCap',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedMarketCap',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedMarketCapIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedMarketCap',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> formattedPriceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedPriceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> formattedPriceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> formattedPriceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedPriceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> formattedPriceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> formattedPriceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedPrice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> formattedPriceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedPrice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedPriceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      formattedPriceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedPrice',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      hasValidMarketCapEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasValidMarketCap',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> hasValidPriceEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasValidPrice',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Company, Company, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Company, Company, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Company, Company, QAfterFilterCondition>
      isRecentlyUpdatedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRecentlyUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> lastUpdatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> lastUpdatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> lastUpdatedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> lastUpdatedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> lastUpdatedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> lastUpdatedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> marketCapIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'marketCap',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> marketCapIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'marketCap',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> marketCapEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> marketCapGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'marketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> marketCapLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'marketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> marketCapBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'marketCap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenerUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'screenerUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'screenerUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'screenerUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'screenerUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'screenerUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'screenerUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'screenerUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> screenerUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenerUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      screenerUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'screenerUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'symbol',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'symbol',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> symbolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension CompanyQueryObject
    on QueryBuilder<Company, Company, QFilterCondition> {}

extension CompanyQueryLinks
    on QueryBuilder<Company, Company, QFilterCondition> {}

extension CompanyQuerySortBy on QueryBuilder<Company, Company, QSortBy> {
  QueryBuilder<Company, Company, QAfterSortBy> sortByCurrentPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByCurrentPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByFormattedMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedMarketCap', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByFormattedMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedMarketCap', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByFormattedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPrice', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByFormattedPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPrice', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByHasValidMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidMarketCap', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByHasValidMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidMarketCap', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByHasValidPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidPrice', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByHasValidPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidPrice', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByIsRecentlyUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecentlyUpdated', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByIsRecentlyUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecentlyUpdated', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByScreenerUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenerUrl', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByScreenerUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenerUrl', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension CompanyQuerySortThenBy
    on QueryBuilder<Company, Company, QSortThenBy> {
  QueryBuilder<Company, Company, QAfterSortBy> thenByCurrentPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByCurrentPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByFormattedMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedMarketCap', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByFormattedMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedMarketCap', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByFormattedPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPrice', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByFormattedPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPrice', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByHasValidMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidMarketCap', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByHasValidMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidMarketCap', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByHasValidPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidPrice', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByHasValidPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasValidPrice', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByIsRecentlyUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecentlyUpdated', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByIsRecentlyUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecentlyUpdated', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByScreenerUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenerUrl', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByScreenerUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'screenerUrl', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension CompanyQueryWhereDistinct
    on QueryBuilder<Company, Company, QDistinct> {
  QueryBuilder<Company, Company, QDistinct> distinctByCurrentPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentPrice');
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByFormattedMarketCap(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedMarketCap',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByFormattedPrice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedPrice',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByHasValidMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasValidMarketCap');
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByHasValidPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasValidPrice');
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByIsRecentlyUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRecentlyUpdated');
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marketCap');
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByScreenerUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'screenerUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctBySymbol(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symbol', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }
}

extension CompanyQueryProperty
    on QueryBuilder<Company, Company, QQueryProperty> {
  QueryBuilder<Company, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Company, double?, QQueryOperations> currentPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentPrice');
    });
  }

  QueryBuilder<Company, String, QQueryOperations> formattedMarketCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedMarketCap');
    });
  }

  QueryBuilder<Company, String, QQueryOperations> formattedPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedPrice');
    });
  }

  QueryBuilder<Company, bool, QQueryOperations> hasValidMarketCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasValidMarketCap');
    });
  }

  QueryBuilder<Company, bool, QQueryOperations> hasValidPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasValidPrice');
    });
  }

  QueryBuilder<Company, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<Company, bool, QQueryOperations> isRecentlyUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRecentlyUpdated');
    });
  }

  QueryBuilder<Company, DateTime?, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<Company, double?, QQueryOperations> marketCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marketCap');
    });
  }

  QueryBuilder<Company, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Company, String, QQueryOperations> screenerUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'screenerUrl');
    });
  }

  QueryBuilder<Company, String, QQueryOperations> symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symbol');
    });
  }

  QueryBuilder<Company, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }
}
