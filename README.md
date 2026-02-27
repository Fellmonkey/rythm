# 🌿 HabitScape

[![Flutter](https://img.shields.io/badge/Built_with-Flutter-02569B?logo=flutter)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#contributing)
[![Platform: Android | Web](https://img.shields.io/badge/Platform-Android%20%7C%20Web%20(PWA)-lightgrey)](#)

> **The compassionate habit tracker.** Turn your daily routines into a living, procedural timeline.

Traditional habit trackers punish you for missing a day. They break your streak, kill your digital pets, and induce anxiety. **HabitScape is different.** 

Built for mental well-being and ADHD-friendly productivity, HabitScape uses **Compassionate Gamification**. Plants never die. If you miss a few days, your garden simply rests (turning into beautiful moss or a Zen rock garden). When you return, the growth continues. 

No servers. No subscriptions. 100% your data.

## ✨ Features

* 🧭 **The Timeline Garden:** Your habits don't just grow infinitely. Every month, your progress crystallizes into a unique procedural plant and is placed on an interactive, scrollable 3D timeline of your life.
* 🧬 **Procedural Flora (`CustomPaint`):** Plants aren't static images. They are mathematically generated. The stem height, leaf density, and colors depend on your actual habit stats (streak length, time of day, completion rate).
* 🫂 **Compassionate Gamification:** 
  * Skipped a day? The plant just goes to sleep.
  * Had a bad month? You get a beautiful glowing moss or a Zen stone. No dead bushes, no guilt.
* 🔒 **Local-First & Serverless:** All data lives on your device using `drift` (SQLite). No accounts, no cloud sync, complete privacy.
* 🌐 **PWA Ready:** Installable on Desktop and iOS via browser, natively compiled for Android.
* 🤝 **Peer-to-Peer Sharing:** Share your garden using encrypted base64 "Friend Codes" without any backend.

## 🛠 Tech Stack

This project is built to be a modern, highly optimized Flutter application:
* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **State Management:** [Riverpod](https://riverpod.dev/) (`hooks_riverpod` + code generation)
* **Database:** [Drift](https://drift.simonbinder.eu/) (Robust, reactive SQLite wrapper, Wasm-compatible for Web)
* **Rendering:** Heavy use of `CustomPaint` and `Canvas API` (L-Systems & Fractals) for procedural generation, with raster-caching to maintain 60-120 FPS on the Timeline.

## 🚀 Getting Started : TODO



## 🌱 Contributing: Grow with us!

HabitScape is entirely open-source, and we'd love your help! You don't just have to fix bugs — **you can plant new trees!**

Since all flora is procedurally generated via `CustomPaint`, we invite developers and creative coders to submit new plant algorithms (L-Systems, fractals, unique tree types). 

Check out our [CONTRIBUTING.md](CONTRIBUTING.md) to learn how to add your own procedural "Seed" to the app.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.