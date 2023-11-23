import 'package:fitnessapp/login.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/player.dart'; // Replace with the correct import path
import 'activity.dart';
import 'notification.dart';

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
                        title: Text('This Week\'s Activity'),
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

class CategoriesRow extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoriesRow({required this.onCategorySelected});

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
                  title: 'Aerobic Exercise', onSelected: onCategorySelected),
              CategoryItem(
                  title: 'Strength Training', onSelected: onCategorySelected),
              CategoryItem(title: 'Stretching', onSelected: onCategorySelected),
              CategoryItem(
                  title: 'Balance Exercise', onSelected: onCategorySelected),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final Function(String) onSelected;

  const CategoryItem({required this.title, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ActionChip(
        label: Text(title),
        backgroundColor: Colors.lightBlue.withOpacity(0.25),
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
  // Default user information
  final String defaultUsername = 'Adol Filter';
  final String defaultEmail = 'adol@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView(
        children: [
          // UserAccountsDrawerHeader with default user info
          UserAccountsDrawerHeader(
            accountName: Text(defaultUsername),
            accountEmail: Text(defaultEmail),
            currentAccountPicture: const CircleAvatar(
              // You can add a default user picture here
              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle,
                size: 50,
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              // Implement navigation to the about us page
            },
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text('Plans'),
            onTap: () {
              // Implement navigation to the plans page
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble),
            title: const Text('Suggestions'),
            onTap: () {
              // Implement navigation to the suggestions page
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support'),
            onTap: () {
              // Implement navigation to the support page
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
            },
          ),
        ],
      ),
    );
  }
}
