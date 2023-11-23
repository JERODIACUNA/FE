import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue.withOpacity(0.9),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.withOpacity(0.2), // Set the background color
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Forever Endeavor - the ultimate destination for your fitness journey! We believe that fitness is not just a goal but a lifelong endeavor, and we\'re here to support you every step of the way.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
                // Adjust text color
              ),
              SizedBox(height: 16),
              Text(
                'At Forever Endeavor, we\'re passionate about empowering individuals to achieve their fitness goals, no matter their starting point. Whether you\'re a seasoned athlete or just beginning your fitness journey, our app is designed to cater to your needs and aspirations.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ), // Adjust text color
              ),
              SizedBox(height: 16),
              Text(
                'What sets Forever Endeavor apart is our commitment to creating a holistic fitness experience. We offer a comprehensive range of features including personalized workout plans, nutrition guidance, progress tracking, and a supportive community that motivates and inspires.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ), // Adjust text color
              ),
              SizedBox(height: 16),
              Text(
                'Our team comprises fitness experts, trainers, and tech enthusiasts who have come together to craft an app that\'s intuitive, effective, and adaptable to your lifestyle. We understand that each person\'s fitness journey is unique, which is why we emphasize customization and flexibility in our approach.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ), // Adjust text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
