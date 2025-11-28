// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_chat_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$voiceChatPageViewModelHash() =>
    r'f57c7f563e70913675584565cb9fadfbea52bd18';

/// Voice Chat Page ViewModel
///
/// Manages OpenAI Realtime API connection, audio recording, and playback
///
/// Copied from [VoiceChatPageViewModel].
@ProviderFor(VoiceChatPageViewModel)
final voiceChatPageViewModelProvider =
    AutoDisposeNotifierProvider<
      VoiceChatPageViewModel,
      PageState<VoiceChatPageUiState, VoiceChatPageAction>
    >.internal(
      VoiceChatPageViewModel.new,
      name: r'voiceChatPageViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$voiceChatPageViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VoiceChatPageViewModel =
    AutoDisposeNotifier<PageState<VoiceChatPageUiState, VoiceChatPageAction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
