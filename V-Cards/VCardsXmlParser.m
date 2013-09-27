//
//  VCardsXmlParser.m
//  V-Cards
//
//  Created by Christopher Zahka on 9/23/13.
//  Copyright (c) 2013 Christopher Zahka. All rights reserved.
//

#import "VCardsXmlParser.h"

@interface VCardsXmlParser()
@property NSMutableString *currentXMLValue;
@property NSMutableArray *objects;
@property NSString *name;
@property NSString *text;
@property (nonatomic, strong) NSMutableDictionary * languageDictionary;
@end

@implementation VCardsXmlParser
    
@synthesize currentXMLValue = _currentXMLValue;
@synthesize objects = _objects;
@synthesize name = _name;
@synthesize text = _text;
@synthesize languageDictionary = _languageDictionary;
@synthesize languageNameArray = _languageNameArray;

static VCardsXmlParser *sharedParser = nil;    // static instance variable

+ (VCardsXmlParser *)sharedXmlParser {
    if (sharedParser == nil) {
        sharedParser = [[super allocWithZone:NULL] init];
    }
    return sharedParser;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}

- (void)customMethod {
    // implement your custom code here
}

// singleton methods
+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedXmlParser];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}


-(void) processXML
{
    NSURL *resourceURLString = [[NSBundle mainBundle] resourceURL];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@Languages.xml",resourceURLString]];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    if (!self.languageDictionary)
    {
        self.languageDictionary = [[NSMutableDictionary alloc] init];
    }
    
    if (!self.languageNameArray)
    {
        self.languageNameArray = [[NSMutableArray alloc] init];
    }
    
    self.objects = [[NSMutableArray alloc] init];
    self.name = [[NSString alloc] init];
    self.text = [[NSString alloc] init];
    [xmlParser setDelegate: self];
    Boolean status = [xmlParser parse];
    
    NSError * statusError = [[NSError alloc] init];
    if (status == NO)
    {
        statusError = [xmlParser parserError];
    }
}
    
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //each time part of string is found append it to current string
    [self.currentXMLValue appendString:string];
}
    
//here you can check when <object> appears in xml and create this object
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
attributes: (NSDictionary *)attributeDict
{
    //each time new element is found reset string
    self.currentXMLValue = [[NSMutableString alloc] init];
    if( [elementName isEqualToString:@"language"])
    {
        self.name = [[NSString alloc] init];
    }
}

//this is triggered when there is closing tag </object>, </alias> and so on. Use it to set object's properties. If you get </object> - add object to array.
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

    if ([elementName isEqualToString:@"name"]) {

        NSString *trimmedString = [self.currentXMLValue stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.name = trimmedString;
        [self.languageNameArray addObject:self.name];
    }
    else if ([elementName isEqualToString:@"text"]) {

        // trim white spaces and newline characters from the front and rear of the string
        NSString *trimmedString = [self.currentXMLValue stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // replace two spaces ("  ") with one space (" ")
        while ([trimmedString rangeOfString:@"  "].location != NSNotFound) {
            trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"  " withString:@" "];
        }
        
        // replace tabs with no spaces
        trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"\t" withString:@""];

        self.text = trimmedString;
        [self.languageDictionary setValue:self.text
                                   forKey:self.name];
    }
        //and so on
}

-(NSString*) getTranslation:(NSString*)selectedLanguage
{
    return [self.languageDictionary valueForKey:selectedLanguage];
}
@end
