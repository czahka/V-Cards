//
//  VCardsAboutViewController.m
//  V-Cards
//
//  Created by Christopher Zahka on 9/25/13.
//  Copyright (c) 2013 Christopher Zahka. All rights reserved.
//

#import "VCardsAboutViewController.h"

@interface VCardsAboutViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *aboutWebView;

@end

@implementation VCardsAboutViewController

@synthesize aboutWebView = _aboutWebView;

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
    
    if (!self.aboutWebView)
    {
        self.aboutWebView = [[UIWebView alloc] init];
        
    }
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"About" ofType:@"html" inDirectory:nil];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    //self.aboutWebView.scalesPageToFit = YES;
    [self.aboutWebView loadHTMLString:htmlString baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
