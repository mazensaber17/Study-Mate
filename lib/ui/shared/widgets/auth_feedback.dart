import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/assets_manager.dart';

/// Consistent, modal feedback for authentication requests.
class AuthFeedback {
  AuthFeedback._();

  static Future<void> showLoading(BuildContext context, {String? message}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              const SizedBox(width: 20),
              Expanded(child: Text(message ?? 'Please wait...')),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showSuccess(
    BuildContext context, {
    required String message,
  }) {
    return _showMessage(
      context,
      title: 'Success',
      message: message,
      icon: Icons.check_circle_rounded,
      color: Colors.green,
    );
  }

  static Future<void> showError(
    BuildContext context, {
    required String message,
  }) {
    return _showMessage(
      context,
      title: 'Something went wrong',
      message: message,
      icon: Icons.error_rounded,
      color: Colors.red,
    );
  }

  static Future<bool> showNoInternet(
    BuildContext context, {
    FutureOr<void> Function()? onTryAgain,
  }) async {
    final shouldTryAgain = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _NoInternetIllustration(),
              const SizedBox(height: 12),
              Text(
                'No internet connection',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Check your connection, then try again.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                      await onTryAgain?.call();
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return shouldTryAgain == true;
  }

  static Future<void> _showMessage(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 58, color: color),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoInternetIllustration extends StatefulWidget {
  const _NoInternetIllustration();

  @override
  State<_NoInternetIllustration> createState() =>
      _NoInternetIllustrationState();
}

class _NoInternetIllustrationState extends State<_NoInternetIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.94, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Lottie.asset(
        AssetsManager.noInternetAnimation,
        width: 180,
        height: 150,
        fit: BoxFit.contain,
        repeat: true,
        animate: true,
      ),
    );
  }
}
