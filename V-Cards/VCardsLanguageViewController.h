//
//  VCardsLanguageViewController.h
//  V-Cards
//
//  Created by Christopher Zahka on 6/1/13.
//  Copyright (c) 2013 Christopher Zahka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCardsLanguageViewController : UIViewController<NSLayoutManagerDelegate>

@property (weak, nonatomic) NSString *languageSelected;
@property (strong, nonatomic) IBOutlet UITextView *languageTextView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (void)setLanguageSelected:(NSString *)languageSelected;

@end
