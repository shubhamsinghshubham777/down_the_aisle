<h1 align="center">Down The Aisle 💍</h1>
<p align="center">A multiplatform wedding planner app that helps you manage all your wedding-related tasks from A to Z 💒</p>

# 🚧 Work In Progress

Please note that `Down The Aisle` is currently a work-in-progress. Due to lack of time in my schedule, only a few preview features have been implemented and deployed for demonstration purposes. The goal is to demonstrate that a multiplatform full-stack system can be written only using the `Dart` ecosystem.

# 🧐 Features

You can check the latest Web deployment of `Down The Aisle` [here](https://shubhamsinghshubham777.github.io/down_the_aisle/)

## 🔐 Authentication

Securely login or sign-up using your credentials

<img src="assets/app_auth_1.webp" width=300 /> <img src="assets/app_auth_2.webp" width=300 /> <img src="assets/app_auth_3.webp" width=300 />

## 🔔 Tracking

Get notified about your upcoming events

<img src="assets/app_home.webp" width=300 /> <img src="assets/app_top_sheet.webp" width=300 /> <img src="assets/app_dashboard.webp" width=300 />

## 🍕 Vendor Management

Pick and choose your favourite vendor teams (food, venue, etc.)

<img src="assets/app_vendors.webp" width=300 />

# 🌐 Supported Platforms

The frontend app supports all platforms officially supported by Flutter 🙌🏼🥳

| Android                                        | iOS                                          | macOS                                        | Web                                        | Windows                                        | Linux                                        |
|------------------------------------------------|----------------------------------------------|----------------------------------------------|--------------------------------------------|------------------------------------------------|----------------------------------------------|
| <img src="assets/logo_android.svg" width=64 /> | <img src="assets/logo_apple.svg" width=64 /> | <img src="assets/logo_apple.svg" width=64 /> | <img src="assets/logo_web.svg" width=64 /> | <img src="assets/logo_windows.svg" width=64 /> | <img src="assets/logo_linux.svg" width=64 /> |

# 💻 Tech Stack

This is a full-stack repository that contains code for both the `frontend` and `backend` apps. The collective tech-stack is as follows:

| Category                          |                                                    |                                                       |
|-----------------------------------|----------------------------------------------------|-------------------------------------------------------|
| **Programming Language (Common)** | <img src="assets/logo_dart.svg" width=48 />        | [Dart](https://dart.dev)                              |
| **Frontend Framework**            | <img src="assets/logo_flutter.svg" width=48 />     | [Flutter](https://flutter.dev)                        |
| **Backend Framework**             | <img src="assets/logo_dart_frog.svg" width=48 />   | [Dart Frog](https://dartfrog.vgv.dev)                 |
| **Database (Backend)**            | <img src="assets/logo_mongo_db.svg" width=48 />    | [Mongo DB](https://www.mongodb.com)                   |
| **CI / CD**                       | <img src="assets/logo_github.svg" width=48 />      | [GitHub Actions](https://github.com/features/actions) |
| **Version Management (Flutter)**  | <img src="assets/logo_fvm.svg" width=48 />         | [FVM](https://fvm.app)                                |
| **Hosting (Frontend Web App)**    | <img src="assets/logo_globe.svg" width=48 />       | [Globe](https://globe.dev)                            |
| **Hosting (Backend App)**         | <img src="assets/logo_github.svg" width=48 />      | [GitHub Pages](https://pages.github.com)              |

# 👨‍💻 Contribution

Feel free to follow the `README.md` files of both [frontend](frontend/README.md) and [backend](backend/README.md) modules to be able to run this project on your system locally and be able to contribute. All PRs are welcomed 🙌🏼

## 👷 Maintenance

To quickly update the Flutter version used in both `frontend`, `backend`, and `.github/workflows` directories, copy-paste the following command in your terminal:

```sh
chmod +x scripts/change_flutter_version.sh; ./scripts/change_flutter_version.sh NEW_FLUTTER_VERSION
```

where `NEW_FLUTTER_VERSION` is the version you want to upgrade to. For example:

```sh
chmod +x scripts/change_flutter_version.sh; ./scripts/change_flutter_version.sh 3.24.2
```

## ✂️ Common Code Snippets

Generate files (one-time)

```sh
fvm dart run build_runner build --delete-conflicting-outputs
```

Generate files (continuous)

```sh
fvm dart run build_runner watch --delete-conflicting-outputs
```

# 🖼️ Design Credits

"_Credit where credit is due_". Therefore, the complete credits (and a shoutout) for the designs of this app go to [Nickelfox Design](https://www.figma.com/@Nickelfox). I took inspiration from their freely available design file on Figma by the name of [Indian Wedding Planning App](https://www.figma.com/community/file/1159023832797091701/indian-wedding-planning-app). Do check out the rest of their designs to take inspiration for your next app, they're really cool!

# 📚 Resources

The requirement I faced while developing the `frontend` module of this system (i.e. to achieve a smooth transition while switching between pages while also being able to maintain their states) forced me to take inspiration from the world and create + publish my own first flutter library called `easy_animated_indexed_stack`.

You can find it on:
1. pub.dev ([easy_animated_indexed_stack](https://pub.dev/packages/easy_animated_indexed_stack))
2. And I have also written a [Medium article](https://medium.com/@shubhamsinghshubham777/animate-screen-switches-for-indexedstack-in-flutter-a66fe488006b) explaining and demonstrating the need behind it and its benefits
