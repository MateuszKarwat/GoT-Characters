//
//  GoTWikiaManagableArticle.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import "GoTWikiaArticle.h"

@interface GoTWikiaManagableArticle : GoTWikiaArticle

@property (nonatomic, getter=isFavourite) BOOL favourite;
@property (nonatomic, getter=isExpanded) BOOL expanded;

- (instancetype)initWithArticle:(GoTWikiaArticle *)article;

@end
