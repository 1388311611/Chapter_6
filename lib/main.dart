import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapt_6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InfiniteScrollList(),
    );
  }
}

class InfiniteScrollList extends StatefulWidget {
  @override
  _InfiniteScrollListState createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState extends State<InfiniteScrollList> {
  List<String> _items = List.generate(20, (index) => 'Item $index');

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _items.addAll(List.generate(20, (index) => 'Item ${_items.length + index}'));
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scroll List'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _items.length) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListTile(
              title: Text(_items[index]),
            );
          }
        },
      ),
    );
  }
}
