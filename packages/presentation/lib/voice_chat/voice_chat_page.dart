import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'voice_chat_page_view_model.dart';

/// Voice Chat Page
///
/// Presentation layer: routing, state watching, action handling
class VoiceChatPage extends ConsumerStatefulWidget {
  const VoiceChatPage({super.key});

  @override
  ConsumerState<VoiceChatPage> createState() => _VoiceChatPageState();
}

class _VoiceChatPageState extends ConsumerState<VoiceChatPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(voiceChatPageViewModelProvider.notifier).onInitialize();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(voiceChatPageViewModelProvider);
    final viewModel = ref.read(voiceChatPageViewModelProvider.notifier);

    // Watch for actions
    ref.listen(
      voiceChatPageViewModelProvider.select((value) => value.action),
      (_, next) {
        if (!context.mounted) return;

        next.when(
          none: () {},
          showError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
          requestMicPermission: () {
            _showPermissionDialog(context, viewModel);
          },
          scrollToBottom: () {
            _scrollToBottom();
          },
        );

        viewModel.onFinishedAction();
      },
    );

    return VoiceChatPageTemplate(
      uiState: state.uiState,
      scrollController: _scrollController,
      onConnectPressed: viewModel.onConnect,
      onDisconnectPressed: viewModel.onDisconnect,
      onMicPressed: viewModel.onMicPressed,
      onMicReleased: viewModel.onMicReleased,
    );
  }

  void _showPermissionDialog(
    BuildContext context,
    VoiceChatPageViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Microphone Permission'),
        content: const Text(
          'Microphone access is required for voice chat. '
          'Would you like to grant permission?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              viewModel.onRequestMicPermission();
            },
            child: const Text('Grant'),
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
}
