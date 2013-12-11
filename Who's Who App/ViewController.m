//
//  ViewController.m
//  Who's Who App
//
//  Created by Richard Mills on 10/12/2013.
//  Copyright (c) 2013 Richard Mills. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "StartView.h"
#import "WhosTableCell.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray * namesArray;
    NSMutableArray * descriptionArray;
    NSMutableArray * titleArray;
    NSMutableArray * imageArray;
    StartView * _startView;
    UIButton * refresh;
    UIActivityIndicatorView *activityIndicator;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    namesArray = [[NSMutableArray alloc]init];
    descriptionArray = [[NSMutableArray alloc]init];
    titleArray = [[NSMutableArray alloc]init];
    imageArray = [[NSMutableArray alloc]init];
    
    _startView = [[StartView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width , self.view.bounds.size.height)];
    _startView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_startView];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [_startView beginAnimation];
    [self loadImage];
    [self loadNames];
    [self loadUserDescription];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.tableView registerClass:[WhosTableCell class] forCellReuseIdentifier:@"cell"];
    
    UIView * navBar = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 64)];
    navBar.backgroundColor = [UIColor whiteColor];
    navBar.alpha =0.6;
    CALayer *iconlayer = navBar.layer;
    iconlayer.shadowOffset = CGSizeMake(-2.0, 2.0);
    iconlayer.shadowRadius = 3.0;
    iconlayer.shadowOpacity = 0.2;
    [self.view addSubview:navBar];
    
    refresh= [UIButton buttonWithType:UIButtonTypeCustom];
    [refresh addTarget:self action:@selector(refreshData)forControlEvents:UIControlEventTouchDown];
    [refresh setImage:[UIImage imageNamed: @"refresh.png"] forState:UIControlStateNormal];
    [refresh setBackgroundColor:[UIColor clearColor]];
    refresh.frame = CGRectMake(self.view.frame.size.width - 40,33,28, 24);
    refresh.alpha = 0.0;
    [self.view addSubview:refresh];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.alpha = 0.0;
    activityIndicator.center = CGPointMake(25, 42);
    activityIndicator.hidesWhenStopped = NO;
    [self.view addSubview:activityIndicator];

}

-(void)refreshData{
    [self loadImage];
    [self loadNames];
    [self loadUserDescription];
    activityIndicator.alpha = 1.0;
    [activityIndicator startAnimating];
}

#pragma mark - LoadData

-(void)loadNames {
    
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
          NSURL *Url = [NSURL URLWithString:@"http://www.theappbusiness.com/our-team/"];
          NSData *HtmlData = [NSData dataWithContentsOfURL:Url];
          TFHpple *Parser = [TFHpple hppleWithHTMLData:HtmlData];
          NSString *XpathQueryString = @"//div[@class='col col2']/h3";
          NSArray *Nodes = [Parser searchWithXPathQuery:XpathQueryString];
          for (TFHppleElement *element in Nodes) {
            [namesArray addObject:[[element firstChild] content]];
          }
     NSLog(@" Name : %@", namesArray);
      });
}

-(void)loadUserDescription {
    
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
            NSURL *Url = [NSURL URLWithString:@"http://www.theappbusiness.com/our-team/"];
            NSData *HtmlData = [NSData dataWithContentsOfURL:Url];
            TFHpple *Parser = [TFHpple hppleWithHTMLData:HtmlData];
            NSString *XpathQueryString = @"//div[@class='col col2']/p[@class='user-description']";
            NSArray *Nodes = [Parser searchWithXPathQuery:XpathQueryString];
            for (TFHppleElement *element in Nodes) {
                [descriptionArray addObject:[[element firstChild] content]];
            }
      
    NSLog(@"  Job Description : %@", descriptionArray);
    [self loadJobTitle];
    });
}

-(void)loadJobTitle {
    
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
    NSURL *Url = [NSURL URLWithString:@"http://www.theappbusiness.com/our-team/"];
    NSData *HtmlData = [NSData dataWithContentsOfURL:Url];
    TFHpple *Parser = [TFHpple hppleWithHTMLData:HtmlData];
    NSString *XpathQueryString = @"//div[@class='col col2']/p";
    NSArray *Nodes = [Parser searchWithXPathQuery:XpathQueryString];
    for (TFHppleElement *element in Nodes) {
        NSString * s = [[element firstChild] content];
        BOOL isTheObjectThere = [descriptionArray containsObject:s];
        if (isTheObjectThere == NO){
            [titleArray addObject:[[element firstChild] content]];
        }
    }
    NSLog(@" Job Title : %@", titleArray);
     });
}

-(void)loadImage{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
    NSURL *Url = [NSURL URLWithString:@"http://www.theappbusiness.com/our-team/"];
    NSData *HtmlData = [NSData dataWithContentsOfURL:Url];
    TFHpple *Parser = [TFHpple hppleWithHTMLData:HtmlData];
    NSString *XpathQueryString = @"//div[@class='title']/img";
    NSArray *Nodes = [Parser searchWithXPathQuery:XpathQueryString];
    for (TFHppleElement *element in Nodes) {
        NSString * s =[element objectForKey:@"src"];
        NSData *data = [NSData dataWithContentsOfURL :[NSURL URLWithString: s]];
        UIImage *i = [UIImage imageWithData: data];
        [imageArray addObject:i];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@" Job Image : %@", imageArray);
    [self updateHasFinished];
        });
    });
}

-(void)updateHasFinished{
    [self.tableView reloadData];
    [UIView animateWithDuration:2.0 animations:^{
        _startView.alpha = 0.0;
        refresh.alpha = 1.0;
        activityIndicator.alpha = 0.0;
        [activityIndicator stopAnimating];
    }];
}

#pragma mark - UITableViewDataDelegate protocol methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return namesArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell";
    WhosTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setImage:[imageArray objectAtIndex:[indexPath row]]];
    [cell setUserName:[namesArray objectAtIndex:[indexPath row]]];
    [cell setTitle:[titleArray objectAtIndex:[indexPath row]]];
    [cell setDetail:[descriptionArray objectAtIndex:[indexPath row]]];
    cell.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:227.0/255.0 blue:227.0/255.0 alpha:1.0];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WhosTableCell height];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
