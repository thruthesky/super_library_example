# Chat


- [Chat](#chat)
  - [Chat Logic](#chat-logic)
    - [User Invitation and Consent](#user-invitation-and-consent)
    - [Chat Room Structure](#chat-room-structure)
      - [Example of `users` Field](#example-of-users-field)
    - [How It Works](#how-it-works)
  - [Chat Room](#chat-room)
    - [How to Create a Chat Room](#how-to-create-a-chat-room)
    - [How to Update a Chat Room](#how-to-update-a-chat-room)
    - [Example](#example)
  - [How to list my Chat Room List](#how-to-list-my-chat-room-list)
    - [Customizing Chat Room List with Custom Code](#customizing-chat-room-list-with-custom-code)
    - [Customizing Chat Room List with Component](#customizing-chat-room-list-with-component)
  - [How to list Open Chat Rooms](#how-to-list-open-chat-rooms)
    - [Customizing Open Chat Room List with Custom Code](#customizing-open-chat-room-list-with-custom-code)
    - [Customizing Open Chat Room List with Component](#customizing-open-chat-room-list-with-component)
  - [Opening a chat room screen](#opening-a-chat-room-screen)
  - [Inviting a user into a chat room](#inviting-a-user-into-a-chat-room)




## Chat Logic

### User Invitation and Consent

We prevent bad users from sending messages to good users.

### Chat Room Structure

Each chat room has a `users` field, which is a map with user IDs (`uid`) as keys and a boolean as values.

#### Example of `users` Field

```json
{
  "users": {
    "A": true,
    "B": false
  }
}
```

### How It Works

1. **Creating a Chat Room**:
    1. When User A starts a chat with User B, a chat room is created with the `users` field.
    2. `A: true` means User A has initiated the chat.
    3. `B: false` means User B has not yet accepted the chat.
2. **Visibility of Chat Room**:
    1. The chat room appears in User A's chat room list.
    2. The chat room does not appear in User B's chat room list until User A sends a message.
3. **Sending a Message**:
    1. When User A sends a message, the chat room becomes visible in User B's chat room list.
4. **User B's Consent**:
    1. Since `B` is `false`, User B sees a confirmation dialog when they tap on the chat room.
    2. If User B accepts, `B` is set to `true`, and the confirmation dialog will no longer appear.

This process ensures that users have control over who can send them messages and join their chat rooms.

## Chat Room

### How to Create a Chat Room

1. **Open Create Chat Room Dialog**:
2. **Call the `createChatRoom` custom action**
    1. Alternatively, use `editChatRoom` which supports both creation and update.
3. **Open the Chat Room**:
    1. After creating the chat room, open it for the user.

### How to Update a Chat Room

1. **Open Update Chat Room Dialog**:
2. Call the `updateChatRoom` custom action.
    1. Alternatively, use `editChatRoom` which supports both creation and update.
3. **Close the Dialog**:
    1. After updating the chat room, close the dialog.





### Example

Here is an example of source code for creating or updating a chat room.

```dart
ElevatedButton(
  onPressed: () async {
    if (widget.roomId != null) {
      await updateChatRoom(
        widget.roomId!,
        nameController.text,
        descriptionController.text,
        iconUrl,
        open,
        canInvite,
      );
      Navigator.of(context).pop();
      return;
    }
    final roomId = await createChatRoom(
      nameController.text,
      descriptionController.text,
      iconUrl,
      open,
      canInvite,
    );
    Navigator.of(context).pop();
    showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) {
        return ChatRoomScreen(
          roomId: roomId,
        );
      },
    );
  },
  child: const Text('Save'),
```





## How to list my Chat Room List


1. Add **ChatRoomListView** custom widget into body in a screen


2. Use onTap action to open a chat room.



### Customizing Chat Room List with Custom Code

Below is a sample code of how you can use the chat room list view widget.

```dart
ChatRoomListView(
  onTap: (roomId) => showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) {
      return ChatRoomScreen(roomId: roomId);
    },
  ),
),
```



### Customizing Chat Room List with Component

1. Make a Component with your own Design

2. Connect your component to Component.chatRoomListTile.

```dart
Component.chatRoomListTile = (join) => ChatRoomListTileWidget(
      roomId: join.roomId,
      name: join.name,
      iconUrl: join.iconUrl,
      displayName: join.displayName,
      photoUrl: join.photoUrl,
      group: join.group,
      single: join.single,
      open: join.open,
      lastMessageAt: join.lastMessageAt,
      lastMessageDeleted: join.lastMessageDeleted,
      lastText: join.lastText,
      lastUrl: join.lastUrl,
      lastProtocol: join.lastProtocol,
      unreadMessageCount: join.unreadMessageCount,
    );
```



## How to list Open Chat Rooms

1. Add OpenChatRoomListView custom widget into body in a screen

2. Use onTap action to open a chat room.


### Customizing Open Chat Room List with Custom Code

Below is a sample code of how you can use the chat room list view widget.

```dart
OpenChatRoomListView(
  onTap: (roomId) => showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) {
      return ChatRoomScreen(
        roomId: roomId,
      );
    },
  ),
)
```

### Customizing Open Chat Room List with Component

1. Make a Component with your own Design

2. Connect your component to Component.chatRoomListTile.


```dart
Component.openChatRoomListTile = (room) => OpenChatRoomListTileWidget(
      roomId: room.id,
      name: room.name,
      description: room.description,
      iconUrl: room.iconUrl,
      users: room.users,
      blockedUsers: room.blockedUids,
      masterUsers: room.masterUsers,
      createdAt: room.createdAt,
      updatedAt: room.updatedAt,
      open: room.open,
      openCreatedAt: room.openCreatedAt,
      single: room.single,
      group: room.group,
      lastMessageAt: room.lastMessageAt,
      allMembersCanInvite: room.allMembersCanInvite,
    );
```



## Opening a chat room screen

1. Create a chat room screen with parameter roomId as String

2. Add ChatMessageListView custom widget from Super library and pass the roomId onto it.

3. Add a TextField widget and a Button
   1. Name the TextField as text
   2. When the button is pressed, call sendChatMessage custom action from the super library with the text.

4. Then open the chat room screen by passing a user’s uid. And continue chat.





## Inviting a user into a chat room

1. Add a button on a group chat room to open a user-invite screen.
   1. Pass the chat room id over the user-invite screen.

2. In the user invite screen, you can search a user as described in User search

3. Call the inviteChatUser custom action to invite the user into the chat room.
   1. Pass the room id and the searched user uid.
















