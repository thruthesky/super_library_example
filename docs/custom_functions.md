# Custom Functions

## `endRange`

### Purpose

Returns the end string of the search range.

### Why Use This Function?

This function is designed for querying a string field within a specific range.

### Example Use Case

Suppose you want to search for names that begin with "You". You can query like this:

```sql
name >= "You" && name < "You"
```

### Backend Query Example

Below is an example of a backend query in a ListView to perform a case-insensitive user search.

![image.png](/images/image (3).png)

