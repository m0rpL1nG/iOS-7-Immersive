//
//  ChatViewController.h
//  MatchedUp
//
//  Created by Pierre-Yves LEBECQ on 21/01/2015.
//  Copyright (c) 2015 Pierre-Yves Lebecq. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessages.h>
#import <Parse/Parse.h>

@interface ChatViewController : JSQMessagesViewController <JSQMessagesCollectionViewDataSource>

@property (strong, nonatomic) PFObject *chatroom;

@end
