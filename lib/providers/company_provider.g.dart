// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$topCompaniesHash() => r'6c4c02f4c32af3d32e5ed1994dda38e899c5404a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [topCompanies].
@ProviderFor(topCompanies)
const topCompaniesProvider = TopCompaniesFamily();

/// See also [topCompanies].
class TopCompaniesFamily extends Family<AsyncValue<List<CompanyModel>>> {
  /// See also [topCompanies].
  const TopCompaniesFamily();

  /// See also [topCompanies].
  TopCompaniesProvider call({
    String sortBy = 'comprehensiveScore',
  }) {
    return TopCompaniesProvider(
      sortBy: sortBy,
    );
  }

  @override
  TopCompaniesProvider getProviderOverride(
    covariant TopCompaniesProvider provider,
  ) {
    return call(
      sortBy: provider.sortBy,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'topCompaniesProvider';
}

/// See also [topCompanies].
class TopCompaniesProvider
    extends AutoDisposeFutureProvider<List<CompanyModel>> {
  /// See also [topCompanies].
  TopCompaniesProvider({
    String sortBy = 'comprehensiveScore',
  }) : this._internal(
          (ref) => topCompanies(
            ref as TopCompaniesRef,
            sortBy: sortBy,
          ),
          from: topCompaniesProvider,
          name: r'topCompaniesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$topCompaniesHash,
          dependencies: TopCompaniesFamily._dependencies,
          allTransitiveDependencies:
              TopCompaniesFamily._allTransitiveDependencies,
          sortBy: sortBy,
        );

  TopCompaniesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sortBy,
  }) : super.internal();

  final String sortBy;

  @override
  Override overrideWith(
    FutureOr<List<CompanyModel>> Function(TopCompaniesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopCompaniesProvider._internal(
        (ref) => create(ref as TopCompaniesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sortBy: sortBy,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CompanyModel>> createElement() {
    return _TopCompaniesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopCompaniesProvider && other.sortBy == sortBy;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sortBy.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TopCompaniesRef on AutoDisposeFutureProviderRef<List<CompanyModel>> {
  /// The parameter `sortBy` of this provider.
  String get sortBy;
}

class _TopCompaniesProviderElement
    extends AutoDisposeFutureProviderElement<List<CompanyModel>>
    with TopCompaniesRef {
  _TopCompaniesProviderElement(super.provider);

  @override
  String get sortBy => (origin as TopCompaniesProvider).sortBy;
}

String _$companiesBySectorHash() => r'cda9cdcb24dcba69739516fbd94cbedacace0972';

/// See also [companiesBySector].
@ProviderFor(companiesBySector)
final companiesBySectorProvider =
    AutoDisposeFutureProvider<Map<String, List<CompanyModel>>>.internal(
  companiesBySector,
  name: r'companiesBySectorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companiesBySectorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CompaniesBySectorRef
    = AutoDisposeFutureProviderRef<Map<String, List<CompanyModel>>>;
String _$searchResultsHash() => r'8c8f46ea4a1b39521f4d016f8ecc1b9ed43d7f20';

/// See also [searchResults].
@ProviderFor(searchResults)
const searchResultsProvider = SearchResultsFamily();

/// See also [searchResults].
class SearchResultsFamily extends Family<AsyncValue<List<CompanyModel>>> {
  /// See also [searchResults].
  const SearchResultsFamily();

  /// See also [searchResults].
  SearchResultsProvider call(
    String query,
  ) {
    return SearchResultsProvider(
      query,
    );
  }

  @override
  SearchResultsProvider getProviderOverride(
    covariant SearchResultsProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchResultsProvider';
}

/// See also [searchResults].
class SearchResultsProvider
    extends AutoDisposeFutureProvider<List<CompanyModel>> {
  /// See also [searchResults].
  SearchResultsProvider(
    String query,
  ) : this._internal(
          (ref) => searchResults(
            ref as SearchResultsRef,
            query,
          ),
          from: searchResultsProvider,
          name: r'searchResultsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchResultsHash,
          dependencies: SearchResultsFamily._dependencies,
          allTransitiveDependencies:
              SearchResultsFamily._allTransitiveDependencies,
          query: query,
        );

  SearchResultsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<CompanyModel>> Function(SearchResultsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchResultsProvider._internal(
        (ref) => create(ref as SearchResultsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CompanyModel>> createElement() {
    return _SearchResultsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchResultsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchResultsRef on AutoDisposeFutureProviderRef<List<CompanyModel>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchResultsProviderElement
    extends AutoDisposeFutureProviderElement<List<CompanyModel>>
    with SearchResultsRef {
  _SearchResultsProviderElement(super.provider);

  @override
  String get query => (origin as SearchResultsProvider).query;
}

String _$filteredCompaniesHash() => r'e7a6b439d7ff61a284fd359014fa7652fed16d9c';

/// See also [filteredCompanies].
@ProviderFor(filteredCompanies)
const filteredCompaniesProvider = FilteredCompaniesFamily();

/// See also [filteredCompanies].
class FilteredCompaniesFamily extends Family<AsyncValue<List<CompanyModel>>> {
  /// See also [filteredCompanies].
  const FilteredCompaniesFamily();

  /// See also [filteredCompanies].
  FilteredCompaniesProvider call(
    List<FundamentalType> filters,
  ) {
    return FilteredCompaniesProvider(
      filters,
    );
  }

  @override
  FilteredCompaniesProvider getProviderOverride(
    covariant FilteredCompaniesProvider provider,
  ) {
    return call(
      provider.filters,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredCompaniesProvider';
}

/// See also [filteredCompanies].
class FilteredCompaniesProvider
    extends AutoDisposeFutureProvider<List<CompanyModel>> {
  /// See also [filteredCompanies].
  FilteredCompaniesProvider(
    List<FundamentalType> filters,
  ) : this._internal(
          (ref) => filteredCompanies(
            ref as FilteredCompaniesRef,
            filters,
          ),
          from: filteredCompaniesProvider,
          name: r'filteredCompaniesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredCompaniesHash,
          dependencies: FilteredCompaniesFamily._dependencies,
          allTransitiveDependencies:
              FilteredCompaniesFamily._allTransitiveDependencies,
          filters: filters,
        );

  FilteredCompaniesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filters,
  }) : super.internal();

  final List<FundamentalType> filters;

  @override
  Override overrideWith(
    FutureOr<List<CompanyModel>> Function(FilteredCompaniesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredCompaniesProvider._internal(
        (ref) => create(ref as FilteredCompaniesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filters: filters,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CompanyModel>> createElement() {
    return _FilteredCompaniesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredCompaniesProvider && other.filters == filters;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filters.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredCompaniesRef on AutoDisposeFutureProviderRef<List<CompanyModel>> {
  /// The parameter `filters` of this provider.
  List<FundamentalType> get filters;
}

class _FilteredCompaniesProviderElement
    extends AutoDisposeFutureProviderElement<List<CompanyModel>>
    with FilteredCompaniesRef {
  _FilteredCompaniesProviderElement(super.provider);

  @override
  List<FundamentalType> get filters =>
      (origin as FilteredCompaniesProvider).filters;
}

String _$similarCompaniesHash() => r'aac6cdd4df99e025fe4c0e9fd4cf186e9200426a';

/// See also [similarCompanies].
@ProviderFor(similarCompanies)
const similarCompaniesProvider = SimilarCompaniesFamily();

/// See also [similarCompanies].
class SimilarCompaniesFamily extends Family<AsyncValue<List<CompanyModel>>> {
  /// See also [similarCompanies].
  const SimilarCompaniesFamily();

  /// See also [similarCompanies].
  SimilarCompaniesProvider call(
    String symbol,
  ) {
    return SimilarCompaniesProvider(
      symbol,
    );
  }

  @override
  SimilarCompaniesProvider getProviderOverride(
    covariant SimilarCompaniesProvider provider,
  ) {
    return call(
      provider.symbol,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'similarCompaniesProvider';
}

/// See also [similarCompanies].
class SimilarCompaniesProvider
    extends AutoDisposeFutureProvider<List<CompanyModel>> {
  /// See also [similarCompanies].
  SimilarCompaniesProvider(
    String symbol,
  ) : this._internal(
          (ref) => similarCompanies(
            ref as SimilarCompaniesRef,
            symbol,
          ),
          from: similarCompaniesProvider,
          name: r'similarCompaniesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$similarCompaniesHash,
          dependencies: SimilarCompaniesFamily._dependencies,
          allTransitiveDependencies:
              SimilarCompaniesFamily._allTransitiveDependencies,
          symbol: symbol,
        );

  SimilarCompaniesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.symbol,
  }) : super.internal();

  final String symbol;

  @override
  Override overrideWith(
    FutureOr<List<CompanyModel>> Function(SimilarCompaniesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SimilarCompaniesProvider._internal(
        (ref) => create(ref as SimilarCompaniesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        symbol: symbol,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CompanyModel>> createElement() {
    return _SimilarCompaniesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarCompaniesProvider && other.symbol == symbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, symbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SimilarCompaniesRef on AutoDisposeFutureProviderRef<List<CompanyModel>> {
  /// The parameter `symbol` of this provider.
  String get symbol;
}

class _SimilarCompaniesProviderElement
    extends AutoDisposeFutureProviderElement<List<CompanyModel>>
    with SimilarCompaniesRef {
  _SimilarCompaniesProviderElement(super.provider);

  @override
  String get symbol => (origin as SimilarCompaniesProvider).symbol;
}

String _$companyDetailsHash() => r'523716c1ba83c803761287b0bb0866e5f6a124f5';

/// See also [companyDetails].
@ProviderFor(companyDetails)
const companyDetailsProvider = CompanyDetailsFamily();

/// See also [companyDetails].
class CompanyDetailsFamily extends Family<AsyncValue<CompanyModel?>> {
  /// See also [companyDetails].
  const CompanyDetailsFamily();

  /// See also [companyDetails].
  CompanyDetailsProvider call(
    String symbol,
  ) {
    return CompanyDetailsProvider(
      symbol,
    );
  }

  @override
  CompanyDetailsProvider getProviderOverride(
    covariant CompanyDetailsProvider provider,
  ) {
    return call(
      provider.symbol,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'companyDetailsProvider';
}

/// See also [companyDetails].
class CompanyDetailsProvider extends AutoDisposeFutureProvider<CompanyModel?> {
  /// See also [companyDetails].
  CompanyDetailsProvider(
    String symbol,
  ) : this._internal(
          (ref) => companyDetails(
            ref as CompanyDetailsRef,
            symbol,
          ),
          from: companyDetailsProvider,
          name: r'companyDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$companyDetailsHash,
          dependencies: CompanyDetailsFamily._dependencies,
          allTransitiveDependencies:
              CompanyDetailsFamily._allTransitiveDependencies,
          symbol: symbol,
        );

  CompanyDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.symbol,
  }) : super.internal();

  final String symbol;

  @override
  Override overrideWith(
    FutureOr<CompanyModel?> Function(CompanyDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CompanyDetailsProvider._internal(
        (ref) => create(ref as CompanyDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        symbol: symbol,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CompanyModel?> createElement() {
    return _CompanyDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompanyDetailsProvider && other.symbol == symbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, symbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompanyDetailsRef on AutoDisposeFutureProviderRef<CompanyModel?> {
  /// The parameter `symbol` of this provider.
  String get symbol;
}

class _CompanyDetailsProviderElement
    extends AutoDisposeFutureProviderElement<CompanyModel?>
    with CompanyDetailsRef {
  _CompanyDetailsProviderElement(super.provider);

  @override
  String get symbol => (origin as CompanyDetailsProvider).symbol;
}

String _$highQualityStocksHash() => r'0fb71113b07c3b448c1d41f5e2bc59269f1042fc';

/// See also [highQualityStocks].
@ProviderFor(highQualityStocks)
final highQualityStocksProvider =
    AutoDisposeFutureProvider<List<CompanyModel>>.internal(
  highQualityStocks,
  name: r'highQualityStocksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$highQualityStocksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HighQualityStocksRef = AutoDisposeFutureProviderRef<List<CompanyModel>>;
String _$valueOpportunitiesHash() =>
    r'4982d1d3205be5b623ce68e7f985400fbf92cd59';

/// See also [valueOpportunities].
@ProviderFor(valueOpportunities)
final valueOpportunitiesProvider =
    AutoDisposeFutureProvider<List<CompanyModel>>.internal(
  valueOpportunities,
  name: r'valueOpportunitiesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$valueOpportunitiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ValueOpportunitiesRef
    = AutoDisposeFutureProviderRef<List<CompanyModel>>;
String _$marketSummaryHash() => r'91b4318cfd5dec29f9208bab68400261014c162a';

/// See also [marketSummary].
@ProviderFor(marketSummary)
final marketSummaryProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  marketSummary,
  name: r'marketSummaryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$marketSummaryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MarketSummaryRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
String _$companyNotifierHash() => r'27fad0221c5a20bbcefe1080e2d9bac005e622ed';

/// See also [CompanyNotifier].
@ProviderFor(CompanyNotifier)
final companyNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CompanyNotifier, List<CompanyModel>>.internal(
  CompanyNotifier.new,
  name: r'companyNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$companyNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CompanyNotifier = AutoDisposeAsyncNotifier<List<CompanyModel>>;
String _$fundamentalAnalysisHash() =>
    r'dfb217ed9610203008c0d290844338e847874eeb';

abstract class _$FundamentalAnalysis
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late final String symbol;

  FutureOr<Map<String, dynamic>> build(
    String symbol,
  );
}

/// See also [FundamentalAnalysis].
@ProviderFor(FundamentalAnalysis)
const fundamentalAnalysisProvider = FundamentalAnalysisFamily();

/// See also [FundamentalAnalysis].
class FundamentalAnalysisFamily
    extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [FundamentalAnalysis].
  const FundamentalAnalysisFamily();

  /// See also [FundamentalAnalysis].
  FundamentalAnalysisProvider call(
    String symbol,
  ) {
    return FundamentalAnalysisProvider(
      symbol,
    );
  }

  @override
  FundamentalAnalysisProvider getProviderOverride(
    covariant FundamentalAnalysisProvider provider,
  ) {
    return call(
      provider.symbol,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fundamentalAnalysisProvider';
}

/// See also [FundamentalAnalysis].
class FundamentalAnalysisProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FundamentalAnalysis, Map<String, dynamic>> {
  /// See also [FundamentalAnalysis].
  FundamentalAnalysisProvider(
    String symbol,
  ) : this._internal(
          () => FundamentalAnalysis()..symbol = symbol,
          from: fundamentalAnalysisProvider,
          name: r'fundamentalAnalysisProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fundamentalAnalysisHash,
          dependencies: FundamentalAnalysisFamily._dependencies,
          allTransitiveDependencies:
              FundamentalAnalysisFamily._allTransitiveDependencies,
          symbol: symbol,
        );

  FundamentalAnalysisProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.symbol,
  }) : super.internal();

  final String symbol;

  @override
  FutureOr<Map<String, dynamic>> runNotifierBuild(
    covariant FundamentalAnalysis notifier,
  ) {
    return notifier.build(
      symbol,
    );
  }

  @override
  Override overrideWith(FundamentalAnalysis Function() create) {
    return ProviderOverride(
      origin: this,
      override: FundamentalAnalysisProvider._internal(
        () => create()..symbol = symbol,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        symbol: symbol,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FundamentalAnalysis,
      Map<String, dynamic>> createElement() {
    return _FundamentalAnalysisProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FundamentalAnalysisProvider && other.symbol == symbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, symbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FundamentalAnalysisRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, dynamic>> {
  /// The parameter `symbol` of this provider.
  String get symbol;
}

class _FundamentalAnalysisProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FundamentalAnalysis,
        Map<String, dynamic>> with FundamentalAnalysisRef {
  _FundamentalAnalysisProviderElement(super.provider);

  @override
  String get symbol => (origin as FundamentalAnalysisProvider).symbol;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
