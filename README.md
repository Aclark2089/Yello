# Project 3 - *Yello*

**Yello** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **7** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Table rows for search results should be dynamic height according to the content height.
- [x] Custom cells should have the proper Auto Layout constraints.
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).


The following **optional** features are implemented:

- [ ] Search results page
   - [x] Infinite scroll for restaurant results.
   - [ ] Implement map view of restaurant results.
- [ ] Implement the restaurant detail page.

The following **additional** features are implemented:

- [x] Setup search bar cancel features extension functions

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Best way to implement the detail view, could not get the Business object to cooperate and would always crash my simulator even when using conditional unwraps and didSet method. Even when breakpointing the build and stepping through, the object appeared to always have been correctly passed but would break as soon as it unwrapped.
2. How to implement the map view, the method given in the assignment overview did not appear to be either up to date or correct.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![User Story Walkthrough](https://cloud.githubusercontent.com/assets/6467543/12709030/8437e5de-c875-11e5-9b12-b0ac97cba8c5.gif)

## Notes

Most of the challenges for this application came from the segue. For some reason no matter how I sent the Business object over through the segue into the detail view the information would not show. It would constantly say that it was nil when the debugger clearly showed that it was not. I tested it with other statements such as printing out the values I wanted to assign to the text labels and they all correctly printed. I could not figure out what the problem was and all of the methods we have gone over so far in class did not work.

* * *

### Basic Yelp client

This is a headless example of how to implement an OAuth 1.0a Yelp API client. The Yelp API provides an application token that allows applications to make unauthenticated requests to their search API.

### Next steps

- Check out `BusinessesViewController.swift` to see how to use the `Business` model.

### Sample request

**Basic search with query**

```
Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
    self.businesses = businesses

    for business in businesses {
        print(business.name!)
        print(business.address!)
    }
})
```

**Advanced search with categories, sort, and deal filters**

```
Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in

    for business in businesses {
        print(business.name!)
        print(business.address!)
    }
}
```
