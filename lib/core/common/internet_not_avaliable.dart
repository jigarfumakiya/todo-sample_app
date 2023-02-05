import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_sample_app/core/app/app_assets.dart';

class InternetNotAvailableWidget extends StatelessWidget {
  const InternetNotAvailableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
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
              onPressed: () {},
              child: const Text('Try again'),
            )
          ],
        ),
      ),
    );
  }
}
