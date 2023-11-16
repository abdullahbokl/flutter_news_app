import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // change the colors based on the theme mode
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.background,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
