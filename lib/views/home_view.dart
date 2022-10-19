import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:technology_feed/controllres/subreddit_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isValid = true;
  final redditColor = const Color(0xFFff4b1a);
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      setState(() {});
    });
    final subredditController = Provider.of<SubredditController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Tela inicial',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Consumer<SubredditController>(
        builder: (context, controller, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: focusNode,
                  controller: subredditController.controllerSearchSubreddit,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: redditColor),
                    ),
                    labelStyle: TextStyle(
                        color: focusNode.hasFocus ? redditColor : Colors.black),
                    border: const OutlineInputBorder(),
                    labelText: 'Subreddit',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, 'scan_scanner'),
                      icon: Icon(
                        Icons.qr_code,
                        color: redditColor,
                      ),
                    ),
                  ),
                  onChanged: (value) => subredditController.searchIsValid(),
                ),
              ),
              subredditController.isLoading
                  ? SizedBox(
                      child: CircularProgressIndicator(
                        color: redditColor,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: controller.isValid
                          ? () {
                              subredditController
                                  .searchSubreddit()
                                  .then((value) {
                                if (value == 'success') {
                                  Navigator.pushNamed(context, 'feed');
                                }
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: redditColor),
                      child: const Text('PROSSEGUIR'),
                    ),
            ],
          );
        },
      ),
    );
  }
}
