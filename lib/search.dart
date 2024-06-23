import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Report'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter City Name',
                hintStyle: TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onChanged: (value) {
                cityName = value;
              },
            ),
          ),
          TextButton(
              onPressed: () => Navigator.pop(context, cityName),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffeb1555))),
              child: const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
