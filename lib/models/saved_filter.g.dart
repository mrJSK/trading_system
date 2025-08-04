// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_filter.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavedFilterCollection on Isar {
  IsarCollection<SavedFilter> get savedFilters => this.collection();
}

const SavedFilterSchema = CollectionSchema(
  name: r'SavedFilter',
  id: 3669536288723080398,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'maxDividendYield': PropertySchema(
      id: 1,
      name: r'maxDividendYield',
      type: IsarType.double,
    ),
    r'maxMarketCap': PropertySchema(
      id: 2,
      name: r'maxMarketCap',
      type: IsarType.double,
    ),
    r'maxPE': PropertySchema(
      id: 3,
      name: r'maxPE',
      type: IsarType.double,
    ),
    r'maxROCE': PropertySchema(
      id: 4,
      name: r'maxROCE',
      type: IsarType.double,
    ),
    r'maxROE': PropertySchema(
      id: 5,
      name: r'maxROE',
      type: IsarType.double,
    ),
    r'minDividendYield': PropertySchema(
      id: 6,
      name: r'minDividendYield',
      type: IsarType.double,
    ),
    r'minMarketCap': PropertySchema(
      id: 7,
      name: r'minMarketCap',
      type: IsarType.double,
    ),
    r'minPE': PropertySchema(
      id: 8,
      name: r'minPE',
      type: IsarType.double,
    ),
    r'minROCE': PropertySchema(
      id: 9,
      name: r'minROCE',
      type: IsarType.double,
    ),
    r'minROE': PropertySchema(
      id: 10,
      name: r'minROE',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _savedFilterEstimateSize,
  serialize: _savedFilterSerialize,
  deserialize: _savedFilterDeserialize,
  deserializeProp: _savedFilterDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _savedFilterGetId,
  getLinks: _savedFilterGetLinks,
  attach: _savedFilterAttach,
  version: '3.1.0+1',
);

int _savedFilterEstimateSize(
  SavedFilter object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _savedFilterSerialize(
  SavedFilter object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDouble(offsets[1], object.maxDividendYield);
  writer.writeDouble(offsets[2], object.maxMarketCap);
  writer.writeDouble(offsets[3], object.maxPE);
  writer.writeDouble(offsets[4], object.maxROCE);
  writer.writeDouble(offsets[5], object.maxROE);
  writer.writeDouble(offsets[6], object.minDividendYield);
  writer.writeDouble(offsets[7], object.minMarketCap);
  writer.writeDouble(offsets[8], object.minPE);
  writer.writeDouble(offsets[9], object.minROCE);
  writer.writeDouble(offsets[10], object.minROE);
  writer.writeString(offsets[11], object.name);
}

SavedFilter _savedFilterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedFilter();
  object.createdAt = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.maxDividendYield = reader.readDoubleOrNull(offsets[1]);
  object.maxMarketCap = reader.readDoubleOrNull(offsets[2]);
  object.maxPE = reader.readDoubleOrNull(offsets[3]);
  object.maxROCE = reader.readDoubleOrNull(offsets[4]);
  object.maxROE = reader.readDoubleOrNull(offsets[5]);
  object.minDividendYield = reader.readDoubleOrNull(offsets[6]);
  object.minMarketCap = reader.readDoubleOrNull(offsets[7]);
  object.minPE = reader.readDoubleOrNull(offsets[8]);
  object.minROCE = reader.readDoubleOrNull(offsets[9]);
  object.minROE = reader.readDoubleOrNull(offsets[10]);
  object.name = reader.readString(offsets[11]);
  return object;
}

P _savedFilterDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savedFilterGetId(SavedFilter object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _savedFilterGetLinks(SavedFilter object) {
  return [];
}

void _savedFilterAttach(
    IsarCollection<dynamic> col, Id id, SavedFilter object) {
  object.id = id;
}

extension SavedFilterByIndex on IsarCollection<SavedFilter> {
  Future<SavedFilter?> getByName(String name) {
    return getByIndex(r'name', [name]);
  }

  SavedFilter? getByNameSync(String name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<SavedFilter?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<SavedFilter?> getAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'name', values);
  }

  Future<int> deleteAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'name', values);
  }

  int deleteAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'name', values);
  }

  Future<Id> putByName(SavedFilter object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(SavedFilter object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<SavedFilter> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(List<SavedFilter> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension SavedFilterQueryWhereSort
    on QueryBuilder<SavedFilter, SavedFilter, QWhere> {
  QueryBuilder<SavedFilter, SavedFilter, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SavedFilterQueryWhere
    on QueryBuilder<SavedFilter, SavedFilter, QWhereClause> {
  QueryBuilder<SavedFilter, SavedFilter, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterWhereClause> idBetween(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterWhereClause> nameNotEqualTo(
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
}

extension SavedFilterQueryFilter
    on QueryBuilder<SavedFilter, SavedFilter, QFilterCondition> {
  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxDividendYieldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxDividendYield',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxDividendYieldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxDividendYield',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxDividendYieldEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxDividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxDividendYieldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxDividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxDividendYieldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxDividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxDividendYieldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxDividendYield',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxMarketCapIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxMarketCap',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxMarketCapIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxMarketCap',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxMarketCapEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxMarketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxMarketCapGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxMarketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxMarketCapLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxMarketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxMarketCapBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxMarketCap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxPEIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxPE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxPEIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxPE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxPEEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxPEGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxPE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxPELessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxPE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxPEBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxPE',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxROCEIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxROCE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxROCEIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxROCE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxROCEEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxROCE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxROCEGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxROCE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxROCELessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxROCE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxROCEBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxROCE',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxROEIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxROE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxROEIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxROE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxROEEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxROE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      maxROEGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxROE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxROELessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxROE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> maxROEBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxROE',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minDividendYieldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minDividendYield',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minDividendYieldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minDividendYield',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minDividendYieldEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minDividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minDividendYieldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minDividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minDividendYieldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minDividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minDividendYieldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minDividendYield',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minMarketCapIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minMarketCap',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minMarketCapIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minMarketCap',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minMarketCapEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minMarketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minMarketCapGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minMarketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minMarketCapLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minMarketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minMarketCapBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minMarketCap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minPEIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minPE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minPEIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minPE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minPEEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minPE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minPEGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minPE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minPELessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minPE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minPEBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minPE',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minROCEIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minROCE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minROCEIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minROCE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minROCEEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minROCE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minROCEGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minROCE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minROCELessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minROCE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minROCEBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minROCE',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minROEIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minROE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minROEIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minROE',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minROEEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minROE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      minROEGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minROE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minROELessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minROE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> minROEBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minROE',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameContains(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension SavedFilterQueryObject
    on QueryBuilder<SavedFilter, SavedFilter, QFilterCondition> {}

extension SavedFilterQueryLinks
    on QueryBuilder<SavedFilter, SavedFilter, QFilterCondition> {}

extension SavedFilterQuerySortBy
    on QueryBuilder<SavedFilter, SavedFilter, QSortBy> {
  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      sortByMaxDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDividendYield', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      sortByMaxDividendYieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDividendYield', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMaxMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarketCap', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      sortByMaxMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarketCap', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMaxPE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMaxPEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMaxROCE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROCE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMaxROCEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROCE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMaxROE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMaxROEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      sortByMinDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minDividendYield', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      sortByMinDividendYieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minDividendYield', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMinMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMarketCap', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      sortByMinMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMarketCap', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMinPE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMinPEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMinROCE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROCE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMinROCEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROCE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMinROE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByMinROEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SavedFilterQuerySortThenBy
    on QueryBuilder<SavedFilter, SavedFilter, QSortThenBy> {
  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      thenByMaxDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDividendYield', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      thenByMaxDividendYieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDividendYield', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMaxMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarketCap', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      thenByMaxMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarketCap', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMaxPE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMaxPEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMaxROCE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROCE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMaxROCEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROCE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMaxROE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMaxROEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxROE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      thenByMinDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minDividendYield', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      thenByMinDividendYieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minDividendYield', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMinMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMarketCap', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy>
      thenByMinMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMarketCap', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMinPE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMinPEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minPE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMinROCE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROCE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMinROCEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROCE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMinROE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROE', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByMinROEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minROE', Sort.desc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SavedFilterQueryWhereDistinct
    on QueryBuilder<SavedFilter, SavedFilter, QDistinct> {
  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct>
      distinctByMaxDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxDividendYield');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMaxMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxMarketCap');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMaxPE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxPE');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMaxROCE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxROCE');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMaxROE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxROE');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct>
      distinctByMinDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minDividendYield');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMinMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minMarketCap');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMinPE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minPE');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMinROCE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minROCE');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByMinROE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minROE');
    });
  }

  QueryBuilder<SavedFilter, SavedFilter, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension SavedFilterQueryProperty
    on QueryBuilder<SavedFilter, SavedFilter, QQueryProperty> {
  QueryBuilder<SavedFilter, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavedFilter, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations>
      maxDividendYieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxDividendYield');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> maxMarketCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxMarketCap');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> maxPEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxPE');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> maxROCEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxROCE');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> maxROEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxROE');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations>
      minDividendYieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minDividendYield');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> minMarketCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minMarketCap');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> minPEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minPE');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> minROCEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minROCE');
    });
  }

  QueryBuilder<SavedFilter, double?, QQueryOperations> minROEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minROE');
    });
  }

  QueryBuilder<SavedFilter, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
