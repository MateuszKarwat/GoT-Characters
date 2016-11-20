//
//  GoTWikiaArticle.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoTWikiaArticle : NSObject

@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *abstract;
@property (nonatomic) NSString *thumbnailURL;
@property (nonatomic) NSString *relativeURL;
@property (nonatomic, readonly) NSURL *absoluteURL;

- (instancetype)initWithIdentifier:(NSInteger)identifier;

@end
