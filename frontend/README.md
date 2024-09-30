# Down The Aisle (Frontend) 🖥️📱🌐

This module contains the frontend app code for the `Down The Aisle` system.

## 🎬 Getting Started

This module utilises the following 2 app environments:

1. Development (`dev`)
2. Production (`prod`)

and it does so with the help of environment variables. The name of the environment variable is `APP_ENV` and it can be added either in the `flutter run` command (for example: `fvm flutter run -t main.dart --dart-define APP_ENV=dev`), otherwise, it can be added in your IDEs configuration settings as well. For example, for VSCode, after cloning the repository, you should see a file named `launch.json` inside the `.vscode` directory that contains the following code:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "frontend",
            "cwd": "frontend",
            "request": "launch",
            "type": "dart",
            "toolArgs": ["--dart-define", "APP_ENV=dev"]
        },
        {
            "name": "frontend (profile mode)",
            "cwd": "frontend",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "toolArgs": ["--dart-define", "APP_ENV=dev"]
        },
        {
            "name": "frontend (release mode)",
            "cwd": "frontend",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        }
    ]
}
```
> For IntelliJ based IDEs, you should be able to set up the same by clicking on `Edit Configurations` and adding the same settings as above

The module also utilises [dotenv](https://pub.dev/packages/dotenv) for secret management and it requires you to manually create 2 files in the `down_the_aisle/frontend/` directory:

1. dotenv.dev
2. dotenv.prod

and both the files should contain the following key(s) (with their value(s)):
```env
BASE_URL=http://localhost:8080
```
> The value above is meant for the `dev` environment to work properly when running the `backend` dart-frog module on `localhost`. For the `prod` environment to work, you will need to set up a project on https://globe.dev and deploy the `backend` app on it (its instructions are given in `backend` module's [README.md](../backend/README.md)).
