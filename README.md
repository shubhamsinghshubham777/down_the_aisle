# Down The Aisle

This repository contains both frontend and backend code for the app 'Down the Aisle'. This project uses FVM to lock itself to a specific Flutter version.

## Maintenance

To quickly update the Flutter version used in both `frontend`, `backend`, and `.github/workflows` directories, copy-paste the following command in your terminal:

```sh
chmod +x scripts/change_flutter_version.sh; ./scripts/change_flutter_version.sh NEW_FLUTTER_VERSION
```

where `NEW_FLUTTER_VERSION` is the version you want to upgrade to. For example:

```sh
chmod +x scripts/change_flutter_version.sh; ./scripts/change_flutter_version.sh 3.24.2
```

## Common Code Snippets

```sh
fvm dart run build_runner build --delete-conflicting-outputs
```

```sh
fvm dart run build_runner watch --delete-conflicting-outputs
```
