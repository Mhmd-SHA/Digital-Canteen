import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.isLoading,
  });
  final VoidCallback onPressed;
  final String buttonText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child:
            isLoading
                ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                )
                : Center(
                  child: Text(
                    buttonText,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
      ),
    );
  }
}
