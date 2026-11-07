
import 'package:flutter/material.dart';

void main() {
  runApp(const NepVibApp());
}

class NepVibApp extends StatelessWidget {
  const NepVibApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NepVib',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.purpleAccent,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class VideoItem {
  final String username;
  final String caption;
  final String music;
  final Color color;

  const VideoItem({
    required this.username,
    required this.caption,
    required this.music,
    required this.color,
  });
}

const videos = [
  VideoItem(
    username: 'nepal_creator',
    caption: 'नेपाल सुन्दर छ 🇳🇵❤️',
    music: 'Original Sound',
    color: Colors.deepPurple,
  ),
  VideoItem(
    username: 'nepvib_user',
    caption: 'Welcome to NepVib 🔥',
    music: 'NepVib Music',
    color: Colors.blue,
  ),
  VideoItem(
    username: 'creator_nepal',
    caption: 'Watch • Create • Earn',
    music: 'Original Sound',
    color: Colors.pink,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentTab,
        children: const [
          FeedPage(),
          DiscoverPage(),
          UploadPage(),
          InboxPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) {
          setState(() => currentTab = index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final PageController controller = PageController();
  final Set<int> liked = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          scrollDirection: Axis.vertical,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            final isLiked = liked.contains(index);

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    video.color,
                    Colors.black,
                    Colors.pink.shade900,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.play_circle_fill,
                          size: 85,
                          color: Colors.white70,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'NepVib Video Feed',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Demo screen'),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 16,
                    bottom: 40,
                    right: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@${video.username}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(video.caption),
                        const SizedBox(height: 8),
                        Text('♫ ${video.music}'),
                      ],
                    ),
                  ),

                  Positioned(
                    right: 15,
                    bottom: 45,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(height: 24),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (isLiked) {
                                liked.remove(index);
                              } else {
                                liked.add(index);
                              }
                            });
                          },
                          icon: Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isLiked
                                ? Colors.red
                                : Colors.white,
                            size: 34,
                          ),
                        ),
                        const Text('Like'),
                        const SizedBox(height: 14),
                        const Icon(Icons.comment, size: 32),
                        const Text('Comment'),
                        const SizedBox(height: 14),
                        const Icon(Icons.share, size: 32),
                        const Text('Share'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        Positioned(
          top: 45,
          left: 15,
          child: Row(
            children: const [
              Text(
                'NepVib 🇳🇵',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 85,
          left: 12,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Sponsored • Ad space',
              style: TextStyle(fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }
}

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Discover 🔎\nFind NepVib Creators',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23),
      ),
    );
  }
}

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.video_call, size: 75, color: Colors.pink),
          SizedBox(height: 15),
          Text('Create Your Video'),
          Text('Video upload coming next'),
        ],
      ),
    );
  }
}

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('NepVib Inbox 💬'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            child: Icon(Icons.person, size: 50),
          ),
          SizedBox(height: 15),
          Text(
            '@nepvib_user',
            style: TextStyle(fontSize: 22),
          ),
          Text('Watch • Create • Earn'),
        ],
      ),
    );
  }
}
