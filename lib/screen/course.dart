import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Define a class for the items
class Course {
  final String courseType;
  final String shiftType;
  final String description;

  Course(
      {required this.courseType,
      required this.shiftType,
      required this.description});
}

class MyApp extends StatelessWidget {
  final List<Course> courses = [
    Course(
        courseType: 'Math',
        shiftType: 'Morning',
        description: 'Mathematics course in the morning.'),
    Course(
        courseType: 'Science',
        shiftType: 'Evening',
        description: 'Science course in the evening.'),
    Course(
        courseType: 'English',
        shiftType: 'Afternoon',
        description: 'English course in the afternoon.'),
    // Add more courses as needed
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Course List'),
        ),
        body: CourseList(courses: courses),
      ),
    );
  }
}

class CourseList extends StatefulWidget {
  final List<Course> courses;

  const CourseList({super.key, required this.courses});

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final TextEditingController _searchController = TextEditingController();
  List<Course> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    filteredCourses = widget.courses;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                filteredCourses = widget.courses.where((course) {
                  return course.courseType
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      course.shiftType
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      course.description
                          .toLowerCase()
                          .contains(value.toLowerCase());
                }).toList();
              });
            },
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Search for a course...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCourses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredCourses[index].courseType),
                subtitle: Text(
                    '${filteredCourses[index].shiftType} - ${filteredCourses[index].description}'),
                onTap: () {
                  // Handle onTap event if needed
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
