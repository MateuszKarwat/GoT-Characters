//
//  ArticlesTableViewController.m
//  GoT Characters
//
//  Created by Mateusz Karwat on 20/11/2016.
//  Copyright © 2016 Mateusz Karwat. All rights reserved.
//

#import <WebImage/UIImageView+WebCache.h>
#import "ArticlesTableViewController.h"
#import "ArticleTableViewCell.h"
#import "GoTWikiaArticle.h"
#import "GoTWikiaFetcher.h"
#import "FavouriteArticlesManager.h"
#import "ArticleDetailsViewController.h"

// Segue
NSString *  const kShowArticleDetailsSegue           = @"ShowArticleDetailsSegue";

// Article Fetcher
NSString *  const kMostViewedArticlesDefaultCategory = @"Characters";
NSUInteger  const kMostViewedArticlesDefaultLimit    = 75;

// Interface
CGFloat     const kFilterFavouriteArticlesButtonSize = 30.f;

@interface ArticlesTableViewController () <ArticleTableViewCellDelegate>
@property (weak, nonatomic) UIButton *filterFavouriteArticlesButton;

@property NSArray *mostViewedArticles;
@property NSArray *favouriteArticles;
@property FavouriteArticlesManager *favouriteArticlesManager;
@property BOOL showOnlyFavouriteArticles;
@end

@implementation ArticlesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refetchMostViewedArticles) forControlEvents:UIControlEventValueChanged];

    self.favouriteArticlesManager = [[FavouriteArticlesManager alloc] init];

    self.showOnlyFavouriteArticles = NO;
    [self createFilterFavouriteArticlesButton];

    [self refetchMostViewedArticles];
}


// Tries to fetch new articles using GoTWikiaFetcher and handle refresh indicator.
- (void)refetchMostViewedArticles
{
    [self.refreshControl beginRefreshing];

    GoTWikiaFetcher *fetcher = [[GoTWikiaFetcher alloc] init];
    [fetcher fetchMostViewedArticlesFromCategory:kMostViewedArticlesDefaultCategory withLimit:kMostViewedArticlesDefaultLimit completionHandler:^(NSArray *fetchedArticles) {
        if (fetchedArticles != nil) {
            self.mostViewedArticles = fetchedArticles;
            [self reloadFavouriteArticles];
        }

        [self.refreshControl endRefreshing];
    }];
}

// Updates array of favourite articles and favourite state of the article iteself.
- (void)reloadFavouriteArticles
{
    NSMutableArray *newFavouriteArticles = [[NSMutableArray alloc] init];

    for (GoTWikiaArticle *article in self.mostViewedArticles) {
        if ([self.favouriteArticlesManager isArticleAddedToFavourites:article]) {
            article.favourite = [self.favouriteArticlesManager isArticleAddedToFavourites:article];
            [newFavouriteArticles addObject:article];
        }
    }

    self.favouriteArticles = [newFavouriteArticles copy];

    [self.tableView reloadData];
}

// Returns an article which should be displayed at given 'indexPath' based on an information
// if favourites filter is enabled.
- (GoTWikiaArticle *)articleForCurrentFavouriteFilterStatusWithIndexPath:(NSIndexPath *)indexPath
{
    return self.showOnlyFavouriteArticles ? self.favouriteArticles[indexPath.row] : self.mostViewedArticles[indexPath.row];
}

#pragma mark - User Interface

// Creates a custom navigation bar item to enable/disable favourite filter.
- (void)createFilterFavouriteArticlesButton
{
    UIButton *filterFavouriteArticlesButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kFilterFavouriteArticlesButtonSize, kFilterFavouriteArticlesButtonSize)];
    [filterFavouriteArticlesButton addTarget:self action:@selector(filterFavouriteArticlesButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [filterFavouriteArticlesButton setBackgroundImage:[UIImage imageNamed:@"FavouriteButtonNotSelected"] forState:UIControlStateNormal];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterFavouriteArticlesButton];
    [self.navigationItem setRightBarButtonItem:barButtonItem];

    self.filterFavouriteArticlesButton = filterFavouriteArticlesButton;
}

- (void)filterFavouriteArticlesButtonTapped:(UIButton *)sender
{
    self.showOnlyFavouriteArticles = !self.showOnlyFavouriteArticles;

    UIImage *image = [UIImage imageNamed:self.showOnlyFavouriteArticles ? @"FavouriteButtonNotSelectedCrossed" : @"FavouriteButtonNotSelected"];
    [self.filterFavouriteArticlesButton setBackgroundImage:image forState:UIControlStateNormal];

    [self.tableView reloadData];

    if ([self.tableView numberOfRowsInSection:0]) {
        NSIndexPath *firstRowIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

#pragma mark - ArticleTableViewCell Delegate

- (void)didTapFavouriteStatusButton:(id)sender
{
    if ([sender isKindOfClass:[ArticleTableViewCell class]]) {
        ArticleTableViewCell *cell = (ArticleTableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

        GoTWikiaArticle *article = [self articleForCurrentFavouriteFilterStatusWithIndexPath:indexPath];
        article.favourite = !article.favourite;

        UIImage *newStatusImage = nil;

        if (article.isFavourite) {
            [self.favouriteArticlesManager addArticleToFavourites:article];
            newStatusImage = [UIImage imageNamed:@"FavouriteButtonSelected"];
        } else {
            [self.favouriteArticlesManager removeArticleFromFavourites:article];
            newStatusImage = [UIImage imageNamed:@"FavouriteButtonNotSelected"];
        }

        [cell.favouriteStatusButton setImage:newStatusImage forState:UIControlStateNormal];

        [self reloadFavouriteArticles];
    }
}

- (void)didLongPressOnAbstractLabel:(id)sender
{
    if ([sender isKindOfClass:[ArticleTableViewCell class]]) {
        ArticleTableViewCell *cell = (ArticleTableViewCell *)sender;
        cell.abstractLabel.numberOfLines = cell.abstractLabel.numberOfLines ? 0 : 2;

        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showOnlyFavouriteArticles ? self.favouriteArticles.count : self.mostViewedArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleTableViewCellReusableIdentifier forIndexPath:indexPath];
    GoTWikiaArticle *article = [self articleForCurrentFavouriteFilterStatusWithIndexPath:indexPath];

    cell.titleLabel.text = article.title;
    cell.abstractLabel.text = article.abstract;
    [cell.favouriteStatusButton setImage:[UIImage imageNamed:article.isFavourite ? @"FavouriteButtonSelected" : @"FavouriteButtonNotSelected"]
                                forState:UIControlStateNormal];
    [cell.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL]
                           placeholderImage:[UIImage imageNamed:@"CharacterImagePlaceholder"]];

    cell.delegate = self;

    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[ArticleTableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:kShowArticleDetailsSegue] &&
                [segue.destinationViewController isKindOfClass:[ArticleDetailsViewController class]]) {
                    ArticleDetailsViewController *advc = segue.destinationViewController;
                    advc.article = [self articleForCurrentFavouriteFilterStatusWithIndexPath:indexPath];
            }
        }
    }
}

@end
