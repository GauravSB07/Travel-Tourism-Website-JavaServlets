# Admin panel

Open `/TravelTourism/admin/tours` for destinations or `/TravelTourism/admin/holidays` for customized holidays after publishing the updated application.

## Destinations
The existing AdminTourPanelServlet remains the destination editor. The panel includes a destination-card summary field and a link to the public details page. Inactive tours are excluded from public listings and booking selection. Itineraries continue to use tour_itinerary.

## Customized holidays
Create or select a package, set its occasion, departure city, duration, price, overview, inclusions and exclusions. Add exactly one itinerary description per travel day; arrow buttons reorder days. Save applies the package and itinerary in one transaction. Hidden packages are excluded from the public holiday catalogue. Older festival records without an occasion are marked Needs occasion. Package IDs remain fixed after creation.

This uses the existing holiday_packages and holiday_itinerary tables. Core package editing needs no migration. For main cover photos, run database/holiday_images.sql once in your existing hosted database. The application does not run this script automatically. Existing booking snapshots are unaffected by later package edits.

## Consolidation
Removed the duplicate TourAdminServlet, ManageTourImagesServlet, UploadTourImageServlet and DeleteTourImageServlet, plus their four obsolete JSPs. The working tour panel retains image upload, cover selection and deletion; TourImageServlet still serves public images. admin-tour-management.css now contains the active panel's extracted styles.

## Running and checks
Publish the updated application in Eclipse so the new servlet is loaded and the removed servlet classes are no longer deployed. No project, database connection or Tomcat configuration was changed.

Build: `mvn -o package`.
Database-free validation and rollback checks, after compilation:
`java -cp "target/test-classes;target/classes;<Tomcat>/lib/*" com.traveltourism.controller.AdminHolidayPanelChecks`.

Both admin pages include CSRF protection and escaped form values. The existing project has no administrator login/authorization mechanism; these changes do not add one. Access to admin routes must be restricted before public deployment.

## Main holiday image
After saving a holiday, use Main package image to upload or replace its cover (JPEG/PNG, up to 5 MB and 24 megapixels). The same photo appears on its public card and details page. Remove photo restores the illustrated placeholder. Photo saves are separate from package edits.
