import 'package:flutter/material.dart';

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quotes> quotes = [
    Quotes(author: "John", text: "Be yourself everyone else is already taken"),
    Quotes(
      author: "Mathar",
      text: "I have nothing to declare except my genius",
    ),
    Quotes(author: "Kevin", text: "The truth is rarely pure and never simple"),
  ];

  void handleDelete(quote) {
    setState(() {
      quotes.remove(quote);
      print("handle delete");
    });
  }

  void handleAdd(String text, String author) {
    setState(() {
      quotes.add(Quotes(text: text, author: author));
      print("add quote");
    });
  }

  void handleEdit(int index, String text, String author) {
    setState(() {
      quotes[index].text = text;
      quotes[index].author = author;
    });
  }

  void showAddQuoteDialog() {
    String newText = '';
    String newAuthor = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a new Quote"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Text"),
                onChanged: (value) {
                  newText = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Author"),
                onChanged: (value) {
                  newAuthor = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (newText.isNotEmpty && newAuthor.isNotEmpty) {
                  handleAdd(newText, newAuthor);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void showEditQuoteDialog(int index) {
    String updatedText = quotes[index].text;
    String updatedAuthor = quotes[index].author;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Quote"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Text"),
                controller: TextEditingController(text: updatedText),
                onChanged: (value) {
                  updatedText = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Author"),
                controller: TextEditingController(text: updatedAuthor),
                onChanged: (value) {
                  updatedAuthor = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (updatedText.isNotEmpty && updatedAuthor.isNotEmpty) {
                  handleEdit(index, updatedText, updatedAuthor);
                  Navigator.of(context).pop(); // Close dialog
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Quote List"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return CartList(
            quote: quotes[index],
            delete: () => handleDelete(quotes[index]),
            edit: () => showEditQuoteDialog(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        onPressed: showAddQuoteDialog,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Quotes {
  String text;
  String author;
  Quotes({required this.text, required this.author});
}

class CartList extends StatelessWidget {
  const CartList({
    super.key,
    required this.quote,
    required this.delete,
    required this.edit,
  });

  final Quotes quote;
  final Function() delete;
  final Function() edit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("'${quote.text}'"),
            SizedBox(height: 20),
            Text(
              "- ${quote.author} -",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[800],
                  ),
                  onPressed: edit,
                  child: Text("edit", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                  ),
                  onPressed: delete,
                  child: Text("delete", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
