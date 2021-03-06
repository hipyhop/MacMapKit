/*
 *  MKGeometry.m
 *  MapKit
 *
 *  Created by Zach Drayer on 3/20/13.
 *
 */

#import "MKGeometry.h"

#import <tgmath.h>

#define MKEarthRadius 6396002.3421 // In meters. Approximation of the radius used by Apple. This gets us within 7 decimal points of precision in MKMetersBetweenMapPoints

extern MKMapPoint MKMapPointForCoordinate(CLLocationCoordinate2D coordinate)
{
	return MKMapPointMake(coordinate.latitude, coordinate.longitude);
}

extern CLLocationCoordinate2D MKCoordinateForMapPoint(MKMapPoint mapPoint)
{
	return CLLocationCoordinate2DMake(mapPoint.x, mapPoint.y);
}

// Haversine formula
extern CLLocationDistance MKMetersBetweenMapPoints(MKMapPoint pointA, MKMapPoint pointB)
{
	CLLocationDegrees differenceInLatitude = ((M_PI / 180) * (pointB.x - pointA.x)); // convert values to radians
	CLLocationDegrees differenceInLongitude = ((M_PI / 180) * (pointB.y - pointA.x));
	CLLocationDegrees firstLatitude = ((M_PI / 180) * pointA.x);
	CLLocationDegrees secondLatitude = ((M_PI / 180) * pointB.x);

	// a: Square of half the chord length between the points
	// c: Angular distance in radians
	CGFloat a = sin(differenceInLatitude / 2) * sin(differenceInLatitude / 2) + sin(differenceInLongitude / 2) * sin(differenceInLongitude / 2) * cos(firstLatitude) * cos(secondLatitude);
	CGFloat c = 2 * atan2(sqrt(a), sqrt(1 - a));
	return MKEarthRadius * c;
}

extern MKMapRect MKMapRectUnion(MKMapRect rect1, MKMapRect rect2){
  if(MKMapRectIsEmpty(rect2)){
    return rect1;
  }
  
  if(MKMapRectIsEmpty(rect1)){
    return rect2;
  }
  
  double min_x = fmin(rect1.origin.x, rect2.origin.x);
  double min_y = fmin(rect1.origin.y, rect2.origin.y);
  
  double max_x = fmax(rect1.origin.x, rect2.origin.x);
  double max_y = fmax(rect1.origin.y, rect2.origin.y);
  
  return MKMapRectMake(min_x, min_y, max_x - min_x, max_y - min_y);
}

extern MKCoordinateRegion MKCoordinateRegionForMapRect(MKMapRect rect){
  return MKCoordinateRegionMake(CLLocationCoordinate2DMake(rect.origin.x + (rect.size.width/2), rect.origin.y + (rect.size.height/2)), MKCoordinateSpanMake(rect.size.width/2, rect.size.height/2));
  
}


