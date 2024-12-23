import 'package:flutter/material.dart';


class FocusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Focus Practice"),
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Animation Section
          Expanded(
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.self_improvement,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Music Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Relaxing Focus Music",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Slider(
                  value: 0.3,
                  onChanged: (value) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("0:30"),
                    Text("3:45"),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Play or pause music
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Play Music"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
