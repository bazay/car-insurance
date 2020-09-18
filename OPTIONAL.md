# Optional discussion points

Please ignore these until you have completed the main exercise.

## Filesystem monitoring

Suppose the application constantly monitors a directory on the filesystem. JSON files representing quote requests from customers appear in the directory and have to be parsed in real time. How would you tackle this problem?

## Notifications

Suppose the customer request also specifies how the customer wants to receive their quote:

```json
{
  "name": "John",
  "covers": {
    "tires": 10,
    "windows": 50,
    "engine": 20,
    "contents": 30,
    "doors": 15
  },
  "notify": "email",
  "notify_to": "john@gg.com"
}
```

The value of the `notify` parameter can be either `email` or `sms`. The value of the `notify_to` parameter will be provided accordingly and it can be an email address or a phone number. How would you implement notifications in the system?
