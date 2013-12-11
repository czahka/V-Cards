//
//  VCardsLanguageViewController.m
//  V-Cards
//
//  Created by Christopher Zahka on 6/1/13.
//  Copyright (c) 2013 Christopher Zahka. All rights reserved.
//

#import "VCardsLanguageViewController.h"
#import "VCardsXmlParser.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface VCardsLanguageViewController ()

@property (nonatomic, retain) VCardsXmlParser* vCardsXmlParser;

@end

@implementation VCardsLanguageViewController

@synthesize languageSelected = _languageSelected;
@synthesize languageTextView = _languageTextView;
@synthesize imageView = _imageView;
@synthesize vCardsXmlParser = _vCardsXmlParser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction  target:self action:@selector(shareText)];
    _languageTextView.layoutManager.delegate = self;
}

- (void)setLanguageText
{
    // handle special case for language that uses an image instead of unicode
    if ([self.languageSelected isEqualToString:@"Cambodian (Khmer)"])
    {
        UIImage *image = [UIImage imageNamed: @"Khmer.png"];
        [self.imageView setImage:image];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else
    {
        
        NSString *text = [self.vCardsXmlParser getTranslation:self.languageSelected];
        
        

        self.languageTextView.text = text;

        self.languageTextView.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.languageTextView)
    {
        self.languageTextView = [[UITextView alloc] init];
    }
    
    if (!self.imageView)
    {
        self.imageView = [[UIImageView alloc] init];
    }
    
    if (!self.vCardsXmlParser)
    {
        self.vCardsXmlParser = [VCardsXmlParser sharedXmlParser];
    }
    
    [self setLanguageText];
    
    NSString *page = [@"Lang: " stringByAppendingString:self.languageSelected];
    
    id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
    [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
                           set:page forKey:kGAIScreenName] build]];

}

- (void)shareText
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    NSString* string =  self.languageTextView.text;
    if ([string length] > 0)
    {
        [sharingItems addObject:string];
    }
    else {
        if(self.imageView.image != nil)
        {
            [sharingItems addObject:self.imageView.image];
        }
        else
        {
            return;
        }

    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLanguageSelected:(NSString *)languageSelected
{
    _languageSelected = languageSelected;
    self.title = self.languageSelected;
}

#pragma -
#pragma NSLayoutManagerDelegate

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect
{
    return 5;
}


@end
