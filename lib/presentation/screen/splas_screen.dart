import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobapp/presentation/screen/job_list_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const SplashScreen({super.key, required this.onThemeToggle});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const JobListScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Colors.teal.shade900, Colors.teal.shade300]
                : [Colors.blue.shade900, Colors.blue.shade300],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: _buildLogo(isDarkMode),
              ),
              const SizedBox(height: 20),
              Text(
                'Job App',
                style: GoogleFonts.poppins(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(3, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Unlock Your Career Potential',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 30),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDotAnimation(delay: 0),
                    const SizedBox(width: 8),
                    _buildDotAnimation(delay: 200),
                    const SizedBox(width: 8),
                    _buildDotAnimation(delay: 400),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: widget.onThemeToggle,
                tooltip: 'Toggle Theme',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(isDarkMode ? 0.1 : 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.work_outline,
        size: 80,
        color: isDarkMode ? Colors.teal.shade200 : Colors.white,
      ),
    );
  }

  Widget _buildDotAnimation({required int delay}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              0,
              -10 *
                  (0.5 -
                      (0.5 *
                              (_controller.value - delay / 2000).clamp(0, 1))
                          .abs())),
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}