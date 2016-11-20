//
//  ArticleDetailsViewController.h
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoTWikiaArticle.h"

@interface ArticleDetailsViewController : UIViewController

/**
 An article which will be displayed when a view appears.
 */
@property GoTWikiaArticle *article;

@end
