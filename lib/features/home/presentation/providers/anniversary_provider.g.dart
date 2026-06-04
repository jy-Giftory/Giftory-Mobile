// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$anniversaryDatasourceHash() =>
    r'24949e83ef7a71c8e2f063eaba36a517a9f28546';

/// See also [anniversaryDatasource].
@ProviderFor(anniversaryDatasource)
final anniversaryDatasourceProvider =
    AutoDisposeProvider<AnniversaryDatasource>.internal(
      anniversaryDatasource,
      name: r'anniversaryDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$anniversaryDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnniversaryDatasourceRef =
    AutoDisposeProviderRef<AnniversaryDatasource>;
String _$anniversaryRepositoryHash() =>
    r'4c2a77a4b0fa4729d52f9561773dffcd80b3dfb7';

/// See also [anniversaryRepository].
@ProviderFor(anniversaryRepository)
final anniversaryRepositoryProvider =
    AutoDisposeProvider<AnniversaryRepositoryImpl>.internal(
      anniversaryRepository,
      name: r'anniversaryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$anniversaryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnniversaryRepositoryRef =
    AutoDisposeProviderRef<AnniversaryRepositoryImpl>;
String _$anniversaryNotifierHash() =>
    r'73a61c528aac69f1c2dcaf8a91290377f770a7fd';

/// See also [AnniversaryNotifier].
@ProviderFor(AnniversaryNotifier)
final anniversaryNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AnniversaryNotifier,
      List<Anniversary>
    >.internal(
      AnniversaryNotifier.new,
      name: r'anniversaryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$anniversaryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AnniversaryNotifier = AutoDisposeAsyncNotifier<List<Anniversary>>;
String _$selectedDayHash() => r'8c6e652ff97cc8b64d348b03403e599ba425b591';

/// See also [SelectedDay].
@ProviderFor(SelectedDay)
final selectedDayProvider =
    AutoDisposeNotifierProvider<SelectedDay, DateTime>.internal(
      SelectedDay.new,
      name: r'selectedDayProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedDayHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedDay = AutoDisposeNotifier<DateTime>;
String _$focusedMonthHash() => r'4756259768b79a696b59c2afef9a644ae118c722';

/// See also [FocusedMonth].
@ProviderFor(FocusedMonth)
final focusedMonthProvider =
    AutoDisposeNotifierProvider<FocusedMonth, DateTime>.internal(
      FocusedMonth.new,
      name: r'focusedMonthProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$focusedMonthHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FocusedMonth = AutoDisposeNotifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
