import 'package:flutter/material.dart';

class ResumeData {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String website;
  final String about1;
  final String about2;
  final List<ServiceItem> services;
  final List<Testimonial> testimonials;
  final List<Education> education;
  final List<Experience> experience;
  final List<Skill> skills;
  final List<ProjectItem> projects;
  final List<BlogPost> blogPosts;

  const ResumeData({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    required this.website,
    required this.about1,
    required this.about2,
    required this.services,
    required this.testimonials,
    required this.education,
    required this.experience,
    required this.skills,
    required this.projects,
    required this.blogPosts,
  });

  static const ResumeData piyush = ResumeData(
    name: "Piyush Singh",
    title: "Flutter Developer",
    email: "singhpiyush2604@gmail.com",
    phone: "+91 8983302922",
    location: "Mumbai, India 401303",
    website: "piyushsingh2604.github.io",
    about1:
        "Results-driven Flutter Developer with 1.5+ years of hands-on industry experience delivering cross-platform mobile applications to real users on Google Play and the App Store. Specialized in Flutter/Dart, Firebase ecosystem, offline-first architecture, and scalable state management.",
    about2:
        "Built and published 3 personal apps and contributed to enterprise-grade products across healthcare, field operations, and ed-tech — all while pursuing a B.Sc. IT degree. Passionate about crafting high-performance, pixel-perfect experiences that solve real problems.",
    services: [
      ServiceItem(
        icon: Icons.phone_android,
        title: "Mobile Apps",
        description:
            "Professional development of cross-platform applications for iOS and Android using Flutter.",
      ),
      ServiceItem(
        icon: Icons.web,
        title: "Web Development",
        description:
            "High-quality development of responsive web applications at the professional level.",
      ),
      ServiceItem(
        icon: Icons.cloud_queue,
        title: "Firebase & Backend",
        description:
            "Full Firebase ecosystem integration including Auth, Firestore, Cloud Functions, and Push Notifications.",
      ),
      ServiceItem(
        icon: Icons.design_services_outlined,
        title: "UI/UX Implementation",
        description:
            "Pixel-perfect implementation of modern, intuitive interfaces from design wireframes.",
      ),
    ],
    testimonials: [
      Testimonial(
        name: "Partical 14 Team",
        role: "Flutter Developer",
        text:
            "Piyush engineered and shipped production Flutter features serving live users across iOS and Android platforms. He championed clean architecture by leading code reviews and enforcing best practices team-wide.",
      ),
      Testimonial(
        name: "Anjita IT Solutions",
        role: "Flutter Developer",
        text:
            "Delivered cross-platform Flutter apps published on both Google Play Store and Apple App Store. Architected state management using GetX and Provider patterns, boosting app scalability and code clarity.",
      ),
      Testimonial(
        name: "CoreNova Tech",
        role: "Founder & Developer",
        text:
            "Founded CoreNova Tech and published 3 apps: Writemate (marketplace), Jai Respi App (field reporting), and HUMRAHI (health companion). Built end-to-end as solo developer.",
      ),
      Testimonial(
        name: "College Project Lead",
        role: "IT Student",
        text:
            "Hired by 2 companies while studying full-time — trusted by industry before graduation. Built and published 3 personal apps as a 2nd-year student.",
      ),
    ],
    education: [
      Education(
        school: "Viva College of Arts, Commerce & Science",
        degree: "B.Sc. Information Technology",
        period: "2024 — 2027",
        description:
            "Pursuing Bachelor of Science in Information Technology. Currently in 2nd year with expected graduation in 2027.",
      ),
      Education(
        school: "Self-Taught Development",
        degree: "Mobile App Engineering",
        period: "2023 — Present",
        description:
            "Self-taught Flutter developer with hands-on industry experience. Specialized in Flutter/Dart, Firebase, state management, and cross-platform deployment.",
      ),
    ],
    experience: [
      Experience(
        company: "Partical 14",
        role: "Flutter Developer",
        period: "Nov 2025 — May 2026",
        location: "Mumbai, India",
        description:
            "Engineered and shipped production Flutter features serving live users across iOS and Android platforms. Partnered with design and product teams in Agile sprints. Built reusable API service layers and integrated third-party SDKs. Championed clean architecture by leading code reviews. Resolved critical performance bottlenecks.",
      ),
      Experience(
        company: "Anjita IT Solutions",
        role: "Flutter Developer",
        period: "Nov 2024 — Sep 2025",
        location: "Mumbai, India",
        description:
            "Delivered cross-platform Flutter apps published on both Google Play Store and Apple App Store. Architected state management using GetX and Provider patterns. Integrated Firebase Auth, Firestore, and Push Notifications. Collaborated with UI/UX designers to implement responsive interfaces.",
      ),
      Experience(
        company: "CoreNova Tech",
        role: "Founder & Solo Developer",
        period: "2025 — Present",
        location: "Mumbai, India",
        description:
            "Founded and built 3 personal apps: Writemate (marketplace app), Jai Respi App (enterprise field reporting), and HUMRAHI (health companion app with 11-language localization).",
      ),
    ],
    skills: [
      Skill(name: "Flutter & Dart", percentage: 90),
      Skill(name: "Firebase", percentage: 85),
      Skill(name: "REST API", percentage: 80),
      Skill(name: "GetX / Provider", percentage: 85),
      Skill(name: "UI/UX Design", percentage: 75),
      Skill(name: "iOS & Android Deploy", percentage: 80),
      Skill(name: "SQLite / Hive DB", percentage: 70),
      Skill(name: "Git & GitHub", percentage: 80),
    ],
    projects: [
      ProjectItem(
        title: "Writemate",
        category: "Applications",
        description:
            "A location-based marketplace connecting students with skilled writers for assignments, essays, and projects. Features smart geo-location matching, profile browsing with writing sample uploads, and direct call/chat communication.",
      ),
      ProjectItem(
        title: "HUMRAHI",
        category: "Applications",
        description:
            "Comprehensive health management platform for diabetes, cardiac conditions, and cholesterol. Features real-time health trackers, Health Connect/Apple Health/Fitbit API integration, and 11 Indian language localization.",
      ),
      ProjectItem(
        title: "Jai Respi App",
        category: "Web development",
        description:
            "Enterprise field reporting and real-time activity tracking system. Offline-first architecture enabling seamless report capture without internet connectivity with automatic background sync.",
      ),
      ProjectItem(
        title: "Portfolio Website",
        category: "Web development",
        description:
            "Personal portfolio website built with Flutter Web showcasing projects, skills, and experience. Fully responsive design with dark theme.",
      ),
      ProjectItem(
        title: "Health Connect API",
        category: "Web design",
        description:
            "Unified Health Connect, Apple Health, and Fitbit APIs into a single Flutter codebase. Rare cross-platform depth implementation.",
      ),
      ProjectItem(
        title: "Multilingual Engine",
        category: "Web design",
        description:
            "Custom-built multilingual search engine supporting 11 Indian languages. Expanding accessibility to millions of regional-language speakers.",
      ),
    ],
    blogPosts: [
      BlogPost(
        title: "Building Offline-First Flutter Apps",
        category: "Development",
        date: "Mar 15, 2026",
        description:
            "How I built an offline-first architecture with zero data loss for enterprise field reporting applications.",
      ),
      BlogPost(
        title: "Shipping 3 Apps While in College",
        category: "Development",
        date: "Feb 10, 2026",
        description:
            "My journey of building and publishing 3 production apps on Play Store and App Store as a 2nd-year student.",
      ),
      BlogPost(
        title: "11-Language Localization in Flutter",
        category: "Design",
        date: "Jan 5, 2026",
        description:
            "How I implemented multilingual support with custom search engine for 11 Indian languages in a health app.",
      ),
      BlogPost(
        title: "Unifying Health APIs in Flutter",
        category: "Development",
        date: "Dec 20, 2025",
        description:
            "Integrating Health Connect, Apple Health, and Fitbit APIs into a single unified step-counter codebase.",
      ),
      BlogPost(
        title: "State Management Showdown",
        category: "Development",
        date: "Nov 8, 2025",
        description:
            "Comparing GetX vs Provider vs BLoC patterns in production Flutter apps — lessons from real projects.",
      ),
      BlogPost(
        title: "From Idea to Play Store",
        category: "Design",
        date: "Oct 12, 2025",
        description:
            "The complete journey of conceptualizing, designing, building, and publishing a marketplace app solo.",
      ),
    ],
  );
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class Testimonial {
  final String name;
  final String role;
  final String text;

  const Testimonial({
    required this.name,
    required this.role,
    required this.text,
  });
}

class Education {
  final String school;
  final String degree;
  final String period;
  final String description;

  const Education({
    required this.school,
    required this.degree,
    required this.period,
    required this.description,
  });
}

class Experience {
  final String company;
  final String role;
  final String period;
  final String location;
  final String description;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.description,
  });
}

class Skill {
  final String name;
  final int percentage;

  const Skill({
    required this.name,
    required this.percentage,
  });
}

class ProjectItem {
  final String title;
  final String category;
  final String description;

  const ProjectItem({
    required this.title,
    required this.category,
    required this.description,
  });
}

class BlogPost {
  final String title;
  final String category;
  final String date;
  final String description;

  const BlogPost({
    required this.title,
    required this.category,
    required this.date,
    required this.description,
  });
}