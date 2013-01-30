//
//  RootViewController.m
//  
//
//  Created by Wada Kenji on 11/07/18.
//  Copyright 2011 Softbuild. All rights reserved.
//

#import "RootViewController.h"
#import "ScrollAlertView.h"

@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString* path = [[NSBundle mainBundle] pathForResource:@"CellItems" ofType:@"plist"];  
	NSArray* cells = [NSArray arrayWithContentsOfFile:path];
    return [cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSString* path = [[NSBundle mainBundle] pathForResource:@"CellItems" ofType:@"plist"];  
	NSArray* cells = [NSArray arrayWithContentsOfFile:path];
	cell.textLabel.text = [NSString stringWithFormat:@"%d %@", indexPath.row, [cells objectAtIndex:indexPath.row]];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if (indexPath.row < 2) {
		ScrollAlertView* alert = [[ScrollAlertView alloc] initWithTitle:@"アラートのテスト" 
																message:cell.textLabel.text
															   delegate:nil 
													  cancelButtonTitle:@"キャンセル" 
													  otherButtonTitles:@"ボタンその１",nil];
		[alert show];
		[alert release];
	} else {
		ScrollAlertView* alert = [[ScrollAlertView alloc] initWithTitle:@"アラートのテスト" 
																message:cell.textLabel.text
															   delegate:nil 
													  cancelButtonTitle:@"キャンセル" 
													  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end

