//
//  VCardsLanguageTableViewController.m
//  V-Cards
//
//  Created by Christopher Zahka on 6/1/13.
//  Copyright (c) 2013 Christopher Zahka. All rights reserved.
//

#import "VCardsLanguageTableViewController.h"
#import "VCardsXmlParser.h"

@interface VCardsLanguageTableViewController ()

@property (nonatomic, strong) NSArray * languages;
@property (nonatomic, strong) NSString * languageSelected;
@property (nonatomic, strong) NSMutableDictionary * sections;
@property (nonatomic, strong) VCardsXmlParser * vCardsXmlParser;

@end

@implementation VCardsLanguageTableViewController

@synthesize languages = _languages;
@synthesize languageSelected = _languageSelected;
@synthesize sections = _sections;
@synthesize vCardsXmlParser = _vCardsXmlParser;

- (void)setLanguages:(NSArray *)languages
{
    if (_languages != languages)
    {
        _languages = languages;
        [self.tableView reloadData];
    }
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableDictionary *) sections
{
    if (!_sections)
    {
        _sections = [[NSMutableDictionary alloc] init];
    }
    return _sections;
}

- (void)populateLanguagesAndSections
{

    if (!self.vCardsXmlParser)
    {
        self.vCardsXmlParser = [VCardsXmlParser sharedXmlParser];
        [self.vCardsXmlParser processXML];
    }
    
    self.languages = [self.vCardsXmlParser languageNameArray];
    
    BOOL found;
    
    // Loop through the languages and create our keys
    for (id currentLanguage in self.languages)
    {
        NSString *c = [currentLanguage substringToIndex:1];
        
        found = NO;
        
        for (NSString *str in [self.sections allKeys])
        {
            if ([str isEqualToString:c])
            {
                found = YES;
            }
        }
        
        if (!found)
        {
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
    
    // Loop again and sort the languages into their respective keys
    for (id currentLanguage in self.languages)
    {
        [[self.sections objectForKey:[currentLanguage substringToIndex:1]] addObject:currentLanguage];
    }

    // Sort each section array
    for (NSString *key in [self.sections allKeys])
    {        
        [[self.sections objectForKey:key] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    }
    
    [self.tableView reloadData];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self populateLanguagesAndSections];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.sections allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"languageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString * lang = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = lang;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLanguage"]) {
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];

        self.languageSelected = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:selectedIndexPath.section]] objectAtIndex:selectedIndexPath.row];
        
        [segue.destinationViewController setLanguageSelected:self.languageSelected];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

@end
