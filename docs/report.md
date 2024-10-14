# Reporting

Superlibrary provides custom actions to report users/chat message/chat room/ or any kinds of content.

But the developer must list the report list using the FlutterFlow Backend Query.

The blocked information is saved in Firestore.

Firestore - database structure

```
/reports
   /<report-id>
     {
        reporterUid:
        reporteeUid:
        createdAt:
        reason:
        summary:
        id:
        type:
        order: 
     }
```

Based on the database structure, you can create any UI and UX.


## How to report

- Use report custom action to save the reporting instead of writing your own logic. You can save the reporting with your own Backend Query if you want.

- Don’t ask the user to type anything.
But let the user click(tap) one or two times.
For instance, let the user choose one of the reasons: (1) Spam (2) Abusing (3) Bad content - instead of asking the user to type.


- `summary` - is the summary of the content. If it is a post, add title and first part of the content. Don’t ask the user to type anything to input a summary. 

- `type` - can be any type of data. It can be a user, chat, post, comment, photo, etc.
- `id` - is the id(or key) of the data(document key, photo url, etc) that you are reporting. This id goes together with the type. If the type is
  - `post`, then, this id will be the key of the post.
  - `user`, then this id will be the user’s uid.
  - Note that the type and id  are used to track(connect) to the original data(content, document). For instance, if the type is chat-room then, the id is the chat room id. And in the admin’s screen, the admin can destroy the chat room and block the master’s account.

- Document ID will be generated like <login-user-uid>-type-id.
  - To check if the document exists, check if the document id exists.



## How to check if the same content has been reported

- Use reportExists custom action to check if the login user has already reported the same content.
  - You can do this with your own Backend Query.



## How to display reports for the login user

- Backend query the reports collection with
  - Order by `createdAt` to display all the reports
  - `type` and a type of post and with `createdAt`
  - `reportee` for whom were reported with combination of type and createdAt


## How to Display Reports for the Admin

To display reports for the admin, perform a backend query on the reports collection using the following criteria:

1. **Order by `createdAt`**: Display all reports sorted by their creation date.

1. **Filter by `type`**: Filter reports by the type of post and sort by `createdAt`.

2. **Filter by `reporter`**:  Filter reports by the user who reported them, combined with `type` and `createdAt`.

3. **Filter by `reportee`**: Filter reports by the user who was reported, combined with `type` and `createdAt`.

You can use any combination of the above fields to make the backend query.



