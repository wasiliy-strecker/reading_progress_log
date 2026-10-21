import 'package:strick_haekelbuch/core/localization/app_locale.dart';
import 'package:flutter/material.dart';

Future<bool> confirmDestructiveAction(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(message),
              const SizedBox(height: 20),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
                onPressed: () => Navigator.pop(context, true),
                icon: const Icon(Icons.delete_outline),
                label: Text(
                  confirmLabel ?? stringsOf(context).delete,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  stringsOf(context).cancel,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ) ??
      false;
}

Future<bool> confirmDiscardChanges(
  BuildContext context, {
  required String title,
  required String message,
  String? discardLabel,
  String? continueLabel,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(message),
              const SizedBox(height: 20),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  discardLabel ?? stringsOf(context).discardChanges,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  continueLabel ?? stringsOf(context).continueEditing,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ) ??
      false;
}
