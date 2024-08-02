import 'package:eshop/common/widgets/bottom_bar.dart';
import 'package:eshop/common/widgets/splash_screen.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/screens/phone.dart';
import 'package:eshop/features/auth/screens/auth_screen.dart';
import 'package:eshop/features/auth/services/auth_service.dart';
import 'package:eshop/features/home/screens/admin_code_screen.dart';
import 'package:eshop/features/home/screens/code_input_screen.dart';
import 'package:eshop/providers/user_provider.dart';
import 'package:eshop/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';



final FlutterLocalNotificationsPlugin notificationsPlugin =FlutterLocalNotificationsPlugin();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

   WidgetsFlutterBinding.ensureInitialized();

  // initializeTimeZones();

  AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

  DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true
    
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings
  );

  bool? initialized = await notificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      // log(response.payload.toString());
    }
  );

  // log("Notifications: $initialized");

  runApp(
    MultiProvider(
      providers: [
     ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => OrderProvider()), // Assuming you need OrderProvider as well
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'farcon',
  theme: ThemeData(
    scaffoldBackgroundColor: GlobalVariables.backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: GlobalVariables.secondaryColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    fontFamily: 'Poppins', // Add the font family here
  ),
  onGenerateRoute: (settings) => generateRoute(settings),
  home: 
  // MapPage(),
  // Provider.of<UserProvider>(context).user.token.isNotEmpty
  //     ? Provider.of<UserProvider>(context).user.type == 'user'
  //         ? const BottomBar()
  //         : const AdminScreen()
          
  //     : const AuthScreen(),



  Consumer<UserProvider>(
  builder: (context, userProvider, _) {
    if (userProvider.user.token.isNotEmpty) {
      return userProvider.user.type == 'user'
          ? const 
          CodeInputScreen()
          : userProvider.user.type == 'admin'
              ? const AdminCodeScreen(
                
              )
              // const CategoryDeals()
              // : userProvider.user.type == 'rent'
              //     ? const AdminAccommodationScreen()
                  : const 
                  AuthScreen();
    } else {
      return SplashScreen();
    }
  },
),

);

  }
}