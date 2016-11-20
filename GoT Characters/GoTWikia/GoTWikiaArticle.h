//
//  GoTWikiaArticle.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoTWikiaArticle : NSObject

@property (readonly) NSInteger identifier;
@property (readonly) NSString *title;
@property (readonly) NSString *abstract;
@property (readonly) NSString *thumbnailURL;
@property (readonly) NSString *relativeURL;
@property (readonly) NSURL *absoluteURL;

@property (nonatomic, getter=isFavourite) BOOL favourite;

- (id)initWithIdentifier:(NSInteger)identifier
                   title:(NSString *)title
                abstract:(NSString *)abstract
            thumbnailURL:(NSString *)thumbnailURL
             relativeURL:(NSString *)relativeURL;

@end
