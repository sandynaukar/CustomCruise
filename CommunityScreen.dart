import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'Vijay Kumar',
      'timeAgo': '2 hours ago',
      'content': 'Just installed a new turbocharger on my 2019 Mustang GT. The power increase is insane! #FordPerformance #TurboCharged',
      'imageAsset': 'assets/images/custom_car_1.jpg',
      'likes': 45,
      'comments': [],
      'effect': 'none',
    },
    {
      'username': 'Ajith Kumar',
      'timeAgo': '3 hours ago',
      'content': 'Upgraded my Subaru WRX with a new cold air intake. The sound is music to my ears! #SubieNation #PerformanceMods',
      'imageAsset': 'assets/images/custom_car_2.jpg',
      'likes': 32,
      'comments': [],
      'effect': 'none',
    },
    {
      'username': 'Vishal Roshan',
      'timeAgo': '5 hours ago',
      'content': 'Just finished installing coilovers on my Honda Civic Si. The handling is now on another level! #HondaPerformance #Stance',
      'imageAsset': 'assets/images/custom_car_3.jpg',
      'likes': 28,
      'comments': [],
      'effect': 'sepia',
    },
    {
      'username': 'Tony Stalk',
      'timeAgo': '1 day ago',
      'content': 'Added a performance chip to my BMW M3. The throttle response is incredibly crisp now! #BMWPerformance #ChipTuning',
      'imageAsset': 'assets/images/custom_car_4.jpg',
      'likes': 56,
      'comments': [],
      'effect': 'none',
    },
    {
      'username': 'Steve Rogers',
      'timeAgo': '2 days ago',
      'content': 'Just dyno-tested my Chevy Camaro SS after installing a supercharger. 650hp at the wheels! #ChevyPerformance #Supercharged',
      'imageAsset': 'assets/images/custom_car_5.jpg',
      'likes': 72,
      'comments': [],
      'effect': 'grayscale',
    },
    {
      'username': 'Rishon Jos Anton',
      'timeAgo': '3 days ago',
      'content': 'Installed a widebody kit on my Nissan 350Z. The aggressive look is turning heads everywhere! #NissanNation #Widebody',
      'imageAsset': 'assets/images/custom_car_6.jpg',
      'likes': 41,
      'comments': [],
      'effect': 'none',
    },
  ];

  void _likePost(int index) {
    setState(() {
      posts[index]['likes']++;
    });
  }

  void _addComment(int index, String comment) {
    setState(() {
      posts[index]['comments'].add(comment);
    });
  }

  void _sharePost(Map<String, dynamic> post) {
    Share.share('Check out this awesome car mod: ${post['content']}');
  }

  Widget _buildImageWithEffect(String imageAsset, String effect) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(_getColorMatrix(effect)),
      child: imageAsset.startsWith('assets/')
          ? Image.asset(
        imageAsset,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      )
          : Image.file(
        File(imageAsset),
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  List<double> _getColorMatrix(String effect) {
    switch (effect) {
      case 'grayscale':
        return [
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ];
      case 'sepia':
        return [
          0.393, 0.769, 0.189, 0, 0,
          0.349, 0.686, 0.168, 0, 0,
          0.272, 0.534, 0.131, 0, 0,
          0, 0, 0, 1, 0,
        ];
      default:
        return [
          1, 0, 0, 0, 0,
          0, 1, 0, 0, 0,
          0, 0, 1, 0, 0,
          0, 0, 0, 1, 0,
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community', style: TextStyle(color: Colors.orange)),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar_${index + 1}.jpg'),
                  ),
                  title: Text(post['username'], style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  subtitle: Text(post['timeAgo'], style: const TextStyle(color: Colors.white70)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    post['content'],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                _buildImageWithEffect(post['imageAsset'], post['effect']),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.thumb_up, color: Colors.orange),
                      label: Text('${post['likes']} Likes', style: const TextStyle(color: Colors.orange)),
                      onPressed: () => _likePost(index),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.comment, color: Colors.orange),
                      label: Text('${post['comments'].length} Comments', style: const TextStyle(color: Colors.orange)),
                      onPressed: () {
                        _showCommentsDialog(context, index);
                      },
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.share, color: Colors.orange),
                      label: const Text('Share', style: TextStyle(color: Colors.orange)),
                      onPressed: () => _sharePost(post),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPostDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showCommentsDialog(BuildContext context, int postIndex) {
    final TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Comments', style: TextStyle(color: Colors.orange)),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: posts[postIndex]['comments'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          posts[postIndex]['comments'][index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _commentController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[700]!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.orange)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  _addComment(postIndex, _commentController.text);
                  _commentController.clear();
                  Navigator.of(context).pop();
                  _showCommentsDialog(context, postIndex);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return image.path;
    }
    return null;
  }

  void _showAddPostDialog(BuildContext context) {
    final TextEditingController _contentController = TextEditingController();
    String? _selectedImagePath;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text('Add New Post', style: TextStyle(color: Colors.orange)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _contentController,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.image, color: Colors.black),
                      label: const Text('Add Image', style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        final imagePath = await _pickImage();
                        if (imagePath != null) {
                          setState(() {
                            _selectedImagePath = imagePath;
                          });
                        }
                      },
                    ),
                    if (_selectedImagePath != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Image.file(
                          File(_selectedImagePath!),
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel', style: TextStyle(color: Colors.orange)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Post', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (_contentController.text.isNotEmpty) {
                      setState(() {
                        posts.insert(0, {
                          'username': 'Current User', // Replace with actual user data
                          'timeAgo': 'Just now',
                          'content': _contentController.text,
                          'imageAsset': _selectedImagePath ?? 'assets/images/placeholder.jpg',
                          'likes': 0,
                          'comments': [],
                          'effect': 'none',
                        });
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}