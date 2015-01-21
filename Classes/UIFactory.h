//
//  UIFactory.h
//  iTicket
//
//  Created by Matteo Cortonesi on 21/8/08.
//  Copyright 2008 Ambra. All rights reserved.
//

/*
 
 The cell factory is used to create an instance of UITableViewCell by loading
 it from a specified nib file. The file must only contain a cell.
 
 To create a new cell use the newCellFromNib: class method. The name of the nib
 must be without extension.
 
 */

#import <UIKit/UIKit.h>


@interface UIFactory : NSObject {

}

+ (id)newUIObjectFromNib:(NSString *)nibName;

@end
