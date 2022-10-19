import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:technology_feed/controllres/subreddit_controller.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final redditColor = const Color(0xFFff4b1a);

  @override
  Widget build(BuildContext context) {
    final subredditController = Provider.of<SubredditController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Feed Princial',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          subredditController.searchSubreddit();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              subredditController.isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: redditColor,
                        ),
                      ),
                    )
                  : Container(),
              Consumer<SubredditController>(
                builder: (context, controller, _) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.data!.data!.children!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          subredditController.urlDetails = controller
                              .data!.data!.children![index].data!.permalink!;
                          subredditController.getDetails();
                          Navigator.pushNamed(
                            context,
                            'details',
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 8.0, left: 16.0, bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'u/${controller.data!.data!.children![index].data!.author!}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(controller.data!.data!
                                          .children![index].data!.title!),
                                    ),
                                    controller.data!.data!.children![index]
                                                    .data!.thumbnail! !=
                                                'self' &&
                                            controller
                                                    .data!
                                                    .data!
                                                    .children![index]
                                                    .data!
                                                    .thumbnail! !=
                                                'default'
                                        ? Container(
                                            height: 50,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .data!
                                                    .data!
                                                    .children![index]
                                                    .data!
                                                    .thumbnail!),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${controller.data!.data!.children![index].data!.score} Upvotes',
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                        '${controller.data!.data!.children![index].data!.numComments} Comentários')
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
