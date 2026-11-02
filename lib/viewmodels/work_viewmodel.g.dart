// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkViewModel)
final workViewModelProvider = WorkViewModelProvider._();

final class WorkViewModelProvider
    extends $NotifierProvider<WorkViewModel, List<WorkModel>> {
  WorkViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workViewModelHash();

  @$internal
  @override
  WorkViewModel create() => WorkViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<WorkModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<WorkModel>>(value),
    );
  }
}

String _$workViewModelHash() => r'db0233b6c92a68bb39a44efe05fa49e680e32592';

abstract class _$WorkViewModel extends $Notifier<List<WorkModel>> {
  List<WorkModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<WorkModel>, List<WorkModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<WorkModel>, List<WorkModel>>,
              List<WorkModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
