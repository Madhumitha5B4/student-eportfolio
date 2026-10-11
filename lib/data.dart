// All the content of the portfolio lives here - edit this file to update the app.

import 'package:flutter/material.dart';

// ----------------------------------------------------------------------------
// PROFILE
// ----------------------------------------------------------------------------
const String fullName = 'Vardelli Madhumitha';
const String initials = 'VM';
const String email = '24wh1a05b4@bvrithyderabad.edu.in';
const String phone = '+91-7013163262';
const String github = 'github.com/Madhumitha5B4';
const String linkedin = 'linkedin.com/in/madhumitha-vardelli-b70484353';
const String objective =
    'Computer Science Engineering student passionate about Software '
    'Development, Data Analytics and Problem Solving, seeking opportunities '
    'to apply technical skills and gain industry experience.';

const List<String> skills = [
  'C', 'Java', 'Python', 'OOPS', 'MySQL', 'Tableau', 'Power BI',
];

// ----------------------------------------------------------------------------
// ASSET PATHS
// ----------------------------------------------------------------------------
const String profilePhoto = 'assets/images/photo.png';
const String appLogo = 'assets/images/logo.png';

// Optional video for the Achievements tab. Leave empty ('') to hide it.
// Example: 'assets/achievements/highlights.mp4'
const String achievementVideo = '';

// ----------------------------------------------------------------------------
// 1. ACADEMIC DETAILS  (Course, Institution, Year)
// ----------------------------------------------------------------------------
const List<List<String>> academicData = [
  [
    'B.Tech in Computer Science Engineering - CGPA 9.25',
    'BVRIT Hyderabad College of Engineering for Women, Hyderabad',
    '2024 - 2028'
  ],
  [
    'Intermediate (MPC) - 976 marks',
    'TSRS Junior College, Hyderabad',
    '2022 - 2024'
  ],
  [
    'SSC - GPA 10.0',
    'TSRS School & Junior College, Hyderabad',
    '2022'
  ],
];

// ----------------------------------------------------------------------------
// 2. COURSE CERTIFICATIONS
// ----------------------------------------------------------------------------
// image -> shown in InteractiveViewer (pinch to zoom)
// pdf   -> shown with syncfusion_flutter_pdfviewer
// link  -> opened in the browser with url_launcher
enum CertType { image, pdf, link }

class Certificate {
  final String course;
  final String platform;
  final String year;
  final String source; // asset path, or a URL when type == link
  final CertType type;

  const Certificate({
    required this.course,
    required this.platform,
    required this.year,
    required this.source,
    required this.type,
  });
}

// TODO: put your scans in assets/certificates/ and fix the file names and years.
const List<Certificate> certificates = [
  Certificate(
    course: 'Data Analytics Job Simulation',
    platform: 'Deloitte (Forage)',
    year: '-',
    source:
        'https://www.theforage.com/completion-certificates/9PBTqmSxAf6zZTseP/io9DzWKe3PTsiS6GG_9PBTqmSxAf6zZTseP_690b17c59038277ea5d80f88_1767444555048_completion_certificate.pdf',
    type: CertType.link,
  ),
  Certificate(
    course: 'Object-Oriented Programming in Java',
    platform: 'CodeChef',
    year: '-',
    source: 'https://www.codechef.com/certificates/verify/3826801',
    type: CertType.link,
  ),
  Certificate(
    course: 'Data Structures',
    platform: 'CodeChef',
    year: '-',
    source: 'https://www.codechef.com/certificates/verify/66e05dc',
    type: CertType.link,
  ),
];

// ----------------------------------------------------------------------------
// 3. EXTRA-CURRICULAR ACTIVITIES
// ----------------------------------------------------------------------------
class Activity {
  final String title;
  final String description;
  final IconData icon;

  const Activity({
    required this.title,
    required this.description,
    required this.icon,
  });
}

const List<Activity> activities = [
  Activity(
    title: 'TEDx Event - BVRIT Hyderabad (2024)',
    description: 'Attended talks on innovation and ideas worth spreading',
    icon: Icons.mic,
  ),
  Activity(
    title: 'UI/UX Design Workshop - BVRIT Hyderabad (2025)',
    description: 'Hands-on workshop on design principles and UX fundamentals',
    icon: Icons.design_services,
  ),
  Activity(
    title: 'Build.Deploy.Go Live - Full Stack Bootcamp',
    description:
        '2-day bootcamp by Being Infinity: autosuggest feature, REST APIs, deployment',
    icon: Icons.code,
  ),
  Activity(
    title: 'Smart India Hackathon - Internal (2026)',
    description:
        'Bhoomi Setu: Intelligent Land Record Digitization & Validation System',
    icon: Icons.emoji_objects,
  ),
  Activity(
    title: 'Goldman Sachs India Hackathon (May 2026)',
    description: 'HackerRank coding hackathon - algorithmic challenges in Java',
    icon: Icons.terminal,
  ),
];

// ----------------------------------------------------------------------------
// 4. ACHIEVEMENTS (slideshow)
// ----------------------------------------------------------------------------
// If the photo is missing, the slide falls back to a coloured card with the icon.
class Achievement {
  final String title;
  final String subtitle;
  final String image;
  final IconData icon;

  const Achievement({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
  });
}

const List<Achievement> achievements = [
  Achievement(
    title: 'Academic Excellence',
    subtitle: 'B.Tech CGPA 9.25  |  SSC GPA 10.0',
    image: 'assets/achievements/academics.jpg',
    icon: Icons.school,
  ),
  Achievement(
    title: 'Smart India Hackathon 2026',
    subtitle: 'Bhoomi Setu - land record digitization portal',
    image: 'assets/achievements/sih.jpg',
    icon: Icons.emoji_events,
  ),
  Achievement(
    title: 'Smart Price Comparator',
    subtitle: 'AI-powered price comparison with 30-day forecasting',
    image: 'assets/achievements/price_comparator.jpg',
    icon: Icons.trending_up,
  ),
  Achievement(
    title: 'Goldman Sachs Hackathon',
    subtitle: 'Participated - HackerRank, May 2026',
    image: 'assets/achievements/goldman.jpg',
    icon: Icons.workspace_premium,
  ),
];

const List<List<Color>> slideGradients = [
  [Color(0xFF3F51B5), Color(0xFF7986CB)],
  [Color(0xFF00897B), Color(0xFF4DB6AC)],
  [Color(0xFFE65100), Color(0xFFFFB74D)],
  [Color(0xFF6A1B9A), Color(0xFFBA68C8)],
];
