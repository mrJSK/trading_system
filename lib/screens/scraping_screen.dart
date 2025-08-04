import 'package:flutter/material.dart';
import 'dart:async';
import '../services/background_scraping_service.dart';
import '../services/database_service.dart';
import '../models/company.dart';

class ScrapingScreen extends StatefulWidget {
  @override
  _ScrapingScreenState createState() => _ScrapingScreenState();
}

class _ScrapingScreenState extends State<ScrapingScreen>
    with WidgetsBindingObserver {
  final BackgroundScrapingService _backgroundService =
      BackgroundScrapingService();
  final DatabaseService _databaseService = DatabaseService();

  String _scrapingStatus = 'idle';
  Map<String, dynamic> _scrapingProgress = {};
  List<Company> _allCompanies = [];
  List<String> _logs = [];
  Timer? _statusTimer;
  String _lastLoggedProgress = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeServices();
    _loadExistingCompanies();
    _startListeningToProgress();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _statusTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeServices() async {
    await _backgroundService.initialise();
    final status = await _backgroundService.getScrapingStatus();
    final progress = await _backgroundService.getScrapingProgress();

    setState(() {
      _scrapingStatus = status;
      _scrapingProgress = progress;
    });

    if (status != 'idle' && status != 'completed') {
      _addLog('📱 Resumed monitoring background scraping...');
      _addLog('📊 Current status: $status');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _addLog('📱 App resumed - Checking background progress');
        _refreshStatusImmediately();
        break;
      case AppLifecycleState.paused:
        _addLog('🔄 App paused - Scraping continues in background');
        break;
      case AppLifecycleState.detached:
        _addLog('💾 App closed - Scraping continues in background');
        break;
      default:
        break;
    }
  }

  Future<void> _refreshStatusImmediately() async {
    await _refreshStatus();
    if (_scrapingStatus == 'completed') {
      await _loadExistingCompanies();
    }
  }

  Future<void> _refreshStatus() async {
    final status = await _backgroundService.getScrapingStatus();
    final progress = await _backgroundService.getScrapingProgress();

    setState(() {
      _scrapingStatus = status;
      _scrapingProgress = progress;
    });
  }

  Future<void> _loadExistingCompanies() async {
    try {
      final companies = await _databaseService.getAllCompanies();
      setState(() {
        _allCompanies = companies;
      });
      _addLog('📊 Database updated: ${companies.length} companies total');
    } catch (e) {
      _addLog('❌ Error loading companies: $e');
    }
  }

  void _startListeningToProgress() {
    _statusTimer =
        Timer.periodic(const Duration(milliseconds: 1500), (timer) async {
      final status = await _backgroundService.getScrapingStatus();
      final progress = await _backgroundService.getScrapingProgress();

      if (mounted) {
        final previousStatus = _scrapingStatus;
        setState(() {
          _scrapingStatus = status;
          _scrapingProgress = progress;
        });

        if (status != previousStatus) {
          switch (status) {
            case 'list_scraping':
              _addLog('🚀 List scraping started in background');
              break;
            case 'data_scraping':
              _addLog('🔍 Data scraping started in background');
              break;
            case 'completed':
              final type = progress['type'] ?? 'unknown';
              if (type == 'list_scraping') {
                final total = progress['totalCompanies'] ?? 0;
                _addLog('🎉 List scraping completed! Found $total companies');
                Future.delayed(const Duration(milliseconds: 500), () {
                  _loadExistingCompanies();
                });
              } else if (type == 'data_scraping') {
                final successful = progress['successful'] ?? 0;
                final processed = progress['processed'] ?? 0;
                _addLog(
                    '🎉 Data scraping completed! $successful/$processed successful');
              }
              break;
            case 'stopped':
              _addLog('⏹️ Scraping stopped by user');
              break;
            case 'error':
              _addLog(
                  '❌ Scraping error: ${progress['error'] ?? 'Unknown error'}');
              break;
          }
        }

        String currentProgress = '';
        if (status == 'list_scraping' && progress['currentPage'] != null) {
          final current = progress['currentPage'] ?? 0;
          final total = progress['totalPages'] ?? 0;
          final companies = progress['companiesFound'] ?? 0;
          currentProgress = 'list_$current/${total}_$companies';

          if (current > 0 && currentProgress != _lastLoggedProgress) {
            _addLog(
                '📄 Page $current/$total completed - Found $companies companies total');
            _lastLoggedProgress = currentProgress;
          }
        } else if (status == 'data_scraping' && progress['current'] != null) {
          final current = progress['current'] ?? 0;
          final total = progress['total'] ?? 0;
          final successful = progress['successful'] ?? 0;
          currentProgress = 'data_$current/$total';

          if (current > 0 &&
              current % 5 == 0 &&
              currentProgress != _lastLoggedProgress) {
            _addLog(
                '📊 Data scraping: $current/$total processed ($successful successful)');
            _lastLoggedProgress = currentProgress;
          }
        }
      }
    });
  }

  void _addLog(String message) {
    if (mounted) {
      setState(() {
        _logs.insert(
            0, '${DateTime.now().toString().substring(11, 19)}: $message');
        if (_logs.length > 150) {
          _logs.removeRange(150, _logs.length);
        }
      });
    }
    print('ScrapingLog: $message');
  }

  @override
  Widget build(BuildContext context) {
    final isListScraping = _scrapingStatus == 'list_scraping';
    final isDataScraping = _scrapingStatus == 'data_scraping';
    final isAnyActive = isListScraping || isDataScraping;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Scraping',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 26),
            onPressed: () async {
              _addLog('🔄 Manually refreshing status...');
              await _refreshStatusImmediately();
            },
            tooltip: 'Refresh Status',
            padding: const EdgeInsets.all(12),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 26),
            padding: const EdgeInsets.all(12),
            onSelected: (value) {
              switch (value) {
                case 'clear_logs':
                  _clearLogs();
                  break;
                case 'clear_database':
                  _showClearDatabaseDialog();
                  break;
                case 'refresh_stats':
                  _loadExistingCompanies();
                  _refreshStatus();
                  break;
                case 'view_database':
                  _showDatabaseStats();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_logs',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, size: 22),
                    SizedBox(width: 12),
                    Text('Clear Logs', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'view_database',
                child: Row(
                  children: [
                    Icon(Icons.analytics, size: 22),
                    SizedBox(width: 12),
                    Text('Database Stats', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_database',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever, color: Colors.red, size: 22),
                    SizedBox(width: 12),
                    Text('Clear Database',
                        style: TextStyle(fontSize: 16, color: Colors.red)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'refresh_stats',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 22),
                    SizedBox(width: 12),
                    Text('Refresh All', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                isAnyActive
                                    ? Icons.cloud_sync
                                    : _scrapingStatus == 'completed'
                                        ? Icons.cloud_done
                                        : Icons.cloud_off,
                                key: ValueKey(_scrapingStatus),
                                color: _getStatusColor(),
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Background Service Status',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getStatusDescription(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _getStatusColor(),
                                    _getStatusColor().withOpacity(0.7)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _scrapingStatus.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.list_alt,
                                size: 24, color: Colors.blue),
                            const SizedBox(width: 12),
                            Text(
                              'Company List Scraping',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (isListScraping) ...[
                          Text(
                            'Pages: ${_scrapingProgress['currentPage'] ?? 0}/${_scrapingProgress['totalPages'] ?? 0}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(height: 12),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: LinearProgressIndicator(
                              value: _scrapingProgress['totalPages'] != null &&
                                      _scrapingProgress['totalPages'] > 0
                                  ? (_scrapingProgress['currentPage'] ?? 0) /
                                      _scrapingProgress['totalPages']
                                  : 0.0,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Companies found: ${_scrapingProgress['companiesFound'] ?? 0}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 14),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Icon(Icons.storage,
                                  size: 18, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              Text(
                                'Database: ${_allCompanies.length} companies',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: AnimatedScale(
                                scale: isListScraping ? 0.95 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: ElevatedButton.icon(
                                  onPressed: isListScraping
                                      ? null
                                      : _showPageSelectionDialog,
                                  icon: Icon(
                                      isListScraping
                                          ? Icons.cloud_sync
                                          : Icons.play_arrow,
                                      size: 22),
                                  label: Text(
                                    isListScraping
                                        ? 'Running in Background...'
                                        : 'Start Scraping',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: isListScraping
                                        ? Colors.grey[300]
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            AnimatedScale(
                              scale: isListScraping ? 1.0 : 0.95,
                              duration: const Duration(milliseconds: 200),
                              child: ElevatedButton.icon(
                                onPressed:
                                    isListScraping ? _stopScraping : null,
                                icon: const Icon(Icons.stop, size: 22),
                                label: const Text('Stop',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  backgroundColor:
                                      isListScraping ? Colors.red : Colors.grey,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.analytics,
                                size: 24, color: Colors.blue),
                            const SizedBox(width: 12),
                            Text(
                              'Company Data Scraping',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (isDataScraping) ...[
                          Text(
                            'Progress: ${_scrapingProgress['current'] ?? 0}/${_scrapingProgress['total'] ?? 0}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(height: 12),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: LinearProgressIndicator(
                              value: _scrapingProgress['total'] != null &&
                                      _scrapingProgress['total'] > 0
                                  ? (_scrapingProgress['current'] ?? 0) /
                                      _scrapingProgress['total']
                                  : 0.0,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Current: ${_scrapingProgress['companyName'] ?? 'Processing...'}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 14),
                          ),
                          Text(
                            'Successful: ${_scrapingProgress['successful'] ?? 0}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 14),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Icon(Icons.data_usage,
                                  size: 18, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              Text(
                                'Ready for ${_allCompanies.length} companies',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: AnimatedScale(
                                scale: isDataScraping ? 0.95 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: ElevatedButton.icon(
                                  onPressed: (isDataScraping ||
                                          _allCompanies.isEmpty ||
                                          isListScraping)
                                      ? null
                                      : _startDataScraping,
                                  icon: Icon(
                                      isDataScraping
                                          ? Icons.cloud_sync
                                          : Icons.download,
                                      size: 22),
                                  label: Text(
                                    isDataScraping
                                        ? 'Running in Background...'
                                        : 'Scrape Data',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: (isDataScraping ||
                                            _allCompanies.isEmpty ||
                                            isListScraping)
                                        ? Colors.grey[300]
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            AnimatedScale(
                              scale: isDataScraping ? 1.0 : 0.95,
                              duration: const Duration(milliseconds: 200),
                              child: ElevatedButton.icon(
                                onPressed:
                                    isDataScraping ? _stopScraping : null,
                                icon: const Icon(Icons.stop, size: 22),
                                label: const Text('Stop',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  backgroundColor:
                                      isDataScraping ? Colors.red : Colors.grey,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainer
                              .withOpacity(0.5),
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.terminal,
                                size: 26, color: Colors.blue),
                            const SizedBox(width: 12),
                            Text(
                              'Activity Logs',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_logs.length}/150',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _logs.isEmpty
                          ? Container(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.notes_outlined,
                                      size: 80, color: Colors.grey[400]),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No activity logs yet',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Start scraping to see background activity',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: _logs.length,
                                itemBuilder: (context, index) {
                                  final log = _logs[index];
                                  final isError = log.contains('❌') ||
                                      log.contains('Error');
                                  final isSuccess = log.contains('🎉') ||
                                      log.contains('completed');
                                  final isProgress =
                                      log.contains('📄') || log.contains('📊');
                                  final isSystem =
                                      log.contains('📱') || log.contains('🔄');

                                  return AnimatedOpacity(
                                    opacity: 1.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isError
                                            ? Colors.red.withOpacity(0.1)
                                            : isSuccess
                                                ? Colors.green.withOpacity(0.1)
                                                : isProgress
                                                    ? Colors.blue
                                                        .withOpacity(0.1)
                                                    : isSystem
                                                        ? Colors.orange
                                                            .withOpacity(0.1)
                                                        : Colors.grey
                                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isError
                                              ? Colors.red.withOpacity(0.3)
                                              : isSuccess
                                                  ? Colors.green
                                                      .withOpacity(0.3)
                                                  : isProgress
                                                      ? Colors.blue
                                                          .withOpacity(0.3)
                                                      : isSystem
                                                          ? Colors.orange
                                                              .withOpacity(0.3)
                                                          : Colors.grey
                                                              .withOpacity(0.2),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        log,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontFamily: 'RobotoMono',
                                              height: 1.6,
                                              fontSize: 14,
                                              color: isError
                                                  ? Colors.red[800]
                                                  : isSuccess
                                                      ? Colors.green[800]
                                                      : isProgress
                                                          ? Colors.blue[800]
                                                          : isSystem
                                                              ? Colors
                                                                  .orange[800]
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.color,
                                            ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusDescription() {
    switch (_scrapingStatus) {
      case 'list_scraping':
        return '🟢 Scraping company list in background';
      case 'data_scraping':
        return '🟢 Scraping company data in background';
      case 'completed':
        return '✅ Last operation completed successfully';
      case 'stopped':
        return '⏹️ Scraping stopped by user';
      case 'error':
        return '❌ Error occurred during scraping';
      default:
        return '⚪ Ready - ${_allCompanies.length} companies in database';
    }
  }

  Color _getStatusColor() {
    switch (_scrapingStatus) {
      case 'list_scraping':
      case 'data_scraping':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'stopped':
        return Colors.orange;
      case 'error':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _showDatabaseStats() async {
    try {
      final stats = await _databaseService.getDatabaseInfo();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.analytics, color: Colors.blue, size: 28),
              SizedBox(width: 12),
              Text('Database Statistics',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatRow('Companies', stats['totalCompanies'].toString()),
                _buildStatRow(
                    'Company Data', stats['totalCompanyData'].toString()),
                _buildStatRow(
                    'Watchlists', stats['totalWatchlists'].toString()),
                _buildStatRow('Watchlist Relations',
                    stats['totalWatchlistCompanies'].toString()),
                _buildStatRow(
                    'Saved Filters', stats['totalSavedFilters'].toString()),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.pie_chart, color: Colors.blue, size: 22),
                      const SizedBox(width: 12),
                      Text(
                        'Data Completeness: ${stats['dataCompleteness']}%',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(fontSize: 16)),
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            ),
          ],
        ),
      );
    } catch (e) {
      _addLog('❌ Error loading database stats: $e');
    }
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  Future<void> _showPageSelectionDialog() async {
    final TextEditingController pageController =
        TextEditingController(text: '5');

    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Select Pages to Scrape',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('How many pages would you like to scrape?',
                  style: TextStyle(fontSize: 14)),
              const SizedBox(height: 16),
              TextField(
                controller: pageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Pages',
                  hintText: 'Enter number (1-50)',
                  prefixIcon: const Icon(Icons.pages),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainer
                      .withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 20,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        const SizedBox(width: 12),
                        Text(
                          'Background Scraping',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '✅ Runs in background\n'
                      '✅ Safe to close app\n'
                      '✅ Progress monitored\n'
                      '📊 Each page: ~25-50 companies',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
          ),
          TextButton(
            onPressed: () {
              final pages = int.tryParse(pageController.text);
              if (pages != null && pages > 0 && pages <= 50) {
                Navigator.pop(context, pages);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Please enter a valid number between 1 and 50'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                );
              }
            },
            child: const Text('Start Scraping', style: TextStyle(fontSize: 16)),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );

    if (result != null) {
      await _backgroundService.startListScraping(result);
      _addLog('🚀 Started background scraping for $result pages');
      _refreshStatusImmediately();
    }
  }

  Future<void> _startDataScraping() async {
    await _backgroundService.startDataScraping();
    _addLog('🔍 Started background data scraping');
    _refreshStatusImmediately();
  }

  Future<void> _stopScraping() async {
    await _backgroundService.stopScraping();
    _addLog('⏹️ Stopped background scraping');
    _refreshStatusImmediately();
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
    _addLog('🧹 Logs cleared');
  }

  Future<void> _showClearDatabaseDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red, size: 28),
            SizedBox(width: 12),
            Text('Clear Database',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('This will permanently delete:',
                  style: TextStyle(fontSize: 14)),
              const SizedBox(height: 12),
              Text('• All companies (${_allCompanies.length})',
                  style: const TextStyle(fontSize: 14)),
              const Text('• All company data', style: TextStyle(fontSize: 14)),
              const Text('• All watchlists', style: TextStyle(fontSize: 14)),
              const Text('• All saved filters', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This action cannot be undone!',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child:
                const Text('Delete All Data', style: TextStyle(fontSize: 16)),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: Colors.red.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      await _clearDatabase();
    }
  }

  Future<void> _clearDatabase() async {
    try {
      _addLog('🗑️ Clearing database...');

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: const Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Clearing database...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );

      await _databaseService.clearAllData();

      setState(() {
        _allCompanies.clear();
      });

      Navigator.pop(context);

      _addLog('✅ Database cleared successfully');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Database cleared successfully',
              style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      _addLog('❌ Error clearing database: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error clearing database: $e',
              style: const TextStyle(fontSize: 16)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      );
    }
  }
}
