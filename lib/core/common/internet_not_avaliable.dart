import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_sample_app/core/app/app_assets.dart';
import 'package:todo_sample_app/core/app/app_colors.dart';

class InternetNotAvailableWidget extends StatelessWidget {
  final VoidCallback tryAgainTap;

  const InternetNotAvailableWidget({
    Key? key,
    required this.tryAgainTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Todo\'s', style: theme.headline6),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets.noInternetConnection),
            const SizedBox(height: 10),
            Text(
              'Please connect to internet and try again',
              textAlign: TextAlign.center,
              style: theme.bodyText1,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: tryAgainTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.independenceColor,
              ),
              child: Text('Try again',
                  style: theme.headline6!.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
