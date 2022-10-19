import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:technology_feed/controllres/subreddit_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final redditColor = const Color(0xFFff4b1a);
  // @override
  // void initState() {

  //   super.initState();
  // }

  Future launchURL(Uri url) async {
    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Tela de Comentários',
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
      body: SingleChildScrollView(
        child: Consumer<SubredditController>(
          builder: (context, controller, _) => controller.isLoading
              ? Column(children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: redditColor,
                    ),
                  ),
                ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'u/${controller.details!.author}',
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                controller.details!.title!,
                                style: GoogleFonts.roboto(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(controller.details!.selftext!),
                            ),
                            controller.details!.thumbnail!.contains('http')
                                ? Container(
                                    height: 180,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            controller.details!.thumbnail!),
                                      ),
                                    ),
                                  )
                                : Container(),
                            TextButton(
                              onPressed: () => {
                                launchURL(Uri.parse(controller.details!.url!))
                              },
                              child: Text(
                                controller.details!.url!,
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.blue),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${controller.details!.ups} Upvotes',
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Comentários',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.comment,
                            color: redditColor,
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.details!.comments!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 8.0, left: 16.0, bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'u/${controller.details!.comments![index].author!}'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(controller
                                          .details!.comments![index].body!),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${controller.details!.comments![index].ups} Upvotes',
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
