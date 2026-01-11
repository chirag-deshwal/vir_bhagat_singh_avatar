import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class KprVerseScreen extends StatefulWidget {
  const KprVerseScreen({super.key});

  @override
  State<KprVerseScreen> createState() => _KprVerseScreenState();
}

class _KprVerseScreenState extends State<KprVerseScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // KPRVerse Color Palette
    const kNeonGreen = Color(0xFFCCFF00); // Lime/Neon Green
    const kDarkBg = Color(0xFF050505);
    const kTextWhite = Colors.white;

    return Scaffold(
      backgroundColor: kDarkBg,
      body: Stack(
        children: [
          // Main Scrollable Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Navbar Placeholder (Floating)
              SliverAppBar(
                backgroundColor: const Color.fromARGB(230, 5, 5, 5),
                elevation: 0,
                floating: true,
                pinned: true,
                title: Text(
                  "KPRVERSE",
                  style: GoogleFonts.orbitron(
                    color: kTextWhite,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "SIGN IN",
                      style: GoogleFonts.robotoMono(
                        color: kTextWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.menu, color: kNeonGreen),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                ],
              ),

              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                            "WE ARE",
                            style: GoogleFonts.orbitron(
                              color: kTextWhite,
                              fontSize: 20,
                              letterSpacing: 10,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .slideY(begin: 0.2, end: 0),
                      Text(
                            "KEEPERS",
                            style: GoogleFonts.orbitron(
                              color: kTextWhite,
                              fontSize: 80,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 5,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 800.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1, 1),
                          ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: kNeonGreen, width: 1),
                        ),
                        child: Text(
                          "// SYSTEM INITIALIZED",
                          style: GoogleFonts.robotoMono(color: kNeonGreen),
                        ),
                      ).animate().fadeIn(delay: 500.ms),
                    ],
                  ),
                ),
              ),

              // Narrative Section 1
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 100,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "A NEW WORLD AWAITS",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                          color: kTextWhite,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn().moveY(begin: 50, end: 0),
                      const SizedBox(height: 20),
                      Text(
                        "The Keep is not just a place. It is a purpose. \nStandardized. Optimized. Revolutionized.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoMono(
                          color: Colors.grey,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3D Card / Character Section Simulation
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      return Container(
                            width: 280,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              border: Border.all(color: Colors.white24),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.person,
                                      size: 64,
                                      color: Colors.white12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "KEEPER #${1000 + index}",
                                          style: GoogleFonts.orbitron(
                                            color: kTextWhite,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "Rank: Initiate",
                                          style: GoogleFonts.robotoMono(
                                            color: kNeonGreen,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate(delay: (100 * index).ms)
                          .fadeIn()
                          .slideX(begin: 0.1, end: 0);
                    },
                  ),
                ),
              ),

              // More Scrolling Content
              SliverToBoxAdapter(
                child: Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "SCROLL TO EXPLORE",
                    style: GoogleFonts.robotoMono(color: Colors.white24),
                  ),
                ),
              ),

              const SliverFillRemaining(
                hasScrollBody: false,
                child: SizedBox(height: 100), // Spacer
              ),
            ],
          ),

          // Fixed overlay elements (like the 'scroll' indicator or decorative lines)
          Positioned(
            left: 20,
            bottom: 20,
            child: Text(
              "V 1.0.0",
              style: GoogleFonts.robotoMono(
                color: Colors.white24,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
