import 'package:fitnessapp/login.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/player.dart'; // Replace with the correct import path
import 'activity.dart';
import 'notification.dart';
import 'about_us.dart';
import 'settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = ''; // Track the selected category

  List<Map<String, String>> workoutClasses = [
    {
      'title': 'Aerobic Exercise 1',
      'time': '8:00 min',
      'category': 'Aerobic Exercise'
    },
    {
      'title': 'Aerobic Exercise 2',
      'time': '10:00 min',
      'category': 'Aerobic Exercise'
    },
    {
      'title': 'Aerobic Exercise 3',
      'time': '5:00 min',
      'category': 'Aerobic Exercise'
    },
    {
      'title': 'Aerobic Exercise 4',
      'time': '2:00 min',
      'category': 'Aerobic Exercise'
    },
    {
      'title': 'Aerobic Exercise 5',
      'time': '2:00 min',
      'category': 'Aerobic Exercise'
    },
    {
      'title': 'Aerobic Exercise 6',
      'time': '10:00 min',
      'category': 'Aerobic Exercise'
    },
    {
      'title': 'Strength Training 1',
      'time': '9:30 min',
      'category': 'Strength Training'
    },
    {
      'title': 'Strength Training 2',
      'time': '3:30 min',
      'category': 'Strength Training'
    },
    {
      'title': 'Strength Training 3',
      'time': '10:00 min',
      'category': 'Strength Training'
    },
    {
      'title': 'Strength Training 4',
      'time': '5:30 min',
      'category': 'Strength Training'
    },
    {
      'title': 'Strength Training 5',
      'time': '3:30 min',
      'category': 'Strength Training'
    },
    {
      'title': 'Strength Training 6',
      'time': '2:00 min',
      'category': 'Strength Training'
    },
    {'title': 'Stretching 1', 'time': '11:00 min', 'category': 'Stretching'},
    {'title': 'Stretching 2', 'time': '5:00 min', 'category': 'Stretching'},
    {'title': 'Stretching 3', 'time': '6:00 min', 'category': 'Stretching'},
    {'title': 'Stretching 4', 'time': '8:00 min', 'category': 'Stretching'},
    {'title': 'Stretching 5', 'time': '10:00 min', 'category': 'Stretching'},
    {'title': 'Stretching 6', 'time': '5:00 min', 'category': 'Stretching'},
    {
      'title': 'Balance Exercise 1',
      'time': '10:30 min',
      'category': 'Balance Exercise'
    },
    {
      'title': 'Balance Exercise 2',
      'time': '6:30 min',
      'category': 'Balance Exercise'
    },
    {
      'title': 'Balance Exercise 3',
      'time': '5:30 min',
      'category': 'Balance Exercise'
    },
    {
      'title': 'Balance Exercise 4',
      'time': '6:30 min',
      'category': 'Balance Exercise'
    },
    {
      'title': 'Balance Exercise 5',
      'time': '8:00 min',
      'category': 'Balance Exercise'
    },
    {
      'title': 'Balance Exercise 6',
      'time': '10:30 min',
      'category': 'Balance Exercise'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredClasses = selectedCategory.isNotEmpty
        ? workoutClasses
            .where((cls) => cls['category'] == selectedCategory)
            .toList()
        : workoutClasses;

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.9),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _navigateToHamburgerMenuPage(context);
            },
          ),
          title: const Text('Welcome, Adol'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Implement navigation to the notifications page
                _navigateToNotifications(context);
              },
            ),
            IconButton(
              icon: const CircleAvatar(
                radius: 20, // Set the radius to the desired size
                backgroundImage:
                    AssetImage('lib/assets/logo.png'), // Provide the image path
              ),
              onPressed: () {
                // Implement navigation to the account page
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Find Your Workout Class',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Roboto',
                ),
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'e.g. Yoga, Running',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.lightBlue.withOpacity(0.25),
                      child: const ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text(
                          'This Week\'s Activity',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text('8.00 AM - 11.30 AM'),
                      ),
                    ),
                  ),
                ),
              ),
              RecommendationClass(), // New widget for recommendations
              const SizedBox(
                height: 16,
              ), // Add space between recommendation and categories
              CategoriesRow(onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category; // Update selected category
                });
              }), // New widget for categories
              Expanded(
                child: ListView.builder(
                  itemCount: filteredClasses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.fitness_center),
                      title: Text(filteredClasses[index]['title'] ?? ''),
                      subtitle: Text(filteredClasses[index]['time'] ?? ''),
                      onTap: () {
                        // When a workout class is clicked, navigate to the player.dart file
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerScreen(
                                workoutDetails: filteredClasses[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to navigate to the notifications page
  void _navigateToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NotificationScreen(), // Navigate to NotificationScreen
      ),
    );
  }
}

class RecommendationClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap on the recommendation class
        // You can implement navigation or other actions here
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: const Color.fromARGB(255, 15, 3, 244).withOpacity(0.30),
          ),
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommendation',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  // Icon(Icons.fitness_center),
                  SizedBox(width: 20),
                  Text('Aerobic Exercise'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesRow extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoriesRow({required this.onCategorySelected});

  @override
  _CategoriesRowState createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              CategoryItem(
                title: 'Aerobic Exercise',
                onSelected: onCategorySelected,
                isSelected: selectedCategory == 'Aerobic Exercise',
              ),
              CategoryItem(
                title: 'Strength Training',
                onSelected: onCategorySelected,
                isSelected: selectedCategory == 'Strength Training',
              ),
              CategoryItem(
                title: 'Stretching',
                onSelected: onCategorySelected,
                isSelected: selectedCategory == 'Stretching',
              ),
              CategoryItem(
                title: 'Balance Exercise',
                onSelected: onCategorySelected,
                isSelected: selectedCategory == 'Balance Exercise',
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    widget.onCategorySelected(category);
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final Function(String) onSelected;
  final bool isSelected;

  const CategoryItem({
    required this.title,
    required this.onSelected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ActionChip(
        label: Text(title),
        backgroundColor:
            isSelected ? Colors.blue : Colors.lightBlue.withOpacity(0.25),
        onPressed: () {
          onSelected(title); // Notify selected category
        },
      ),
    );
  }
}

void _navigateToHamburgerMenuPage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return HamburgerMenuPage();
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
              .animate(animation),
          child: child,
        );
      },
    ),
  );
}

class HamburgerMenuPage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false, // This removes all the routes from the stack
      );
    } catch (e) {
      print(e);
      // Handle sign-out failure
      // You can show an error message to the user here if needed
    }
  }

  // Default user information
  final String defaultUsername = 'Adol Filter';
  final String defaultEmail = 'adol@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.9),
        title: const Text(
          'Menu',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: [
          // Updated UserAccountsDrawerHeader with user picture
          UserAccountsDrawerHeader(
            accountName: Text(
              defaultUsername,
            ),
            accountEmail: Text(
              defaultEmail,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/bocchibg.gif'),
                fit: BoxFit.cover,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/bochii.gif'),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble),
            title: const Text(
              'Suggestions',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // Implement navigation to the suggestions page
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text(
              'Support',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              // Implement navigation to the support page
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'About Us',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AboutUsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Log Out',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
