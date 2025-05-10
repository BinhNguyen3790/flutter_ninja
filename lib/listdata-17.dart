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

  void showQuoteDialog({
    required String title,
    required String initialText,
    required String initialAuthor,
    required void Function(String text, String author) onConfirm,
  }) {
    String text = initialText;
    String author = initialAuthor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Text"),
                controller: TextEditingController(text: initialText),
                onChanged: (value) {
                  text = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Author"),
                controller: TextEditingController(text: initialAuthor),
                onChanged: (value) {
                  author = value;
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
                if (text.isNotEmpty && author.isNotEmpty) {
                  onConfirm(text, author);
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

  void showAddQuoteDialog() {
    showQuoteDialog(
      title: "Add a new Quote",
      initialText: '',
      initialAuthor: '',
      onConfirm: (text, author) => handleAdd(text, author),
    );
  }

  void showEditQuoteDialog(int index) {
    showQuoteDialog(
      title: "Edit Quote",
      initialText: quotes[index].text,
      initialAuthor: quotes[index].author,
      onConfirm: (text, author) => handleEdit(index, text, author),
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
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Divider(
              height: 40,
              color: Colors.grey[400],
            ),
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
