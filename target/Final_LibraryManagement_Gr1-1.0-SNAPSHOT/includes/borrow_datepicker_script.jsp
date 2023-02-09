<script>
    // Created by Alex Winter
// Last Modified: 2022-05-31




// *****************************************************
//  Booking Form
//  Flatpickr.js, selected date logic, validation, etc.
// *****************************************************
// allows for multiple booking forms by setting the "bookingId" parameter
    const booking = (bookingId) => {
        // Get DOM elements
        const bookingForm = bookingId.querySelector('.booking');
        const bookingSubmit = bookingId.querySelector('.borrow-submit');
        const arrival = bookingId.querySelector('.arrival');
        const departure = bookingId.querySelector('.departure');
        // default input placeholders
        const arrivalPlaceholder = 'Borrow Date';
        const departurePlaceholder = 'Return Date';
        arrival.setAttribute('placeholder', arrivalPlaceholder);
        departure.setAttribute('placeholder', departurePlaceholder);

        // arrival flatpickr instance
        const arrivalFp = flatpickr(arrival, {
            defaultDate: 'today',
            minDate: 'today', // ensures user cannot select a date prior to today
            disableMobile: 'true', // disables native datepicker on mobile
            monthSelectorType: 'static', // disables 'month' dropdown from flatpickr's datepicker (hope they add yearSelectorType soon)
            altInput: true,
            altFormat: "d/m/Y",
            dateFormat: "Y-m-d",
            onReady: (a, b, fp) => {
                fp.altInput.setAttribute('aria-label', arrivalPlaceholder);
            }
        });

        // departure flatpickr instance
        const departureFp = flatpickr(departure, {
            defaultDate: [new Date().fp_incr(30), "07:00"],
            minDate: new Date().fp_incr(1), // ensures user cannot select a date prior to tomorrow
            disableMobile: 'true', // disables native datepicker on mobile
            monthSelectorType: 'static', // disables 'month' dropdown from flatpickr's datepicker (hope they add yearSelectorType soon)
            altInput: true,
            altFormat: "d/m/Y",
            dateFormat: "Y-m-d",
            onReady: (a, b, fp) => {
                fp.altInput.setAttribute('aria-label', departurePlaceholder);
            }
        });

        // add custom classes to the arrival and departure 'flatpickr-calendar' elements
        arrivalFp.calendarContainer.classList.add('arrival-calendar');
        departureFp.calendarContainer.classList.add('departure-calendar');

        // flatpickr's date values
        let arrivalDateChosen = arrivalFp.selectedDates;
        let departureDateChosen = departureFp.selectedDates;
        // js date objects
        let arrivalDateObj = new Date(arrivalDateChosen);
        let departureDateObj = new Date(departureDateChosen);

        // update flatpickr's date values
        const updateDates = () => {
            // flatpickr date values
            arrivalDateChosen = arrivalFp.selectedDates;
            departureDateChosen = departureFp.selectedDates;
            // js date objects
            arrivalDateObj = new Date(arrivalDateChosen);
            departureDateObj = new Date(departureDateChosen);
        };

        // run 'updateDates' function every time the user selects a new arrival or departure
        [arrival, departure].forEach((item) => {
            item.addEventListener('change', () => {
                updateDates();
            });
        });

        // amount of days to add or subtract
        const defaultDaySpan = 2;

        // add days to departure date
        const addDays = () => {
            departureDateObj = new Date(arrivalDateObj);
            departureDateObj.setDate(arrivalDateObj.getDate() + defaultDaySpan)
            departureFp.setDate(departureDateObj);
        };

        // subtract days from arrival date
        const subDays = () => {
            arrivalDateObj = new Date(departureDateObj);
            arrivalDateObj.setDate(departureDateObj.getDate() - defaultDaySpan)
            arrivalFp.setDate(arrivalDateObj);
        };

        // 86400000 milliseconds = 1 day
        let minimumDistance = 86400000;
        let dayDistance = 0;
        // get the distance between days as a number of milliseconds
        let getDayDistance = () => {
            dayDistance = departureDateObj - arrivalDateObj;
        };

        // user selects arrival date
        arrival.addEventListener('change', () => {
            getDayDistance();

            // if departure date is not selected yet - or -
            // if arrival date is SAME DAY or AFTER currently selected departure date
            if ((departureDateChosen.length == 0) || (departureDateChosen.length !== 0 && dayDistance < minimumDistance)) {
                addDays();
            }

            updateDates();
        });

        // user selects departure date
        departure.addEventListener('change', () => {
            getDayDistance();

            // if arrival date is not selected yet - or -
            // if departure date is SAME DAY or BEFORE currently selected arrival date
            if ((arrivalDateChosen.length == 0) || (arrivalDateChosen.length !== 0 && dayDistance < minimumDistance)) {
                subDays();
            }
            ;

            updateDates();
        });

        // validate the form when the submit button is clicked
        let errorMessageVisible = false; // prevents odd behaviour if user is button mashing

        // create 'booking-error' element and get DOM elements
        document.querySelector('body').insertAdjacentHTML('beforeend', '<div class="booking-error"><div class="booking-error-content"><p></p></div></div>');
        const error = document.querySelector('.booking-error');
        const errorText = document.querySelector('.booking-error p');

        // submit button is clicked
        bookingSubmit.addEventListener('click', (event) => {
            // show the error message for X seconds (if one isn't already shown)
            const errorMessage = (message) => {
                if (!errorMessageVisible) {
                    errorMessageVisible = true;

                    errorText.textContent = message;
                    error.classList.add('show');

                    setTimeout(function () {
                        errorMessageVisible = false;
                        error.classList.remove('show');
                    }, 4000)
                }
                ;

                event.preventDefault();
            }

            // validate: errors
            if (arrivalDateChosen.length == 0 && departureDateChosen.length == 0) {
                errorMessage('Please select an borrow and return date');
            } else if (arrivalDateChosen.length == 0) {
                errorMessage('Please select an borrow date');
            } else if (departureDateChosen.length == 0) {
                errorMessage('Please select a return date');
            }
            // validate: success
            else {
                // Google Analytics event tracking
                try {
                    gtag('event', 'click', {
                        'event_category': 'Booking',
                        'event_label': 'Booking Form Submit'
                    });
                } catch (err) {
                }




                // *****************************************************
                //  Split dates into separate variables
                //  Use only if needed
                // *****************************************************

                // regular expression that looks for YYYY-MM-DD
                const regex = /(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/;

                // match 'arrival' and 'departure' with 'regex'
                const regexArrival = arrival.value.match(regex);
                const regexDeparture = departure.value.match(regex);

                // split into separate variables
                const arrivalY = regexArrival.groups.year;
                const arrivalM = regexArrival.groups.month;
                const arrivalD = regexArrival.groups.day;
                const departureY = regexDeparture.groups.year;
                const departureM = regexDeparture.groups.month;
                const departureD = regexDeparture.groups.day;

                // testing
                /*
                 console.log('arrival: ' + arrival.value);
                 console.log('departure: ' + departure.value);
                 console.log('arrival year: ' + arrivalY);
                 console.log('arrival month: ' + arrivalM);
                 console.log('arrival day: ' + arrivalD);
                 console.log('departure year: ' + departureY);
                 console.log('departure month: ' + departureM);
                 console.log('departure day: ' + departureD);
                 */




                // *****************************************************
                //  IHG only!
                //  Comment out or delete as needed!
                // *****************************************************

                // IHG requires that the month value does not have a leading 0:
                const checkInDate = parseInt(arrivalD, 10);
                const checkOutDate = parseInt(departureD, 10);

                // IHG requires that the month value is zero-based:
                const checkInMonth = parseInt(arrivalM, 10) - 1;
                const checkOutMonth = parseInt(departureM, 10) - 1;

                // IHG requires the year value too of course
                const checkInYear = arrivalY;
                const checkOutYear = departureY;

                // IHG requires that we combine the month value and the year value together
                const checkInMonthYear = checkInMonth + checkInYear;
                const checkOutMonthYear = checkOutMonth + checkOutYear;

                // set the value for the 'checkInDate' input
                document.querySelector('input[name="checkInDate"]').setAttribute('value', checkInDate);

                // set the value for the 'checkOutDate' input
                document.querySelector('input[name="checkOutDate"]').setAttribute('value', checkOutDate);

                // set the value for the 'checkInMonthYear' input
                document.querySelector('input[name="checkInMonthYear"]').setAttribute('value', checkInMonthYear);

                // set the value for the 'checkInMonthYear' input
                document.querySelector('input[name="checkOutMonthYear"]').setAttribute('value', checkOutMonthYear);

                // testing
                /*
                 console.log('checkInDate: ' + checkInDate);
                 console.log('checkOutDate: ' + checkOutDate);
                 console.log('checkInMonth: ' + checkInMonth);
                 console.log('checkOutMonth: ' + checkOutMonth);
                 console.log('checkInYear: ' + checkInYear);
                 console.log('checkOutYear: ' + checkOutYear);
                 console.log('checkInMonthYear: ' + checkInMonthYear);
                 console.log('checkOutMonthYear: ' + checkOutMonthYear);
                 */




                // *****************************************************
                //  Submit the form!
                // *****************************************************

                event.preventDefault();
            }
            ;
        });
    };

// Default booking instance:
    let booking1 = document.getElementsByClassName("booking");
    console.log(booking1.length)
    for (var i = 0; i < booking1.length; i++) {
        booking(booking1.item(i));
    }

// Add additional booking instances if necessary:
    /*
     let booking2 = document.querySelector('#booking-2');
     booking(booking2);
     */
</script>