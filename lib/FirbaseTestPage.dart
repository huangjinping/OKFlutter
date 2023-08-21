import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

/**
 * https://juejin.cn/post/6919777925173051405
 */
class FirbaseTestPage extends StatefulWidget {
  const FirbaseTestPage({super.key});

  @override
  State<FirbaseTestPage> createState() => _FirbaseTestPageState();
}

class _FirbaseTestPageState extends State<FirbaseTestPage> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    super.initState();
  }

  onPoint() {
    print("object1");
    _sendAnalyticsEvent();
  }

  Future<void> _sendAnalyticsEvent() async {
    // Only strings and numbers (longs & doubles for android, ints and doubles for iOS) are supported for GA custom event parameters:
    // https://firebase.google.com/docs/reference/ios/firebaseanalytics/api/reference/Classes/FIRAnalytics#+logeventwithname:parameters:
    // https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics#public-void-logevent-string-name,-bundle-params
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        'bool': true.toString(),
      },
    );
  }

  onBug() {
    print("onBug");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            MaterialButton(
              onPressed: onPoint,
              child: Text("点击打点"),
            ),
            MaterialButton(
              onPressed: onBug,
              child: Text("制造bug"),
            ),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text("Throw Test Exception 测试的bug1"),
            ),
            ElevatedButton(
              onPressed: () async {
                print("object==========01");

                // Delay crash for 5 seconds
                sleep(const Duration(seconds: 5));
                print("object==========02");

                // Use FirebaseCrashlytics to throw an error. Use this for
                // confirmation that errors are being correctly reported.
                FirebaseCrashlytics.instance.crash();
                print("object==========03");
              },
              child: const Text('Crash'),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'Thrown error has been caught and sent to Crashlytics.'),
                  duration: Duration(seconds: 5),
                ));

                // Example of thrown error, it will be caught and sent to
                // Crashlytics.
                throw StateError('Uncaught error thrown by app');
              },
              child: const Text('Throw Error'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Recorded Error'),
                    duration: Duration(seconds: 5),
                  ));
                  throw Error();
                } catch (e, s) {
                  // "reason" will append the word "thrown" in the
                  // Crashlytics console.
                  await FirebaseCrashlytics.instance.recordError(e, s,
                      reason: 'as an example of fatal error', fatal: true);
                }
              },
              child: const Text('Record Fatal Error'),
            ),
          ],
        ));
  }
}
