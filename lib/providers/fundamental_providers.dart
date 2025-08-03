// providers/fundamental_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/fundamental_filter.dart';

// Enhanced providers for fundamental analysis
final selectedFundamentalProvider =
    StateProvider<FundamentalFilter?>((ref) => null);

final tabAnimationController =
    StateProvider<AnimationController?>((ref) => null);
