import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  String searchQuery = '';

  void _clearSearch() {
    setState(() {
      _controller.clear();
      searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search destinations',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: _clearSearch,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: _clearSearch,
                  child: Text('Cancel'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Recent Searches
            Text('Recent Searches', style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dunn\'s River Falls, Ocho Rios'),
                Text('Negril Seven Mile Beach, Negril'),
                Text('Bob Marley Museum, Kingston'),
              ],
            ),
            SizedBox(height: 30),

            // Popular Categories
            Text('Popular Categories', style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                CategoryChip(label: 'Food & Dining'),
                CategoryChip(label: 'Beach & Nature'),
                CategoryChip(label: 'Nightlife & Entertainment'),
                CategoryChip(label: 'Culture & Heritage'),
                CategoryChip(label: 'Adventures & Tours'),
                CategoryChip(label: 'Wellness & Relaxation'),
              ],
            ),
            SizedBox(height: 30),

            // Location Options
            Row(
              children: [
                Text('Use My Location'),
                Spacer(),
                Text('Kingston'),
                Spacer(),
                Text('Montego Bay'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.blueAccent,
      labelStyle: TextStyle(color: Colors.white),
    );
  }
}
