import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BuildState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC BUILDER APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class BuildState with ChangeNotifier {
  List<BuildItem> _buildItems = [];
  BuildComponent? _selectedCpu;
  BuildComponent? _selectedMotherboard;
  BuildComponent? _selectedGpu;
  BuildComponent? _selectedMemory;

  List<BuildItem> get buildItems => _buildItems;
  BuildComponent? get selectedCpu => _selectedCpu;
  BuildComponent? get selectedMotherboard => _selectedMotherboard;
  BuildComponent? get selectedGpu => _selectedGpu;
  BuildComponent? get selectedMemory => _selectedMemory;

  void addBuildItem(BuildItem buildItem) {
    _buildItems.add(buildItem);
    notifyListeners();
  }

  void clearBuildItems() {
    _buildItems.clear();
    notifyListeners();
  }

  void updateBuildItem(int index, BuildItem buildItem) {
    _buildItems[index] = buildItem;
    notifyListeners();
  }

  void removeBuildItem(int index) {
    _buildItems.removeAt(index);
    notifyListeners();
  }

  void selectCpu(BuildComponent cpu) {
    _selectedCpu = cpu;
    notifyListeners();
  }

  void selectMotherboard(BuildComponent motherboard) {
    _selectedMotherboard = motherboard;
    notifyListeners();
  }

  void selectGpu(BuildComponent gpu) {
    _selectedGpu = gpu;
    notifyListeners();
  }

  void selectMemory(BuildComponent memory) {
    _selectedMemory = memory;
    notifyListeners();
  }

  void clearSelections() {
    _selectedCpu = null;
    _selectedMotherboard = null;
    _selectedGpu = null;
    _selectedMemory = null;
    notifyListeners();
  }

  double getTotalCost() {
    double total = 0;
    if (_selectedCpu != null) total += _selectedCpu!.cost;
    if (_selectedMotherboard != null) total += _selectedMotherboard!.cost;
    if (_selectedGpu != null) total += _selectedGpu!.cost;
    if (_selectedMemory != null) total += _selectedMemory!.cost;
    return total;
  }

  int getTotalTdp() {
    int total = 0;
    if (_selectedCpu != null) total += _selectedCpu!.tdp;
    if (_selectedMotherboard != null) total += _selectedMotherboard!.tdp;
    if (_selectedGpu != null) total += _selectedGpu!.tdp;
    if (_selectedMemory != null) total += _selectedMemory!.tdp;
    return total;
  }
}

class BuildComponent {
  final String name;
  final double cost;
  final int tdp;

  BuildComponent({required this.name, required this.cost, required this.tdp});
}

class BuildItem {
  String name;
  BuildComponent? selectedCpu;
  BuildComponent? selectedMotherboard;
  BuildComponent? selectedGpu;
  BuildComponent? selectedMemory;
  double totalCost;
  int totalTdp;

  BuildItem({
    required this.name,
    this.selectedCpu,
    this.selectedMotherboard,
    this.selectedGpu,
    this.selectedMemory,
    required this.totalCost,
    required this.totalTdp,
  });
}

// Landing Page
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/pcbuilder.png'), // Ensure the correct path to the image
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/buildyourdreampc.png', // Path to the new image
                width: 200, // Adjust the width to make the image smaller
              ),
            ),
            Positioned(
              bottom: 40.0, // Adjust position as needed
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Center(
                  child: Image.asset(
                    'assets/getstarted.png', // Path to the "Get Started" image
                    width: 200, // Adjust the width as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Home Page
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark gray background color
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // My Build Section
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBuildPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/mybuild.png'), // Path to the new background image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'My Build',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Featured Build Section
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeaturedBuildPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/featured.png'), // Path to the new background image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Featured Build',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Tech News Section
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TechNewsPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/tech.png'), // Path to the new background image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Tech News',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom Navigation Icons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.people, color: Colors.white),
                  onPressed: () {
                    // Handle Community button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommunityPage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    // Handle Favorite button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritePage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.store, color: Colors.white),
                  onPressed: () {
                    // Handle Store button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StorePage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    // Handle Settings button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder page template
class PlaceholderPage extends StatelessWidget {
  final String title;
  final String content;

  PlaceholderPage({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark gray background color
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          content,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

// Placeholder pages for Community, Favorite, Store, and Settings
class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Community'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Community',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildSectionContainer(
              title: 'Forums',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildForumText('Troubleshooting'),
                  buildForumText('Hardware'),
                  buildForumText('Software'),
                  buildForumText('Operating System'),
                  buildForumText('General'),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildSectionContainer(
              title: 'Build by Others',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'View more',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: buildBuildItem(
                          imagePath: 'assets/build1.png',
                          title: 'Android Theme',
                          builder: 'Builder 3',
                          cpu: 'AMD Ryzen 7 7800X3D 4.2 GHz 8-Core',
                          gpu:
                              'Gigabyte VINDIFORCE V2 GeForce RTX 4080 SUPER 16 GB',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: buildBuildItem(
                          imagePath: 'assets/build2.png',
                          title: 'My first build ever',
                          builder: 'Builder 4',
                          cpu: 'Intel Core i7-12700K 3.6 GHz 12-Core',
                          gpu: 'MSI VENTUS 2X OC GeForce RTX 3070 8 GB',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildSectionContainer(
              title: 'Guides',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildGuideText('How to build a pc?'),
                  buildGuideText('How to pick pc parts?'),
                  buildGuideText('What important parts I need?'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '©2024\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.grey[850],
      ),
    );
  }

  Widget buildSectionContainer({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.pinkAccent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget buildForumText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget buildBuildItem({
    required String imagePath,
    required String title,
    required String builder,
    required String cpu,
    required String gpu,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imagePath, height: 150, fit: BoxFit.cover),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          'by $builder',
          style: TextStyle(
            fontSize: 16,
            color: Colors.green,
          ),
        ),
        Text(
          cpu,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        Text(
          gpu,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget buildGuideText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Favorite'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Favorite',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "You don't have any favorites yet.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                '©2024\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.grey[850],
      ),
    );
  }
}

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Store',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  children: [
                    buildStoreItem('assets/amazon.png'),
                    SizedBox(height: 10),
                    buildStoreItem('assets/jbhifi.png'),
                    SizedBox(height: 10),
                    buildStoreItem('assets/mwave.png'),
                    SizedBox(height: 10),
                    buildStoreItem('assets/jwcom.png'),
                    SizedBox(height: 10),
                    buildStoreItem('assets/umart.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '©2024\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.grey[850],
      ),
    );
  }

  Widget buildStoreItem(String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Version 1.0',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  children: [
                    buildSettingsItem(
                        context, 'Manage Account', ManageAccountPage()),
                    buildSettingsItem(context, 'About us', AboutUsPage()),
                    buildSettingsItem(context, 'Contact us', ContactUsPage()),
                    buildSettingsItem(context, 'Privacy', PrivacyPage()),
                    buildSettingsItem(
                        context, 'Terms of use', TermsOfUsePage()),
                    buildSettingsItem(
                        context, 'Help and Support', HelpSupportPage()),
                    buildSettingsItem(context, 'Update', UpdatePage()),
                    buildSettingsItem(context, 'Log out', LogoutPage()),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '©2024\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.grey[850],
      ),
    );
  }

  Widget buildSettingsItem(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

// Placeholder Pages for each setting
class ManageAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Account')),
      body: Center(
          child: Text('Manage Account Page', style: TextStyle(fontSize: 24))),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body:
          Center(child: Text('About Us Page', style: TextStyle(fontSize: 24))),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us')),
      body: Center(
          child: Text('Contact Us Page', style: TextStyle(fontSize: 24))),
    );
  }
}

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy')),
      body: Center(child: Text('Privacy Page', style: TextStyle(fontSize: 24))),
    );
  }
}

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms of Use')),
      body: Center(
          child: Text('Terms of Use Page', style: TextStyle(fontSize: 24))),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help and Support')),
      body: Center(
          child: Text('Help and Support Page', style: TextStyle(fontSize: 24))),
    );
  }
}

class UpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update')),
      body: Center(child: Text('Update Page', style: TextStyle(fontSize: 24))),
    );
  }
}

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log out')),
      body: Center(child: Text('Log out Page', style: TextStyle(fontSize: 24))),
    );
  }
}

// Placeholder pages for Notifications and Profile
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "You don't have any notification yet.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                '©2024\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email Address',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Text(
              "Doesn't Have An Account? Sign Up",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle Google sign in
                  },
                  child: Image.asset(
                    'assets/google_icon.png', // Add the Google icon asset
                    width: 40,
                    height: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle Facebook sign in
                  },
                  child: Image.asset(
                    'assets/facebook_icon.png', // Add the Facebook icon asset
                    width: 40,
                    height: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle Apple sign in
                  },
                  child: Image.asset(
                    'assets/apple_icon.png', // Add the Apple icon asset
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              '©2024\nAll rights reserved',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// My Build Page
class MyBuildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark gray background color
      appBar: AppBar(
        title: Text('My Build'),
      ),
      body: Consumer<BuildState>(
        builder: (context, buildState, child) {
          return buildState.buildItems.isEmpty
              ? Center(
                  child: Text(
                    'No builds saved',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: buildState.buildItems.length,
                  itemBuilder: (context, index) {
                    final buildItem = buildState.buildItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuildDetailPage(
                              buildItem: buildItem,
                              buildIndex: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white),
                          ),
                          color: Colors.grey[850],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  buildItem.name,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.white),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditBuildPage(
                                              buildItem: buildItem,
                                              buildIndex: index,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        buildState.removeBuildItem(index);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'CPU: ${buildItem.selectedCpu?.name ?? "N/A"}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                            Text(
                              'Motherboard: ${buildItem.selectedMotherboard?.name ?? "N/A"}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                            Text(
                              'GPU: ${buildItem.selectedGpu?.name ?? "N/A"}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                            Text(
                              'Memory: ${buildItem.selectedMemory?.name ?? "N/A"}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Total Cost: \$${buildItem.totalCost.toStringAsFixed(2)}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              'Total TDP: ${buildItem.totalTdp} W',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBuildPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

// Build Detail Page
class BuildDetailPage extends StatelessWidget {
  final BuildItem buildItem;
  final int buildIndex;

  BuildDetailPage({required this.buildItem, required this.buildIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(buildItem.name),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.grey[850],
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.facebook, color: Colors.blue),
                          title: Text('Facebook',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            // Handle Facebook share
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.email, color: Colors.red),
                          title: Text('Gmail',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            // Handle Gmail share
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.message, color: Colors.blue),
                          title: Text('Messenger',
                              style: TextStyle(color: Colors.white)),
                          onTap: () {
                            // Handle Messenger share
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () async {
              final doc = pw.Document();
              doc.addPage(
                pw.Page(
                  build: (pw.Context context) {
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Build Name: ${buildItem.name}',
                            style: pw.TextStyle(
                                fontSize: 24, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 16),
                        pw.Text('CPU: ${buildItem.selectedCpu?.name ?? "N/A"}',
                            style: pw.TextStyle(fontSize: 18)),
                        pw.Text(
                            'Motherboard: ${buildItem.selectedMotherboard?.name ?? "N/A"}',
                            style: pw.TextStyle(fontSize: 18)),
                        pw.Text('GPU: ${buildItem.selectedGpu?.name ?? "N/A"}',
                            style: pw.TextStyle(fontSize: 18)),
                        pw.Text(
                            'Memory: ${buildItem.selectedMemory?.name ?? "N/A"}',
                            style: pw.TextStyle(fontSize: 18)),
                        pw.SizedBox(height: 16),
                        pw.Text(
                            'Total Cost: \$${buildItem.totalCost.toStringAsFixed(2)}',
                            style: pw.TextStyle(fontSize: 18)),
                        pw.Text('Total TDP: ${buildItem.totalTdp} W',
                            style: pw.TextStyle(fontSize: 18)),
                      ],
                    );
                  },
                ),
              );

              await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async => doc.save());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CPU: ${buildItem.selectedCpu?.name ?? "N/A"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Motherboard: ${buildItem.selectedMotherboard?.name ?? "N/A"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'GPU: ${buildItem.selectedGpu?.name ?? "N/A"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Memory: ${buildItem.selectedMemory?.name ?? "N/A"}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Total Cost: \$${buildItem.totalCost.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Total TDP: ${buildItem.totalTdp} W',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Build Page
class EditBuildPage extends StatelessWidget {
  final BuildItem buildItem;
  final int buildIndex;

  EditBuildPage({required this.buildItem, required this.buildIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark gray background color
      appBar: AppBar(
        title: Text('Edit Build'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildEditableComponent(
                    context,
                    'CPU',
                    buildItem.selectedCpu,
                    Icons.memory,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SelectCPUPage(editIndex: buildIndex),
                        ),
                      );
                    },
                  ),
                  buildEditableComponent(
                    context,
                    'Motherboard',
                    buildItem.selectedMotherboard,
                    Icons.storage,
                    () {
                      // Handle motherboard selection
                    },
                  ),
                  buildEditableComponent(
                    context,
                    'GPU',
                    buildItem.selectedGpu,
                    Icons.tv,
                    () {
                      // Handle GPU selection
                    },
                  ),
                  buildEditableComponent(
                    context,
                    'Memory',
                    buildItem.selectedMemory,
                    Icons.sd_card,
                    () {
                      // Handle memory selection
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final buildState =
                    Provider.of<BuildState>(context, listen: false);
                buildState.updateBuildItem(
                  buildIndex,
                  BuildItem(
                    name: buildItem.name,
                    selectedCpu: buildState.selectedCpu,
                    selectedMotherboard: buildState.selectedMotherboard,
                    selectedGpu: buildState.selectedGpu,
                    selectedMemory: buildState.selectedMemory,
                    totalCost: buildState.getTotalCost(),
                    totalTdp: buildState.getTotalTdp(),
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableComponent(BuildContext context, String title,
      BuildComponent? component, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Icon(icon, color: Colors.yellow, size: 40),
              SizedBox(height: 10),
              Text(
                '$title: ${component?.name ?? "N/A"}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add Build Page
class AddBuildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark gray background color
      appBar: AppBar(
        title: Text('Add Build'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomBuildPage()),
                );
              },
              child: Image.asset(
                'assets/custombuild.png', // Path to the Custom Build image
                width: 260, // Adjust the width as needed
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Handle Auto-builder press
              },
              child: Image.asset(
                'assets/autobuild.png', // Path to the Auto-builder image
                width: 260, // Adjust the width as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Build Page
class CustomBuildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<BuildState>(context, listen: false).clearSelections();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900], // Dark gray background color
        appBar: AppBar(
          title: Text('Custom Build'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Specification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Consumer<BuildState>(
                  builder: (context, buildState, child) {
                    return Column(
                      children: [
                        buildState.selectedCpu != null
                            ? buildSelectedComponent(
                                context, buildState.selectedCpu!, 'CPU')
                            : buildCustomButton(
                                Icons.memory, 'Add CPU', context, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectCPUPage()),
                                );
                              }),
                        buildState.selectedMotherboard != null
                            ? buildSelectedComponent(context,
                                buildState.selectedMotherboard!, 'Motherboard')
                            : buildCustomButton(
                                Icons.storage, 'Add Motherboard', context, () {
                                // Handle Add Motherboard press
                              }),
                        buildState.selectedGpu != null
                            ? buildSelectedComponent(
                                context, buildState.selectedGpu!, 'GPU')
                            : buildCustomButton(Icons.tv, 'Add GPU', context,
                                () {
                                // Handle Add GPU press
                              }),
                        buildState.selectedMemory != null
                            ? buildSelectedComponent(
                                context, buildState.selectedMemory!, 'Memory')
                            : buildCustomButton(
                                Icons.sd_card, 'Add Memory', context, () {
                                // Handle Add Memory press
                              }),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Consumer<BuildState>(
                  builder: (context, buildState, child) {
                    return Column(
                      children: [
                        Text(
                          'Compatibility: N/A   Watts: ${buildState.getTotalTdp()} W',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total: \$${buildState.getTotalCost().toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildBottomButton(Icons.share, 'Share', context, () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color: Colors.grey[850],
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading:
                                      Icon(Icons.facebook, color: Colors.blue),
                                  title: Text('Facebook',
                                      style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    // Handle Facebook share
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.email, color: Colors.red),
                                  title: Text('Gmail',
                                      style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    // Handle Gmail share
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading:
                                      Icon(Icons.message, color: Colors.blue),
                                  title: Text('Messenger',
                                      style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    // Handle Messenger share
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                    buildBottomButton(Icons.print, 'Print', context, () async {
                      final buildState =
                          Provider.of<BuildState>(context, listen: false);
                      final doc = pw.Document();
                      doc.addPage(
                        pw.Page(
                          build: (pw.Context context) {
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('Custom Build',
                                    style: pw.TextStyle(
                                        fontSize: 24,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 16),
                                pw.Text(
                                    'CPU: ${buildState.selectedCpu?.name ?? "N/A"}',
                                    style: pw.TextStyle(fontSize: 18)),
                                pw.Text(
                                    'Motherboard: ${buildState.selectedMotherboard?.name ?? "N/A"}',
                                    style: pw.TextStyle(fontSize: 18)),
                                pw.Text(
                                    'GPU: ${buildState.selectedGpu?.name ?? "N/A"}',
                                    style: pw.TextStyle(fontSize: 18)),
                                pw.Text(
                                    'Memory: ${buildState.selectedMemory?.name ?? "N/A"}',
                                    style: pw.TextStyle(fontSize: 18)),
                                pw.SizedBox(height: 16),
                                pw.Text(
                                    'Total Cost: \$${buildState.getTotalCost().toStringAsFixed(2)}',
                                    style: pw.TextStyle(fontSize: 18)),
                                pw.Text(
                                    'Total TDP: ${buildState.getTotalTdp()} W',
                                    style: pw.TextStyle(fontSize: 18)),
                              ],
                            );
                          },
                        ),
                      );

                      await Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async => doc.save());
                    }),
                    buildBottomButton(Icons.save, 'Save', context, () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController _controller =
                              TextEditingController();
                          return AlertDialog(
                            title: Text('Save Build'),
                            content: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Enter build name',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_controller.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Invalid Name')),
                                    );
                                  } else {
                                    final buildItem = BuildItem(
                                      name: _controller.text,
                                      selectedCpu: Provider.of<BuildState>(
                                              context,
                                              listen: false)
                                          .selectedCpu,
                                      selectedMotherboard:
                                          Provider.of<BuildState>(context,
                                                  listen: false)
                                              .selectedMotherboard,
                                      selectedGpu: Provider.of<BuildState>(
                                              context,
                                              listen: false)
                                          .selectedGpu,
                                      selectedMemory: Provider.of<BuildState>(
                                              context,
                                              listen: false)
                                          .selectedMemory,
                                      totalCost: Provider.of<BuildState>(
                                              context,
                                              listen: false)
                                          .getTotalCost(),
                                      totalTdp: Provider.of<BuildState>(context,
                                              listen: false)
                                          .getTotalTdp(),
                                    );
                                    Provider.of<BuildState>(context,
                                            listen: false)
                                        .addBuildItem(buildItem);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MyBuildPage()),
                                    );
                                  }
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectedComponent(
      BuildContext context, BuildComponent component, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Icon(Icons.memory, color: Colors.yellow, size: 40),
              SizedBox(height: 10),
              Text(
                '$type: ${component.name}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomButton(IconData icon, String text, BuildContext context,
      VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Icon(icon, color: Colors.yellow, size: 40),
                SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomButton(IconData icon, String text,
      [BuildContext? context, VoidCallback? onPressed]) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// Select CPU Page
class SelectCPUPage extends StatelessWidget {
  final int? editIndex;

  SelectCPUPage({this.editIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark gray background color
      appBar: AppBar(
        title: Text('Choose Processor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.white54),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.sort, color: Colors.white),
                    onPressed: () {
                      // Handle sort action
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // Handle filter action
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              buildCpuCard(
                context,
                'AMD Ryzen 7 7800X3D 4.2 GHz 8-Core Processor',
                350,
                120,
                'assets/amd.png', // Ensure you have the correct path to the image
                'Core count: 8\nCore Clock: 4.2 GHz\nBoost Clock: 5 GHz\nSocket: AM5\nTDP: 120 W\nIntegrated Graphics: Radeon',
              ),
              buildCpuCard(
                context,
                'Intel Core i9-14900K',
                530,
                125,
                'assets/intel.png', // Ensure you have the correct path to the image
                'Core count: 24\nCore Clock: 3.2 GHz\nBoost Clock: 6 GHz\nSocket: LGA1700\nTDP: 125 W\nIntegrated Graphics: Intel UHD',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCpuCard(BuildContext context, String title, double price, int tdp,
      String imagePath, String specs) {
    final component = BuildComponent(name: title, cost: price, tdp: tdp);
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        specs,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<BuildState>(context, listen: false)
                            .selectCpu(component);
                        if (editIndex != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBuildPage(
                                buildItem: Provider.of<BuildState>(context,
                                        listen: false)
                                    .buildItems[editIndex!],
                                buildIndex: editIndex!,
                              ),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'ADD',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Featured Build Page
class FeaturedBuildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Featured Build'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Featured Build',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  children: [
                    buildFeaturedBuildItem(context, 'Build 1', 'User1',
                        'assets/build3.png', 'Tap for more details.', {
                      'CPU': 'AMD Ryzen 7 5800X',
                      'GPU': 'NVIDIA GeForce RTX 3080',
                      'RAM': '32GB Corsair Vengeance',
                      'Storage': '1TB NVMe SSD',
                      'Motherboard': 'ASUS ROG Strix B550-F',
                    }),
                    SizedBox(height: 10),
                    buildFeaturedBuildItem(context, 'Build 2', 'User2',
                        'assets/build4.png', 'Tap for more details.', {
                      'CPU': 'Intel Core i9-10900K',
                      'GPU': 'NVIDIA GeForce RTX 3090',
                      'RAM': '64GB G.Skill Trident Z',
                      'Storage': '2TB NVMe SSD',
                      'Motherboard': 'MSI MEG Z490 Godlike',
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '©2024\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.grey[850],
      ),
    );
  }

  Widget buildFeaturedBuildItem(BuildContext context, String title, String user,
      String imagePath, String summary, Map<String, String> details) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PCBuildDetailPage(
                  title: title,
                  user: user,
                  imagePath: imagePath,
                  details: details)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.pinkAccent),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center content horizontally
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'by $user',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Image.asset(imagePath, height: 150, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(
              summary,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PCBuildDetailPage extends StatefulWidget {
  final String title;
  final String user;
  final String imagePath;
  final Map<String, String> details;

  PCBuildDetailPage(
      {required this.title,
      required this.user,
      required this.imagePath,
      required this.details});

  @override
  _PCBuildDetailPageState createState() => _PCBuildDetailPageState();
}

class _PCBuildDetailPageState extends State<PCBuildDetailPage> {
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();
  final List<String> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Build Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'by ${widget.user}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(widget.imagePath, height: 200, fit: BoxFit.cover),
              SizedBox(height: 20),
              for (var entry in widget.details.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center content horizontally
                    children: [
                      Text(
                        '${entry.key}: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        entry.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add a comment',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if (_commentController.text.isNotEmpty) {
                          comments.add(_commentController.text);
                          _commentController.clear();
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              for (var comment in comments)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Center content horizontally
                    children: [
                      Icon(Icons.comment, color: Colors.white70),
                      SizedBox(width: 10),
                      Text(
                        comment,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tech News Page
class TechNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[900], // Dark gray background color matching bottom screen
      appBar: AppBar(
        title: Text('Tech News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tech news',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
//               GestureDetector(
//                 onTap: () {
//                   // Handle "View all" tap
//                 },
//                 child: Text(
//                   'View all',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//               ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildTechNewsItem(
                    context,
                    'NVIDIA founder and CEO Jensen Huang will deliver t...',
                    'assets/nvidia_news.png',
                    'Detailed information about NVIDIA news.',
                  ),
                  buildTechNewsItem(
                    context,
                    'The AMD Computex Press Conference Revealed!',
                    'assets/amd_news.png',
                    'Detailed information about AMD news.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '©2024\nAll rights reserved',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildTechNewsItem(BuildContext context, String title, String imagePath,
      String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TechNewsDetailPage(
                  title: title,
                  imagePath: imagePath,
                  description: description)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TechNewsDetailPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final String description;

  TechNewsDetailPage(
      {required this.title,
      required this.imagePath,
      required this.description});

  @override
  _TechNewsDetailPageState createState() => _TechNewsDetailPageState();
}

class _TechNewsDetailPageState extends State<TechNewsDetailPage> {
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();
  final List<String> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to the left
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Image.asset(widget.imagePath,
                    height: 200, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.left, // Align text to the left
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align content to the left
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add a comment',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if (_commentController.text.isNotEmpty) {
                          comments.add(_commentController.text);
                          _commentController.clear();
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              for (var comment in comments)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align content to the left
                    children: [
                      Icon(Icons.comment, color: Colors.white70),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          comment,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
