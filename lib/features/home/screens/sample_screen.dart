// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shop/main.dart';

// class SampleScreen extends StatefulWidget {
//   const SampleScreen({super.key});

//   @override
//   State<SampleScreen> createState() => _SampleScreenState();
// }

// class _SampleScreenState extends State<SampleScreen> {

//   void showNotification() async {
//     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       "notifications-youtube",
//       "YouTube Notifications",
//       priority: Priority.max,
//       importance: Importance.max,
//       visibility: NotificationVisibility.public,
//     );

//     DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     NotificationDetails notiDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails
//     );

//     await notificationsPlugin.show(
//       0, 'Sample Notification ', 'This is notification', notiDetails);

//     // DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

//     // await notificationsPlugin.zonedSchedule(
//     //   0,
//     //   "Sample Notification",
//     //   "This is a notification",
//     //   tz.TZDateTime.from(scheduleDate, tz.local),
//     //   notiDetails,
//     //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
//     //   androidAllowWhileIdle: true,
//     //   payload: "notification-payload"
//     // );
//   }


//   // void checkForNotification() async {
//   //   NotificationAppLaunchDetails? details = await notificationsPlugin.getNotificationAppLaunchDetails();

//   //   if(details != null) {
//   //     if(details.didNotificationLaunchApp) {
//   //       NotificationResponse? response = details.notificationResponse;

//   //       if(response != null) {
//   //         String? payload = response.payload;
//   //         log("Notification Payload: $payload" as num);
//   //       }
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton:   FloatingActionButton(onPressed: showNotification,
//       child: Icon(Icons.notification_add),),
//       body: SafeArea(child: Container()),
//     );
//   }
// }



