# backend

This package contains all API-related code for the `Down The Aisle` app.

## Getting Started

Make sure to have the following environment variables:

1. MONGO_CONNECTION_STRING
2. JWT_AUDIENCE
3. JWT_ISSUER
4. JWT_SECRET

You can make a script to temporarily set the environment variables and run the server with those values, for example:

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

# Print confirmation
echo "Environment variables have been set:"
echo "MONGO_CONNECTION_STRING=$MONGO_CONNECTION_STRING"
echo "JWT_AUDIENCE=$JWT_AUDIENCE"
echo "JWT_ISSUER=$JWT_ISSUER"
echo "JWT_SECRET=$JWT_SECRET"

# Start the Dart Frog backend server
dart_frog dev

# Note: The script will stay running with the Dart Frog server. Use Ctrl+C to stop.
```

Make sure to replace `<username>`, `password`, `<host>`, `<port>`, and `<database_name>` to match your own values.

For `production` script, just copy-paste the `connection string` that the MongoDB website provides you, it should be in the following shape:

```
mongodb+srv://<username>:<password>@<host>/<database_name>?retryWrites=true&w=majority&appName=<app_name>
```
