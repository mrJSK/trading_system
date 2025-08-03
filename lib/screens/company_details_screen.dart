import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../models/company_model.dart';
import '../widgets/financial_tabs.dart';
import '../providers/company_provider.dart';
import '../theme/app_theme.dart';
import 'company_details_overview.dart';

class CompanyDetailsScreen extends ConsumerStatefulWidget {
  final CompanyModel company;

  const CompanyDetailsScreen({Key? key, required this.company})
      : super(key: key);

  @override
  ConsumerState<CompanyDetailsScreen> createState() =>
      _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends ConsumerState<CompanyDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this); // Updated to 8 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for real-time updates
    final companyDetails =
        ref.watch(companyDetailsProvider(widget.company.symbol));

    return Scaffold(
      appBar: _buildEnhancedAppBar(),
      body: companyDetails.when(
        data: (company) => _buildMainContent(company ?? widget.company),
        loading: () => _buildMainContent(widget.company),
        error: (error, stack) => _buildMainContent(widget.company),
      ),
    );
  }

  PreferredSizeWidget _buildEnhancedAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.company.symbol,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.company.name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      actions: [
        // Price info in app bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.company.formattedPrice,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.company.formattedChange,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: widget.company.isGainer
                      ? Colors.lightGreen[200]
                      : widget.company.isLoser
                          ? Colors.red[200]
                          : Colors.white70,
                ),
              ),
            ],
          ),
        ),
        _buildAnalysisButton(),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () => _shareCompany(context),
        ),
        IconButton(
          icon: Icon(
            _isInWatchlist ? Icons.favorite : Icons.favorite_border,
            color: _isInWatchlist ? Colors.red : Colors.white,
          ),
          onPressed: _toggleWatchlist,
        ),
      ],
    );
  }

  Widget _buildAnalysisButton() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: IconButton(
        icon: Stack(
          children: [
            const Icon(Icons.analytics, color: Colors.white),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        onPressed: () => _showAnalysisDialog(),
      ),
    );
  }

  Widget _buildMainContent(CompanyModel company) {
    return Column(
      children: [
        _buildEnhancedTabBar(),
        _buildQuickStatsBar(company),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              CompanyDetailsOverview(company: company),
              _buildAnalysisTab(company),
              _buildCleanFinancialTab('quarterly', company),
              _buildCleanFinancialTab('profit_loss', company),
              _buildCleanFinancialTab('balance_sheet', company),
              _buildCleanFinancialTab('cash_flow', company),
              _buildCleanFinancialTab('ratios', company),
              _buildCleanFinancialTab('shareholding', company),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppTheme.primaryGreen,
        unselectedLabelColor: AppTheme.textSecondary,
        indicatorColor: AppTheme.primaryGreen,
        indicatorWeight: 3,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Analysis'),
          Tab(text: 'Quarterly'),
          Tab(text: 'P&L'),
          Tab(text: 'Balance Sheet'),
          Tab(text: 'Cash Flow'),
          Tab(text: 'Ratios'),
          Tab(text: 'Shareholding'),
        ],
      ),
    );
  }

  Widget _buildQuickStatsBar(CompanyModel company) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppTheme.cardBackground,
      child: Row(
        children: [
          Expanded(
            child: _buildQuickStat(
              'Quality',
              '${company.qualityScore}/5',
              _getQualityColor(company.overallQualityGrade),
            ),
          ),
          Expanded(
            child: _buildQuickStat(
              'Piotroski',
              '${company.calculatedPiotroskiScore.toInt()}/9',
              _getPiotroskiColor(company.calculatedPiotroskiScore),
            ),
          ),
          Expanded(
            child: _buildQuickStat(
              'Risk',
              company.calculatedRiskAssessment,
              _getRiskColor(company.calculatedRiskAssessment),
            ),
          ),
          Expanded(
            child: _buildQuickStat(
              'Grade',
              company.calculatedInvestmentGrade,
              _getGradeColor(company.calculatedInvestmentGrade),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab(CompanyModel company) {
    final analysisAsync =
        ref.watch(fundamentalAnalysisProvider(company.symbol));

    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(16),
      child: analysisAsync.when(
        data: (analysis) => _buildDetailedAnalysis(analysis),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(error),
      ),
    );
  }

  Widget _buildDetailedAnalysis(Map<String, dynamic> analysis) {
    if (analysis.isEmpty)
      return const Center(child: Text('No analysis available'));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnalysisHeader(),
          const SizedBox(height: 16),
          _buildRecommendationCard(analysis),
          const SizedBox(height: 16),
          _buildScoreCards(analysis),
          const SizedBox(height: 16),
          _buildValuationAnalysis(analysis),
          const SizedBox(height: 16),
          _buildRiskAnalysis(analysis),
          const SizedBox(height: 16),
          _buildStrengthsWeaknesses(analysis),
        ],
      ),
    );
  }

  Widget _buildAnalysisHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryGreen.withOpacity(0.1), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.psychology, color: AppTheme.primaryGreen, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI-Powered Analysis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Professional-grade fundamental analysis using advanced algorithms',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(Map<String, dynamic> analysis) {
    final recommendation =
        analysis['investmentRecommendation'] as Map<String, dynamic>?;
    if (recommendation == null) return const SizedBox.shrink();

    final action = recommendation['action'] as String? ?? 'Hold';
    final reasoning = recommendation['reasoning'] as List<dynamic>? ?? [];
    final targetPrice = recommendation['targetPrice'] as double?;
    final timeHorizon = recommendation['timeHorizon'] as String?;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.recommend, color: _getRecommendationColor(action)),
                const SizedBox(width: 8),
                Text(
                  'Investment Recommendation',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getRecommendationColor(action).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getRecommendationColor(action).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    action.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getRecommendationColor(action),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (targetPrice != null) ...[
              Row(
                children: [
                  const Icon(Icons.arrow_right_alt,
                      size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    'Target Price: ₹${targetPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (timeHorizon != null) ...[
                    const SizedBox(width: 16),
                    Text(
                      'Horizon: $timeHorizon',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (reasoning.isNotEmpty) ...[
              const Text(
                'Key Reasons:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              ...reasoning.take(3).map((reason) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 14)),
                        Expanded(
                          child: Text(
                            reason.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCards(Map<String, dynamic> analysis) {
    final scores = analysis['fundamentalScores'] as Map<String, dynamic>?;
    if (scores == null) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          child: _buildScoreCard(
            'Piotroski F-Score',
            '${scores['piotroskiScore']?.toStringAsFixed(0) ?? '0'}/9',
            'Quality Assessment',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildScoreCard(
            'Altman Z-Score',
            scores['altmanZScore']?.toStringAsFixed(1) ?? '0.0',
            'Bankruptcy Risk',
            Colors.green,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildScoreCard(
            'Overall Score',
            '${scores['comprehensiveScore']?.toStringAsFixed(0) ?? '0'}/100',
            'Total Assessment',
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(
      String title, String score, String subtitle, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              score,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuationAnalysis(Map<String, dynamic> analysis) {
    final valuation = analysis['valuationMetrics'] as Map<String, dynamic>?;
    if (valuation == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Valuation Analysis',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildValuationMetric(
                    'Intrinsic Value',
                    valuation['intrinsicValue'] != null
                        ? '₹${valuation['intrinsicValue'].toStringAsFixed(0)}'
                        : 'N/A',
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildValuationMetric(
                    'Safety Margin',
                    valuation['safetyMargin'] != null
                        ? '${valuation['safetyMargin'].toStringAsFixed(1)}%'
                        : 'N/A',
                    valuation['safetyMargin'] != null &&
                            valuation['safetyMargin'] > 0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuationMetric(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskAnalysis(Map<String, dynamic> analysis) {
    final risk = analysis['riskAnalysis'] as Map<String, dynamic>?;
    if (risk == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Risk Analysis',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildRiskItem('Overall Risk', risk['overallRisk'] ?? 'Unknown'),
            _buildRiskItem('Debt Level', risk['debtLevel'] ?? 'Unknown'),
            _buildRiskItem(
                'Liquidity Status', risk['liquidityStatus'] ?? 'Unknown'),
            _buildRiskItem(
                'Profitability Trend', risk['profitabilityTrend'] ?? 'Unknown'),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _getRiskItemColor(value).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: _getRiskItemColor(value).withOpacity(0.3)),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _getRiskItemColor(value),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrengthsWeaknesses(Map<String, dynamic> analysis) {
    final recommendation =
        analysis['investmentRecommendation'] as Map<String, dynamic>?;
    if (recommendation == null) return const SizedBox.shrink();

    final strengths = recommendation['keyStrengths'] as List<dynamic>? ?? [];
    final weaknesses = recommendation['keyWeaknesses'] as List<dynamic>? ?? [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Strengths & Weaknesses',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (strengths.isNotEmpty) ...[
              const Text(
                'Key Strengths:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              ...strengths.take(3).map((strength) => _buildStrengthWeaknessItem(
                    strength.toString(),
                    true,
                  )),
              const SizedBox(height: 12),
            ],
            if (weaknesses.isNotEmpty) ...[
              const Text(
                'Areas of Concern:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              ...weaknesses
                  .take(3)
                  .map((weakness) => _buildStrengthWeaknessItem(
                        weakness.toString(),
                        false,
                      )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStrengthWeaknessItem(String text, bool isStrength) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isStrength ? Icons.check_circle : Icons.cancel,
            color: isStrength ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textPrimary,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error loading analysis',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.refresh(fundamentalAnalysisProvider(widget.company.symbol)),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildCleanFinancialTab(String type, CompanyModel company) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  _getFinancialTabIcon(type),
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  _getFinancialTabTitle(type),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  company.symbol,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FinancialTabs(
              company: company,
              initialTab: type,
            ),
          ),
        ],
      ),
    );
  }

  void _showAnalysisDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analysis Features'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeatureItem('Professional-grade fundamental analysis'),
            _buildFeatureItem('AI-powered recommendations'),
            _buildFeatureItem('Real-time risk assessment'),
            _buildFeatureItem('Comprehensive valuation models'),
            _buildFeatureItem('Peer comparison analysis'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _tabController.animateTo(1); // Switch to analysis tab
            },
            child: const Text('View Analysis'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleWatchlist() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isInWatchlist
              ? '${widget.company.symbol} added to watchlist'
              : '${widget.company.symbol} removed from watchlist',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: _isInWatchlist ? Colors.green : Colors.red,
      ),
    );
  }

  // Helper methods for colors and icons
  Color _getQualityColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getPiotroskiColor(double score) {
    if (score >= 7) return Colors.green;
    if (score >= 5) return Colors.orange;
    return Colors.red;
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'very high':
        return Colors.red[700]!;
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      case 'very low':
        return Colors.green[700]!;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'AAA':
      case 'AA':
        return Colors.green;
      case 'A':
      case 'BBB':
        return Colors.blue;
      case 'BB':
      case 'B':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  Color _getRecommendationColor(String action) {
    switch (action.toLowerCase()) {
      case 'strong buy':
        return Colors.green[700]!;
      case 'buy':
        return Colors.green;
      case 'hold':
        return Colors.orange;
      case 'sell':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getRiskItemColor(String value) {
    switch (value.toLowerCase()) {
      case 'excellent':
      case 'very low':
      case 'debt free':
        return Colors.green;
      case 'good':
      case 'low':
      case 'low debt':
        return Colors.blue;
      case 'average':
      case 'adequate':
      case 'medium':
      case 'moderate debt':
        return Colors.orange;
      case 'poor':
      case 'high':
      case 'very high':
      case 'high debt':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getFinancialTabIcon(String type) {
    switch (type) {
      case 'quarterly':
        return Icons.calendar_view_month;
      case 'profit_loss':
        return Icons.trending_up;
      case 'balance_sheet':
        return Icons.account_balance;
      case 'cash_flow':
        return Icons.water_drop;
      case 'ratios':
        return Icons.analytics;
      case 'shareholding':
        return Icons.pie_chart;
      default:
        return Icons.bar_chart;
    }
  }

  String _getFinancialTabTitle(String type) {
    switch (type) {
      case 'quarterly':
        return 'Quarterly Results';
      case 'profit_loss':
        return 'Profit & Loss';
      case 'balance_sheet':
        return 'Balance Sheet';
      case 'cash_flow':
        return 'Cash Flow';
      case 'ratios':
        return 'Financial Ratios';
      case 'shareholding':
        return 'Shareholding Pattern';
      default:
        return 'Financial Data';
    }
  }

  void _shareCompany(BuildContext context) {
    final companyInfo = '''
${widget.company.name} (${widget.company.symbol})

🏷️ Current Price: ${widget.company.formattedPrice}
📊 Change: ${widget.company.formattedChange}
💰 Market Cap: ${widget.company.formattedMarketCap}
⭐ Quality Score: ${widget.company.qualityScore}/5 (${widget.company.overallQualityGrade})
🎯 Investment Grade: ${widget.company.calculatedInvestmentGrade}

📈 Key Metrics:
• P/E Ratio: ${widget.company.stockPe?.toStringAsFixed(1) ?? 'N/A'}
• ROE: ${widget.company.roe != null ? '${widget.company.roe!.toStringAsFixed(1)}%' : 'N/A'}
• Debt-to-Equity: ${widget.company.debtToEquity?.toStringAsFixed(2) ?? 'N/A'}
• Piotroski Score: ${widget.company.calculatedPiotroskiScore.toInt()}/9

🔍 Professional Analysis:
• Risk Level: ${widget.company.calculatedRiskAssessment}
• Graham Intrinsic Value: ${widget.company.calculatedGrahamNumber != null ? '₹${widget.company.calculatedGrahamNumber!.toStringAsFixed(0)}' : 'N/A'}
• Safety Margin: ${widget.company.safetyMargin != null ? '${widget.company.safetyMargin!.toStringAsFixed(1)}%' : 'N/A'}

💡 Investment Recommendation: ${widget.company.calculatedInvestmentRecommendation}

🏢 Business Overview:
${widget.company.businessOverview.isNotEmpty ? widget.company.businessOverview.substring(0, widget.company.businessOverview.length > 200 ? 200 : widget.company.businessOverview.length) + (widget.company.businessOverview.length > 200 ? "..." : "") : "Operating in ${widget.company.formattedSector} sector"}

📊 Shared from Enhanced Trading Dashboard with Professional Analysis
''';

    Share.share(
      companyInfo,
      subject:
          '${widget.company.name} (${widget.company.symbol}) - Professional Stock Analysis',
    );
  }
}
