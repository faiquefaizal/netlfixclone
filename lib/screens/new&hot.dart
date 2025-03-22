import 'package:flutter/material.dart';
import 'package:netflixclone/widgets.dart';

class Newandhot extends StatefulWidget {
  const Newandhot({super.key});

  @override
  State<Newandhot> createState() => _NewandhotState();
}

class _NewandhotState extends State<Newandhot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    "New & Hot",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.cast,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.blueAccent,
                          height: 28,
                          width: 28,
                        )),
                    SizedBox(
                      width: 20,
                    )
                  ],
                  bottom: TabBar(
                      dividerColor: Colors.black,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: "🍿 Coming Soon",
                        ),
                        Tab(
                          text: "🔥Everyone's Watching",
                        )
                      ]),
                ),
                body: TabBarView(children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ComingSoonMovieWidget(
                          imageUrl:
                              'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                          overview:
                              'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                          logoUrl:
                              "https://4kwallpapers.com/images/walls/thumbs_3t/18818.jpg",
                          month: "Jun",
                          day: "19",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ComingSoonMovieWidget(
                          imageUrl:
                              'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                          overview:
                              'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                          logoUrl:
                              "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                          month: "Mar",
                          day: "07",
                        ),
                      ],
                    ),
                  ),
                  ComingSoonMovieWidget(
                    imageUrl:
                        'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                    overview:
                        'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                    logoUrl:
                        "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                    month: "Mar",
                    day: "07",
                  ),
                ]),
              ),
            )));
  }
}
