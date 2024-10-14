# Blocking

Super library provides some custom actions to block other users.
You can design your own UI for blocking and listing. But you must follow the data structure of the Super library to make everything work together.

The blocked information is saved at `/users/<uid>/{ blockedUsers: [ ] }` in Firestore. And the blocked user list is mirrored to rtdb to work with with the chat and other functionality.




Firestore)
```
/users
   /{uid}
      { blockedUsers: [ other user uid a, b, c, d ] }
```



Database)
```
/blockedUsers
  /{uid}
   [ a , b, c ]
```




You can simply add the other user’s UID as a string in the user’s blockedUsers array field. You can do it with a backend query Or you can use blockUser custom action.


There is no default UI for listing blocked users.

To remove a user from blocking, just remove the user’s UID from blockedUsers array field.


