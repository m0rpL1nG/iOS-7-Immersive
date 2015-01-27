//
//  ChatViewController.m
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 21/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import "ChatViewController.h"
#import <JSQSystemSoundPlayer+JSQMessages.h>

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
    PFUser *testUser1 = self.chatroom[@"user1"];
    if ([testUser1.objectId isEqual:self.currentUser.objectId]) {
        self.withUser = self.chatroom[@"user2"];
    } else {
        self.withUser = self.chatroom[@"user1"];
    }
    self.title = self.withUser[@"profile"][@"firstName"];
    self.initialLoadComplete = NO;

    self.senderId = self.currentUser.objectId;
    self.senderDisplayName = self.currentUser[@"profile"][@"name"];
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

    cell.textView.font = [UIFont systemFontOfSize:16.0f];

    return cell;
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *chat = self.chats[indexPath.row];
    PFUser *fromUser = chat[@"fromUser"];

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
    PFUser *fromUser = chat[@"fromUser"];
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:fromUser.objectId senderDisplayName:fromUser[@"profile"][@"name"] date:chat.createdAt text:chat[@"text"]];

    return message;
}

#pragma mark - Overriden methods

- (void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date
{
    if (text.length) {
        PFObject *chat = [PFObject objectWithClassName:@"Chat"];
        [chat setObject:self.chatroom forKey:@"chatroom"];
        [chat setObject:self.currentUser forKey:@"fromUser"];
        [chat setObject:self.withUser forKey:@"toUser"];
        [chat setObject:text forKey:@"text"];
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
    PFQuery *query = [PFQuery queryWithClassName:@"Chat"];
    [query whereKey:@"chatroom" equalTo:self.chatroom];
    [query includeKey:@"fromUser"];
    [query includeKey:@"toUser"];
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
