# Down The Aisle (Backend 💾)

This package contains all API-related code for the `Down The Aisle` system.

## 🎬 Getting Started

Make sure to have the following environment variables:

1. MONGO_CONNECTION_STRING
2. JWT_AUDIENCE
3. JWT_ISSUER
4. JWT_SECRET

**Tip:** You can make a script to temporarily set the environment variables and run the server with those values, for example:

```sh
#!/bin/bash

# Set environment variables
# <username> (Example: test_user)
# <password> (Example: test_password)
# <host> (Example: localhost)
# <port> (Example: 27017)
# <database_name> (Example: my_database)
export MONGO_CONNECTION_STRING="mongodb://<username>:<password>@<host>:<port>/<database_name>?authSource=admin&maxPoolSize=20&w=majority"
export JWT_AUDIENCE="http://0.0.0.0:8080/"
export JWT_ISSUER="http://0.0.0.0:8080/"
export JWT_SECRET="dev_secret"
export CORS_URL="http://0.0.0.0:8080/"

# Print confirmation
echo "Environment variables have been set:"
echo "MONGO_CONNECTION_STRING=$MONGO_CONNECTION_STRING"
echo "JWT_AUDIENCE=$JWT_AUDIENCE"
echo "JWT_ISSUER=$JWT_ISSUER"
echo "JWT_SECRET=$JWT_SECRET"
echo "CORS_URL=$CORS_URL"

# Start the Dart Frog backend server
dart_frog dev

# Note: The script will stay running with the Dart Frog server. Use Ctrl+C to stop.
```

Make sure to replace `<username>`, `password`, `<host>`, `<port>`, and `<database_name>` to match your own values.

For `production` script, just copy-paste the `connection string` that the MongoDB website provides you, it should be in the following shape:

```
mongodb+srv://<username>:<password>@<host>/<database_name>?retryWrites=true&w=majority&appName=<app_name>
```

Let's assume that you name your script `run_server_dev.sh`, you can run the script using `./run_server_dev.sh ` from the `backend` directory.

## 🌐 Deploy on Globe

In order to run the `production` server, you can host your instance of this `backend` app anywhere you want, this is just an example showing how to do it on https://globe.dev as one option out of many.

You need to follow the guide [here](https://invertase.docs.page/globe/cli) to set up `globe CLI` on your local system. The steps are straightforward, execute the following 2 commands in order:

> **Note:** Make sure to manually create a project on https://globe.dev before following these instructions!

```
fvm dart pub global activate globe_cli
```

```
globe login
```

Then link your Globe project to your local instance by executing the following command inside the `backend` directory:

```
globe link
```

Make sure to copy the `project ID` you receive (if you don't get any, then go to globe.dev's dashboard and grab it from there).

After that, generate a `TOKEN` using the following command (and selecting the appropriate interactive CLI options):

```
globe token create
```

And once you have both these tokens, you can execute the following command to deploy your backend instance on your Globe project:

```
globe deploy --token={YOUR_GLOBE_TOKEN} --project="${YOUR_GLOBE_PROJECT_ID}" --prod
```

Replace `YOUR_GLOBE_TOKEN` and `YOUR_GLOBE_PROJECT_ID` with your own values extracted in the previous steps.

> **Note:** Know that `--prod` is `optional` and can be removed if you want to deploy only on the `preview` track and not the `production` track

If you have cloned/forked this repository, you also have the luxury to just upload your globe token and globe project ID values to your GitHub action secrets (using the following keys: `GLOBE_TOKEN` and `GLOBE_PROJECT_ID`) and as soon as you push changes to any `backend` module related files, your latest instance would automatically be deployed on Globe.

> **Note:** The GitHub action workflow is set up in a way that it deploys to the `production` branch when you push changes to the `main` branch, and deploys to the `preview` branch when you push changes to any other branch than `main`.
