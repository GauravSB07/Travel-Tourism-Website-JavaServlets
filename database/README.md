# Customized holidays setup

Open your existing hosted **travel_tourism** database in your SQL client, then copy and run the complete contents of **customized_holidays.sql**.

The same file works for a fresh holiday setup or the earlier festival tables: it adds the occasion column when missing and makes the legacy departure date optional. It preserves existing destination tables, bookings and festival rows. Legacy festival packages without an occasion no longer appear in the holiday listing. No new database is created. Configuration, DBConnection and Tomcat settings are not changed.

The script creates holiday_packages, holiday_itinerary and booking_requests if missing, and seeds four editable example offers: Birthday in Goa, Honeymoon in Kerala, Anniversary in Udaipur and Family Celebration in Jaipur. Sample prices and inclusions should be adjusted for your business. Re-running the seed preserves existing edits.

After running the SQL, deploy the updated application through your usual process.

## Visitor flow

Customized Holidays -> filter by occasion, departure city, duration or budget -> View Details -> review itinerary, inclusions, exclusions and price -> Book this holiday -> choose travel date, travellers and preferences -> submit booking request.

The booking date is flexible and cannot be in the past. Prices are loaded on the server. Requests use the existing shared booking flow and are saved as pending in booking_requests. No payment, inventory reservation or automatic email is performed.

## Checks after setup

- /customize lists four occasion packages.
- Honeymoon matches Kerala; a maximum budget of 15000 matches Goa.
- Duration 4 matches Udaipur and Jaipur; incompatible combined filters show a clear empty state.
- View Details opens the selected holiday, with every itinerary day and the correct inclusions.
- Book this holiday carries the package ID, name and price to booking.
- A future date remains editable. Past dates and invalid traveller counts are rejected.
- Submit preferences and verify the saved request and calculated total.
- Unknown or inactive detail IDs return an error; direct access to the JSP returns to the holiday list.
- Review mobile layout and keyboard navigation.

The SQL has not been executed against your hosted database by this task.
