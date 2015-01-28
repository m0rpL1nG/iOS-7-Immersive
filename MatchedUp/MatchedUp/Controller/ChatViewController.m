//
//  ChatViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 21/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "ChatViewController.h"
#import <JSQSystemSoundPlayer+JSQMessages.h>
#import "Constants.h"

@interface ChatViewController ()

@property (strong, nonatomic) PFUser *withUser;
@property (strong, nonatomic) PFUser *currentUser;

@property (strong, nonatomic) NSTimer *chatTimer;
@property (nonatomic) BOOL initialLoadComplete;

@property (strong, nonatomic) NSMutableArray *chats;

@end

@implementation ChatViewController

#pragma mark - Lazy Instanciation

- (NSMutableArray *)chats
{
    if (!_chats) {
        _chats = [[NSMutableArray alloc] init];
    }

    return _chats;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.inputToolbar.contentView.textView.placeHolder = @"New message";
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];

    self.currentUser = [PFUser currentUser];
    PFUser *testUser1 = self.chatroom[kChatRoomUser1Key];
    if ([testUser1.objectId isEqual:self.currentUser.objectId]) {
        self.withUser = self.chatroom[kChatRoomUser2Key];
    } else {
        self.withUser = self.chatroom[kChatRoomUser1Key];
    }
    self.title = self.withUser[kUserProfileKey][kUserProfileFirstNameKey];
    self.initialLoadComplete = NO;

    self.senderId = self.currentUser.objectId;
    self.senderDisplayName = self.currentUser[kUserProfileKey][kUserProfileNameKey];
    [self checkForNewChats];

    self.chatTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(checkForNewChats) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.chatTimer invalidate];
    self.chatTimer = nil;
}

#pragma mark - JSQMessagesCollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.chats count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];

    cell.textView.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];

    return cell;
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *chat = self.chats[indexPath.row];
    PFUser *fromUser = chat[kChatFromUserKey];

    if ([fromUser.objectId isEqual:self.currentUser.objectId]) {
        return [[[JSQMessagesBubbleImageFactory alloc] init] outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    }

    return [[[JSQMessagesBubbleImageFactory alloc] init] incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *chat = self.chats[indexPath.row];
    PFUser *fromUser = chat[kChatFromUserKey];
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:fromUser.objectId senderDisplayName:fromUser[kUserProfileKey][kUserProfileNameKey] date:chat.createdAt text:chat[kChatTextKey]];

    return message;
}

#pragma mark - Overriden methods

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date
{
    if (text.length) {
        PFObject *chat = [PFObject objectWithClassName:kChatClassKey];
        [chat setObject:self.chatroom forKey:kChatChatroomKey];
        [chat setObject:self.currentUser forKey:kChatFromUserKey];
        [chat setObject:self.withUser forKey:kChatToUserKey];
        [chat setObject:text forKey:kChatTextKey];
        [chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.chats addObject:chat];
            [JSQSystemSoundPlayer jsq_playMessageSentSound];
            [self.collectionView reloadData];
            [self finishSendingMessageAnimated:YES];
            [self scrollToBottomAnimated:YES];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helper methods

- (void)checkForNewChats
{
    int oldChatCount = [self.chats count];
    PFQuery *query = [PFQuery queryWithClassName:kChatClassKey];
    [query whereKey:kChatChatroomKey equalTo:self.chatroom];
    [query includeKey:kChatFromUserKey];
    [query includeKey:kChatToUserKey];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (self.initialLoadComplete == NO || oldChatCount != [objects count]) {
                self.chats = [objects mutableCopy];
                [self.collectionView reloadData];
                if (self.initialLoadComplete == YES) {
                    [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
                }
                self.initialLoadComplete = YES;
                [self scrollToBottomAnimated:YES];
            }
        }
    }];
}

@end
