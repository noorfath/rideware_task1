import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:rideware_task1/controller/cartprovider.dart';
import 'view/pages/login.dart'; // Import your pages and providers

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()), // Provide CartProvider
        // Add other providers here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignupScreen(), // Starting screen of your app
      ),
    );
  }
}
