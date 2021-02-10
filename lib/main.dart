
//Part1 1st stateless pgm
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Welcome to Flutter'),
//         ),
//         body: const Center(
//           child: const Text('Hello World'),
//         ),
//       ),
//     );
//   }
// }

//stateful pgm

// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final wordPair = WordPair.random(); // Add this line.
//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Welcome to Flutter'),
//         ),
//         body: Center(
//           //child: Text('Hello World'),   // Replace this text...
//           child: Text(wordPair.asPascalCase),  // With this text.
//         ),
//       ),
//     );
//   }
// }

// Part 1 Start
// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Startup Name Generator',
//       home: RandomWords(),
//     );
//   }
// }
//  class RandomWords extends StatefulWidget {
//    @override
//    _RandomWordsState createState() => _RandomWordsState();
//  }
//
//  class _RandomWordsState extends State<RandomWords> {
//    final  List<WordPair> _suggestions = <WordPair>[];
//    final TextStyle  _biggerFont = const TextStyle(fontSize: 18);
//
//
//    Widget _buildSuggestions() {
//      return ListView.builder(
//          padding: const EdgeInsets.all(16),
//           itemBuilder: (BuildContext _context, int i) {
//             if (i.isOdd) {
//              return Divider();
//            }
//             final int index = i ~/ 2;
//             if (index >= _suggestions.length) {
//               _suggestions.addAll(generateWordPairs().take(10));
//            }
//            return _buildRow(_suggestions[index]);
//          }
//      );
//    }
//
//    Widget _buildRow(WordPair pair) {
//      return ListTile(
//        title: Text(
//          pair.asPascalCase,
//          style: _biggerFont,
//        ),
//      );
//    }
//
//    @override
//    Widget build(BuildContext context) {
//      return Scaffold (                     // Add from here...
//        appBar: AppBar(
//          title: Text('Startup Name Generator'),
//        ),
//        body: _buildSuggestions(),
//      );
//    }
//  }
// Part 1 end here

// Part 2 Start
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}
 class RandomWords extends StatefulWidget {
   @override
   _RandomWordsState createState() => _RandomWordsState();
 }

 class _RandomWordsState extends State<RandomWords> {
   final  List<WordPair> _suggestions = <WordPair>[];
   final _saved = Set<WordPair>();
   final TextStyle  _biggerFont = const TextStyle(fontSize: 18);



   Widget _buildSuggestions() {
     return ListView.builder(
         padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext _context, int i) {
            if (i.isOdd) {
             return Divider();
           }
            final int index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
           }
           return _buildRow(_suggestions[index]);
         }
     );
   }

   Widget _buildRow(WordPair pair) {
     final alreadySaved = _saved.contains(pair);
     return ListTile(
       title: Text(
         pair.asPascalCase,
         style: _biggerFont,
       ),
       trailing: Icon(
         alreadySaved ? Icons.favorite : Icons.favorite_border,
         color: alreadySaved ? Colors.red : null,
       ),
       onTap: () {      // NEW lines from here...
         setState(() {
           if (alreadySaved) {
             _saved.remove(pair);
           } else {
             _saved.add(pair);
           }
         });
       },               // ... to here.
     );
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold (                     // Add from here...
       appBar: AppBar(
         title: Text('Startup Name Generator'),
         actions: [
           IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
         ],
       ),
       body: _buildSuggestions(),
     );
   }
   void _pushSaved() {
     Navigator.of(context).push(
       // Add lines from here...
       MaterialPageRoute<void>(
         builder: (BuildContext context) {
           final tiles = _saved.map(
                 (WordPair pair) {
               return ListTile(
                 title: Text(
                   pair.asPascalCase,
                   style: _biggerFont,
                 ),
               );
             },
           );
           final divided = ListTile.divideTiles(
             context: context,
             tiles: tiles,
           ).toList();

           return Scaffold(
             appBar: AppBar(
               title: Text('Saved Suggestions'),
             ),
             body: ListView(children: divided),
           );
         },
       ),
     );
   }
 }

 //// Part 2 end here