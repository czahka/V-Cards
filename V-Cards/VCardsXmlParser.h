//
//  VCardsXmlParser.h
//  V-Cards
//
//  Created by Christopher Zahka on 9/23/13.
//  Copyright (c) 2013 Christopher Zahka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCardsXmlParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *languageNameArray;

+(VCardsXmlParser *) sharedXmlParser;

-(void) processXML;
-(NSString*) getTranslation:(NSString*)selectedLanguage;

@end
