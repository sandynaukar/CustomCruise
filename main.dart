import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'screens/LoginScreen.dart';
import 'screens/RegisterScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/CustomizationScreen.dart';
import 'screens/ECommerceScreen.dart';
import 'screens/CommunityScreen.dart';
import 'screens/NearbyMechanicsScreen.dart';
import 'screens/CartScreen.dart';
import 'screens/ProductDetailsScreen.dart';
import 'screens/ARPreviewScreen.dart';
import 'screens/MechanicQuotesScreen.dart';
import 'screens/MechanicRegistrationScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const CustomCruiseApp());
}

class CustomCruiseApp extends StatelessWidget {
  const CustomCruiseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Cruise',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: Color(0xFF1E1E1E),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.raleway(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.raleway(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: GoogleFonts.raleway(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: GoogleFonts.poppins(color: Colors.orange[300], fontSize: 22, fontWeight: FontWeight.w600),
          titleLarge: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          bodyLarge: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
          bodyMedium: GoogleFonts.roboto(color: Colors.white70, fontSize: 14),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: GoogleFonts.raleway(color: Colors.orange[300], fontSize: 24, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.orange[300]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          shadowColor: Colors.orange.withOpacity(0.2),
        ),
      ),
      home: VideoSplashScreen(child: const LoginScreen()),
      routes: {
        '/home': (context) => const MainScreen(),
        '/register': (context) => const RegisterScreen(),
        '/product_details': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return ProductDetailsScreen(
            productName: args['productName'] as String,
            price: args['price'] as double,
            imageAsset: args['imageAsset'] as String,
          );
        },
        '/ar_preview': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return ARPreviewScreen(customizations: args);
        },
        '/mechanic_quotes': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return MechanicQuotesScreen(customizations: args);
        },
        '/mechanic_registration': (context) => const MechanicRegistrationScreen(),
      },
    );
  }
}

class VideoSplashScreen extends StatefulWidget {
  final Widget child;

  const VideoSplashScreen({Key? key, required this.child}) : super(key: key);

  @override
  _VideoSplashScreenState createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _controller;
  bool _isVideoFinished = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/WELCOME_VIDEO.mp4');
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
      _controller.addListener(_checkVideoEnd);
    }).catchError((error) {
      print("Error initializing video: $error");
      setState(() {
        _hasError = true;
      });
    });
  }

  void _checkVideoEnd() {
    if (_controller.value.position >= _controller.value.duration) {
      setState(() {
        _isVideoFinished = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError || _isVideoFinished) {
      return widget.child;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(color: Colors.orange),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController!.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeScreen(),
          CustomizationScreen(),
          ECommerceScreen(),
          CommunityScreen(),
          NearbyMechanicsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.orange.withOpacity(0.2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _tabController?.animateTo(index);
              });
            },
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.orange[300],
            unselectedItemColor: Colors.white54,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.poppins(),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.build),
                label: 'Customize',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.build_circle),
                label: 'Mechanics',
              ),
            ],
          ),
        ),
      ),
    );
  }
}