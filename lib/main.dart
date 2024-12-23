import 'dart:async';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Profile()),
        ChangeNotifierProvider(create: (_) => MeditationProvider()),
      ],
      child: const MeditationApp(),
    ),
  );
}


class MeditationApp extends StatelessWidget {
  const MeditationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Meditation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FirstPage()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/orange.jpg', height: 100),
            const SizedBox(width: 20),
            const Text(
              'HeadSpace',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  final List<String> _changingWords = ['Calm', 'Relax', 'Focus', 'Breathe'];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _changingWords.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image section
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/skippy.gif',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),


                const Text(
                  'Head Space',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),


                Text(
                  _changingWords[_currentIndex],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Discover the power of mindfulness and meditation.\n'
                      'This app helps you relieve stress, focus, and find balance in life.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AnimationPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final String validEmail = 'Alikhan@gmail.com';
  final String validPassword = 'qwe123';

  void _signup() {
    if (_formkey.currentState!.validate()) {
      if (email.text == validEmail && password.text == validPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have signed up successfully')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect email or password')),
        );
      }
    }
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe In'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/skippy.gif',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Log In',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                _buildTextField(
                  label: 'Email',
                  icon: Icons.email_outlined,
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Email must contain "@"';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Password',
                  icon: Icons.lock_outline,
                  controller: password,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),


                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> genders = ['Male', 'Female', 'Another'];
  String selectedGender = 'Male';
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController number = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  Image.asset(
                    'assets/skippy.gif',
                    height: 150,
                  ),

                  const SizedBox(height: 20),


                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  const Text(
                    'Please register to login.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: number,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_outlined),
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                        return 'Mobile number must be exactly 11 digits';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    items: genders.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.wc),
                      labelText: 'Gender',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: const Icon(Icons.visibility_off),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Reminder me next time'),
                      Spacer(),
                      Switch(value: false, onChanged: null),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimationPage()));
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigator with Cards',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: BottomNavWithCards(),
    );
  }
}

class BottomNavWithCards extends StatefulWidget {
  @override
  _BottomNavWithCardsState createState() => _BottomNavWithCardsState();
}

class _BottomNavWithCardsState extends State<BottomNavWithCards> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TodayPage(),
    SearchResultsPage(initialSearchQuery: '',),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
class MeditationProvider extends ChangeNotifier {
  Map<String, bool> _completedSessions = {};

  bool isCompleted(String title) {
    return _completedSessions[title] ?? false;
  }

  void markCompleted(String title) {
    _completedSessions[title] = true;
    notifyListeners();
  }
}

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MeditationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Start your day",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTimelineCard(
              context: context,
              title: "General Anxiety",
              type: "Podcast",
              time: "5 min",
              image: Colors.orange,
              completed: provider.isCompleted("General Anxiety"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationTimerPage(
                      title: "General Anxiety",
                      time: 5,
                    ),
                  ),
                ).then((_) => provider.markCompleted("General Anxiety"));
              },
            ),
            _buildTimelineCard(
              context: context,
              title: "Follow the Breath",
              type: "Mindful Activity",
              time: "2 min",
              image: Colors.green,
              completed: provider.isCompleted("Follow the Breath"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationTimerPage(
                      title: "Follow the Breath",
                      time: 2,
                    ),
                  ),
                ).then((_) => provider.markCompleted("Follow the Breath"));
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "At Night",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTimelineCard(
              context: context,
              title: "Stress and Sleep",
              type: "Meditation",
              time: "16 min",
              image: Colors.purple,
              completed: provider.isCompleted("Stress and Sleep"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationTimerPage(
                      title: "Stress and Sleep",
                      time: 16,
                    ),
                  ),
                ).then((_) => provider.markCompleted("Stress and Sleep"));
              },
            ),
            _buildTimelineCard(
              context: context,
              title: "Lavender Fields",
              type: "Sleepcast",
              time: "45 min",
              image: Colors.deepPurple,
              completed: provider.isCompleted("Lavender Fields"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationTimerPage(
                      title: "Lavender Fields",
                      time: 45,
                    ),
                  ),
                ).then((_) => provider.markCompleted("Lavender Fields"));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard({
    required BuildContext context,
    required String title,
    required String type,
    required String time,
    required Color image,
    required bool completed,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: completed ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: completed ? Colors.green : Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  height: 50,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: image,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "$type • $time",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MeditationTimerPage extends StatefulWidget {
  final String title;
  final int time;

  MeditationTimerPage({required this.title, required this.time});

  @override
  _MeditationTimerPageState createState() => _MeditationTimerPageState();
}

class _MeditationTimerPageState extends State<MeditationTimerPage> {
  late int remainingMinutes;
  late int totalMinutes;
  double progress = 1.0;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    remainingMinutes = widget.time;
    totalMinutes = widget.time;
  }

  void _startTimer() {
    setState(() {
      isRunning = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (isRunning && remainingMinutes > 0) {
        setState(() {
          remainingMinutes--;
          progress = remainingMinutes / totalMinutes;
        });
        _startTimer();
      } else {
        setState(() {
          isRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.deepPurple),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remaining",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      "$remainingMinutes min",
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Turn off",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Switch(
                  value: isRunning,
                  onChanged: (value) {
                    if (value) {
                      _startTimer();
                    } else {
                      _stopTimer();
                    }
                  },
                  activeColor: Colors.deepPurple,
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              "Focus on your breathing.\nRelax and let go of distractions.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SearchResultsPage extends StatefulWidget {
  final String initialSearchQuery;

  SearchResultsPage({required this.initialSearchQuery});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  // A list of sessions for the app, acting as mock data for now.
  final List<Map<String, String>> _sessions = [
    {"title": "Rain Radio", "description": "Sleep aid - 500 mins"},
    {"title": "Night Sound", "description": "Sleep aid - 60 mins"},
    {"title": "Ocean Time", "description": "Sleep aid - 45 mins"},
    {"title": "Desert Campfire", "description": "Relaxation - 30 mins"},
    {"title": "Compass Gardens", "description": "Meditation - 20 mins"},
    {"title": "Downriver", "description": "Sleep sound - 45 mins"},
  ];

  List<Map<String, String>> _filteredSessions = [];

  String _searchQuery = "";

  @override
  void initState() {
    super.initState();

    _searchQuery = widget.initialSearchQuery;
    _filterSessions(_searchQuery);
  }

  void _filterSessions(String query) {
    setState(() {

      _filteredSessions = _sessions.where((session) {
        final title = session['title']!.toLowerCase();
        final description = session['description']!.toLowerCase();
        return title.contains(query.toLowerCase()) ||
            description.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          // Update the search results whenever the text changes.
          onChanged: _filterSessions,
          controller: TextEditingController(text: _searchQuery),
          decoration: const InputDecoration(
            hintText: "Search", // Placeholder text in the search bar.
            border: InputBorder.none,
            icon: Icon(Icons.search), // Search icon on the left.
          ),
        ),
        backgroundColor: Colors.deepPurple, // Set a consistent color for the AppBar.
      ),
      body: _filteredSessions.isEmpty
          ? const Center(
        child: Text(
          "No results found.", // Display when there are no matches.
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _filteredSessions.length,
        itemBuilder: (context, index) {
          final session = _filteredSessions[index];
          return _buildSessionCard(
            title: session['title']!,
            description: session['description']!,
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayerPage(
                    title: session['title']!,
                    description: session['description']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSessionCard({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.music_note, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

class MusicPlayerPage extends StatefulWidget {
  final String title;
  final String description;

  MusicPlayerPage({required this.title, required this.description});

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  double _currentPosition = 0.0;
  bool _isPlaying = false;
  late Timer _timer;
  late int _remainingTimeInSeconds;
  int _totalTimeInSeconds = 3600;

  @override
  void initState() {
    super.initState();

    _setTotalTime(widget.description);
    _remainingTimeInSeconds = _totalTimeInSeconds;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _setTotalTime(String description) {

    RegExp regex = RegExp(r'(\d+)\s*min');
    Match? match = regex.firstMatch(description);
    if (match != null) {
      _totalTimeInSeconds = int.parse(match.group(1)!) * 60;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTimeInSeconds > 0 && _isPlaying) {
        setState(() {
          _remainingTimeInSeconds--;
          _currentPosition =
              (_totalTimeInSeconds - _remainingTimeInSeconds) / _totalTimeInSeconds;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _playPauseMusic() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    if (_isPlaying) {
      _startTimer();
    } else {
      _timer.cancel();
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Now Playing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            // Circular Icon
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.deepPurple.withOpacity(0.1),
              child: const Icon(
                Icons.music_note,
                size: 80,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),

            Slider(
              value: _currentPosition,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {

              },
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTime(_remainingTimeInSeconds),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  _formatTime(_totalTimeInSeconds),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, size: 40),
                  onPressed: () {

                  },
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    size: 60,
                    color: Colors.deepPurple,
                  ),
                  onPressed: _playPauseMusic,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, size: 40),
                  onPressed: () {

                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              "Stay focused and keep going.\nGreat things take time!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Profile with ChangeNotifier {
  String name = 'Alikhan';
  String email = 'example@example.com';
  String mobile = '1234567890';
  String dob = '01/01/2000';
  String gender = 'Female';

  void updateProfile({
    required String name,
    required String email,
    required String mobile,
    required String dob,
    required String gender,
  }) {
    this.name = name;
    this.email = email;
    this.mobile = mobile;
    this.dob = dob;
    this.gender = gender;
    notifyListeners();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String? selectedGender = 'Male';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<Profile>(context, listen: false);

    nameController.text = profile.name;
    emailController.text = profile.email;
    mobileController.text = profile.mobile;
    dobController.text = profile.dob;
    selectedGender = profile.gender;
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Consumer<Profile>(
                      builder: (context, profile, _) {
                        return Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              _buildInputField(
                label: 'User Name',
                icon: Icons.person,
                hint: 'Enter User Name',
                controller: nameController,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Email Id',
                icon: Icons.email,
                hint: 'Enter Email',
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  } else if (!value.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Mobile Number',
                icon: Icons.phone,
                hint: 'Enter your 10 digit mobile number',
                controller: mobileController,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Date of Birth',
                icon: Icons.calendar_today,
                hint: 'DD / MM / YYYY',
                controller: dobController,
              ),
              const SizedBox(height: 20),
              _buildGenderDropdown(),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      profile.updateProfile(
                        name: nameController.text,
                        email: emailController.text,
                        mobile: mobileController.text,
                        dob: dobController.text,
                        gender: selectedGender!,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile updated successfully!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.purple),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedGender,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a gender';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class TodayPageWithVideo extends StatefulWidget {
  @override
  _TodayPageWithVideoState createState() => _TodayPageWithVideoState();
}

class _TodayPageWithVideoState extends State<TodayPageWithVideo> {
  final List<String> _completedActivities = [];

  void _markAsCompleted(String activity) {
    setState(() {
      if (!_completedActivities.contains(activity)) {
        _completedActivities.add(activity);
      }
    });
  }

  Widget _buildActivityCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _markAsCompleted(title),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedActivities() {
    if (_completedActivities.isEmpty) {
      return const Center(
        child: Text(
          "No activities completed yet.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return Column(
      children: _completedActivities
          .map(
            (activity) => Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "$activity completed!",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What would you like to do today?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildActivityCard(
                    title: "Mind",
                    description: "Train your mind",
                    icon: Icons.spa,
                    color: Colors.purple.shade300,
                  ),
                  _buildActivityCard(
                    title: "Sleep",
                    description: "Improve your sleep",
                    icon: Icons.nightlight_round,
                    color: Colors.blue.shade300,
                  ),
                  _buildActivityCard(
                    title: "Relax",
                    description: "Relax your body",
                    icon: Icons.self_improvement,
                    color: Colors.orange.shade300,
                  ),
                  _buildActivityCard(
                    title: "Focus",
                    description: "Stay focused",
                    icon: Icons.work_outline,
                    color: Colors.green.shade300,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Music/Podcast",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Listen to relaxing music or podcasts.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Completed Activities",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildCompletedActivities(),
            ],

          ),
        ),
      ),
    );
  }
}
