import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'certificate_view_page.dart';
import 'data.dart';
import 'login_page.dart';
import 'ui_common.dart';

// ----------------------------------------------------------------------------
// DASHBOARD - Scaffold + BottomNavigationBar with 5 tabs
// ----------------------------------------------------------------------------
class DashboardPage extends StatefulWidget {
  final String rollNo;
  const DashboardPage({super.key, required this.rollNo});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;

  static const List<String> _titles = [
    'Academic Details',
    'Course Certifications',
    'Extra-Curricular Activities',
    'Achievements',
  ];

  Future<void> _confirmLogout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('No')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Yes')),
        ],
      ),
    );
    if (ok == true && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const _AcademicTab(),
      const _CertificationsTab(),
      const _ActivitiesTab(),
      const _AchievementsTab(),
    ];

    return AppBackground(
      child: CenteredPage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            title: Text(_titles[_index],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Center(
                  child: Chip(
                    avatar: const Icon(Icons.person, size: 16),
                    label: Text(widget.rollNo),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
            ],
          ),
          body: pages[_index],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white.withAlpha(240),
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey.shade600,
            currentIndex: _index,
            onTap: (i) {
              if (i == 4) {
                _confirmLogout();
              } else {
                setState(() => _index = i);
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart), label: 'Academics'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.workspace_premium), label: 'Certificates'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_esports), label: 'Activities'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events), label: 'Achievements'),
              BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 1. ACADEMIC DETAILS - profile card + DataTable
// ----------------------------------------------------------------------------
class _AcademicTab extends StatelessWidget {
  const _AcademicTab();

  Widget _contact(
          BuildContext context, IconData icon, String text, String url) =>
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: InkWell(
          onTap: () async {
            final ok = await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
            if (!ok && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not open the link')),
              );
            }
          },
          child: Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF1565C0)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1565C0),
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _cell(String text, {bool header = false}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: header ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 3,
            shape: kCardShape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: scheme.primaryContainer,
                        child: ClipOval(
                          child: Image.asset(
                            profilePhoto,
                            width: 68,
                            height: 68,
                            fit: BoxFit.cover,
                            errorBuilder: (_, error, __) {
                              debugPrint('Profile photo failed: $error');
                              return Text(
                              initials,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: scheme.primary,
                              ),
                            );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fullName,
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold)),
                            Text('B.Tech CSE  |  BVRIT Hyderabad  |  CGPA 9.25',
                                style: TextStyle(fontSize: 12.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _contact(context, Icons.email, email, 'mailto:$email'),
                  _contact(context, Icons.phone, phone, 'tel:$phone'),
                  _contact(context, Icons.code, github, 'https://$github'),
                  _contact(context, Icons.link, linkedin, 'https://$linkedin'),
                  const SizedBox(height: 12),
                  const Text(objective, style: TextStyle(fontSize: 13.5)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: skills
                        .map((s) => Chip(
                              label: Text(s),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            elevation: 3,
            clipBehavior: Clip.antiAlias,
            shape: kCardShape,
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(3.4),
                2: FlexColumnWidth(1.6),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey.shade300),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: scheme.primaryContainer),
                  children: [
                    _cell('Course', header: true),
                    _cell('Institution', header: true),
                    _cell('Year', header: true),
                  ],
                ),
                ...academicData.map(
                  (r) => TableRow(
                    children: [_cell(r[0]), _cell(r[1]), _cell(r[2])],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// 2. COURSE CERTIFICATIONS - GridView of Cards
// ----------------------------------------------------------------------------
class _CertificationsTab extends StatelessWidget {
  const _CertificationsTab();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisExtent: 270,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: certificates.length,
      itemBuilder: (context, i) {
        final c = certificates[i];
        return Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          shape: kCardShape,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: scheme.primaryContainer,
                  child: Icon(Icons.workspace_premium,
                      size: 20, color: scheme.primary),
                ),
                const SizedBox(height: 10),
                Text(
                  c.course,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Platform: ${c.platform}',
                    style: const TextStyle(fontSize: 13)),
                Text('Year: ${c.year}', style: const TextStyle(fontSize: 13)),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonal(
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8)),
                    onPressed: () => openCertificate(context, c),
                    child: const FittedBox(child: Text('View Certificate')),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ----------------------------------------------------------------------------
// 3. EXTRA-CURRICULAR ACTIVITIES - ListView of ListTiles
// ----------------------------------------------------------------------------
class _ActivitiesTab extends StatelessWidget {
  const _ActivitiesTab();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: activities.length,
      itemBuilder: (context, i) {
        final a = activities[i];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 10),
          shape: kCardShape,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: CircleAvatar(
              backgroundColor: scheme.primaryContainer,
              child: Icon(a.icon, color: scheme.primary),
            ),
            title: Text(a.title,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(a.description),
          ),
        );
      },
    );
  }
}

// ----------------------------------------------------------------------------
// 4. ACHIEVEMENTS - auto slideshow (+ optional video)
// ----------------------------------------------------------------------------
class _AchievementsTab extends StatefulWidget {
  const _AchievementsTab();

  @override
  State<_AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<_AchievementsTab> {
  int _current = 0;

  Widget _slide(int i) {
    final a = achievements[i];
    final g = slideGradients[i % slideGradients.length];
    return AnimatedOpacity(
      opacity: i == _current ? 1.0 : 0.6, // fade effect
      duration: const Duration(milliseconds: 500),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: g,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
                color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 6)),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fallback look when the photo is missing
            Center(
              child: Icon(a.icon, size: 96, color: Colors.white.withAlpha(120)),
            ),
            Image.asset(
              a.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
            // Dark fade at the bottom so the text is readable on any photo
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xAA000000)],
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(a.subtitle,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 13.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        const SizedBox(height: 8),
        CarouselSlider.builder(
          itemCount: achievements.length,
          itemBuilder: (context, i, realIndex) => _slide(i),
          options: CarouselOptions(
            height: 320,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom, // zoom effect
            viewportFraction: 0.82,
            onPageChanged: (i, reason) => setState(() => _current = i),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(achievements.length, (i) {
            final active = i == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active ? scheme.primary : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        if (achievementVideo.isNotEmpty)
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: _AchievementVideo(),
          ),
      ],
    );
  }
}

/// Optional video card (shown only when achievementVideo is set in data.dart).
class _AchievementVideo extends StatefulWidget {
  const _AchievementVideo();

  @override
  State<_AchievementVideo> createState() => _AchievementVideoState();
}

class _AchievementVideoState extends State<_AchievementVideo> {
  late final VideoPlayerController _c;
  bool _ready = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _c = VideoPlayerController.asset(achievementVideo);
    _c.setLooping(true);
    _c.initialize().then((_) {
      if (mounted) setState(() => _ready = true);
    }).catchError((_) {
      if (mounted) setState(() => _failed = true);
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: kCardShape,
      child: _failed
          ? const ListTile(
              leading: Icon(Icons.videocam_off),
              title: Text('Video not found'),
            )
          : !_ready
              ? const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    AspectRatio(
                      aspectRatio: _c.value.aspectRatio,
                      child: VideoPlayer(_c),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton.filled(
                        onPressed: () {
                          setState(() {
                            if (_c.value.isPlaying) {
                              _c.pause();
                            } else {
                              _c.play();
                            }
                          });
                        },
                        icon: Icon(_c.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                      ),
                    ),
                  ],
                ),
    );
  }
}