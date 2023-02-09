
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>

<style>
    .flatpickr-calendar {
        position: absolute;
        width: 100%;
        max-width: 316px;
        opacity: 0;
        display: none;
        visibility: hidden;
        padding: 0.25em;
        border: 0;
        text-align: center;
        direction: ltr;
        animation: none;
        box-sizing: border-box;
        touch-action: manipulation;
        background-color: #fff;
        box-shadow: 1px 0 0 #e6e6e6, -1px 0 0 #e6e6e6, 0 1px 0 #e6e6e6, 0 -1px 0 #e6e6e6, 0 3px 13px rgba(0, 0, 0, 0.08);
        user-select: none;
    }
    .flatpickr-calendar.open {
        opacity: 1;
        max-height: 640px;
        visibility: visible;
    }
    .flatpickr-calendar.open {
        display: inline-block;
        z-index: 100000001;
    }
    .flatpickr-calendar.animate.open {
        animation: fpFadeInDown 300ms cubic-bezier(0.23, 1, 0.32, 1);
    }
    @keyframes fpFadeInDown {
        from {
            opacity: 0;
            transform: translate3d(0, -20px, 0);
        }
        to {
            opacity: 1;
            transform: translate3d(0, 0, 0);
        }
    }
    .flatpickr-calendar:focus {
        outline: 0;
    }
    .flatpickr-months {
        position: relative;
    }
    .flatpickr-months .flatpickr-month {
        padding: 0.8em;
        position: relative;
        overflow: hidden;
        background-color: #edeaea;
        color: rgba(0, 0, 0, 0.9);
        user-select: none;
        text-align: center;
    }
    .flatpickr-months .flatpickr-prev-month, .flatpickr-months .flatpickr-next-month {
        position: absolute;
        top: 0;
        height: 100%;
        padding: 1em;
        z-index: 3;
        text-decoration: none;
        cursor: pointer;
        color: rgba(0, 0, 0, 0.9);
    }
    .flatpickr-months .flatpickr-prev-month.flatpickr-disabled, .flatpickr-months .flatpickr-next-month.flatpickr-disabled {
        display: none;
    }
    .flatpickr-months .flatpickr-prev-month i, .flatpickr-months .flatpickr-next-month i {
        position: relative;
    }
    .flatpickr-months .flatpickr-prev-month.flatpickr-prev-month, .flatpickr-months .flatpickr-next-month.flatpickr-prev-month {
        left: 0;
    }
    .flatpickr-months .flatpickr-prev-month.flatpickr-next-month, .flatpickr-months .flatpickr-next-month.flatpickr-next-month {
        right: 0;
    }
    .flatpickr-months .flatpickr-prev-month:hover svg, .flatpickr-months .flatpickr-next-month:hover svg {
        fill: #3f9338;
    }
    .flatpickr-months .flatpickr-prev-month svg, .flatpickr-months .flatpickr-next-month svg {
        width: 14px;
        height: 14px;
        vertical-align: bottom;
    }
    .flatpickr-months .flatpickr-prev-month svg path, .flatpickr-months .flatpickr-next-month svg path {
        transition: fill 0.1s;
        fill: inherit;
    }
    .flatpickr-current-month span.cur-month {
        display: inline-block;
    }
    .flatpickr-current-month .numInputWrapper {
        display: inline-block;
        width: 6ch;
    }
    .flatpickr-current-month .numInputWrapper span.arrowUp:after {
        border-bottom-color: rgba(0, 0, 0, 0.9);
    }
    .flatpickr-current-month .numInputWrapper span.arrowDown:after {
        border-top-color: rgba(0, 0, 0, 0.9);
    }
    .flatpickr-current-month input.cur-year {
        display: inline-block;
        margin: 0;
        background-color: transparent;
        box-sizing: border-box;
        cursor: text;
        padding: 0.5ch 0 0.5ch 0.5ch;
        border: 0;
        appearance: textfield;
    }
    .flatpickr-current-month input.cur-year:focus {
        outline: 0;
    }
    .flatpickr-current-month input.cur-year[disabled], .flatpickr-current-month input.cur-year[disabled]:hover {
        color: rgba(0, 0, 0, 0.5);
        background-color: transparent;
        pointer-events: none;
    }
    .numInputWrapper {
        position: relative;
        height: auto;
    }
    .numInputWrapper input, .numInputWrapper span {
        display: inline-block;
    }
    .numInputWrapper input {
        width: 100%;
    }
    .numInputWrapper input::-webkit-outer-spin-button, .numInputWrapper input::-webkit-inner-spin-button {
        margin: 0;
        -webkit-appearance: none;
    }
    .numInputWrapper span {
        position: absolute;
        right: 0;
        width: 14px;
        padding: 0 4px 0 2px;
        height: 50%;
        line-height: 50%;
        opacity: 0;
        cursor: pointer;
        border: 1px solid rgba(57, 57, 57, 0.15);
        box-sizing: border-box;
    }
    .numInputWrapper span:hover {
        background-color: rgba(0, 0, 0, 0.1);
    }
    .numInputWrapper span:active {
        background-color: rgba(0, 0, 0, 0.2);
    }
    .numInputWrapper span:after {
        display: block;
        content: "";
        position: absolute;
    }
    .numInputWrapper span.arrowUp {
        top: 0;
        border-bottom: 0;
    }
    .numInputWrapper span.arrowUp:after {
        border-left: 4px solid transparent;
        border-right: 4px solid transparent;
        border-bottom: 4px solid rgba(57, 57, 57, 0.6);
        top: 26%;
    }
    .numInputWrapper span.arrowDown {
        top: 50%;
    }
    .numInputWrapper span.arrowDown:after {
        border-left: 4px solid transparent;
        border-right: 4px solid transparent;
        border-top: 4px solid rgba(57, 57, 57, 0.6);
        top: 40%;
    }
    .numInputWrapper:hover {
        background-color: rgba(0, 0, 0, 0.05);
    }
    .numInputWrapper:hover span {
        opacity: 1;
    }
    .flatpickr-innerContainer {
        display: block;
        display: flex;
        box-sizing: border-box;
        overflow: hidden;
    }
    .flatpickr-rContainer {
        display: inline-block;
        padding: 0;
        box-sizing: border-box;
    }
    .flatpickr-weekdays {
        display: flex;
        align-items: center;
        width: 100%;
        padding: 0.9em 0;
        font-size: 0.9rem;
        background-color: transparent;
        overflow: hidden;
        text-align: center;
        user-select: none;
    }
    .flatpickr-weekdays .flatpickr-weekdaycontainer {
        display: flex;
        flex: 1;
    }
    span.flatpickr-weekday {
        cursor: default;
        background-color: transparent;
        color: #555;
        line-height: 1;
        margin: 0;
        text-align: center;
        display: block;
        flex: 1;
        font-weight: bolder;
    }
    .flatpickr-days {
        position: relative;
        overflow: hidden;
        display: flex;
        align-items: flex-start;
        width: 307.875px;
        user-select: none;
    }
    .flatpickr-days:focus {
        outline: 0;
    }
    .dayContainer {
        padding: 0;
        outline: 0;
        text-align: left;
        width: 307.875px;
        min-width: 307.875px;
        max-width: 307.875px;
        box-sizing: border-box;
        display: inline-block;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
        transform: translate3d(0px, 0px, 0px);
        opacity: 1;
    }
    .dayContainer + .dayContainer {
        box-shadow: -1px 0 0 #e6e6e6;
    }
    .flatpickr-day {
        background-color: #edeaea;
        border: 1px solid transparent;
        box-sizing: border-box;
        color: #393939;
        cursor: pointer;
        font-weight: 400;
        width: 14.2857143%;
        flex-basis: 14.2857143%;
        max-width: 39px;
        height: 39px;
        line-height: 39px;
        margin: 0 0 0.25em 0;
        display: inline-block;
        position: relative;
        justify-content: center;
        text-align: center;
    }
    .flatpickr-day:hover, .flatpickr-day.prevMonthDay:hover, .flatpickr-day.nextMonthDay:hover, .flatpickr-day:focus, .flatpickr-day.prevMonthDay:focus, .flatpickr-day.nextMonthDay:focus {
        cursor: pointer;
        outline: 0;
        color: #fff;
        background-color: #3f9338;
        border-color: #3f9338;
    }
    .flatpickr-day.today {
        border-color: #959ea9;
    }
    .flatpickr-day.today:hover, .flatpickr-day.today:focus {
        border-color: #959ea9;
        background-color: #959ea9;
        color: #fff;
    }
    .flatpickr-day.selected, .flatpickr-day.selected:focus, .flatpickr-day.selected:hover, .flatpickr-day.selected.prevMonthDay, .flatpickr-day.selected.nextMonthDay {
        box-shadow: none;
        color: #fff;
        background-color: #3f9338;
        border-color: #3f9338;
    }
    .flatpickr-day.flatpickr-disabled, .flatpickr-day.flatpickr-disabled:hover, .flatpickr-day.prevMonthDay, .flatpickr-day.nextMonthDay, .flatpickr-day.notAllowed, .flatpickr-day.notAllowed.prevMonthDay, .flatpickr-day.notAllowed.nextMonthDay {
        color: rgba(57, 57, 57, 0.3);
        background-color: transparent;
        border-color: transparent;
        cursor: default;
    }
    .flatpickr-day.flatpickr-disabled, .flatpickr-day.flatpickr-disabled:hover {
        cursor: not-allowed;
        background-color: #f8f7f7;
        color: rgba(57, 57, 57, 0.2);
    }
    .flatpickr-day.hidden {
        visibility: hidden;
    }
    .flatpickr-input[readonly] {
        cursor: pointer;
    }
    .header-booking {

    }
    .booking {
        padding: 20px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        gap: 1.25em;
        flex-wrap: wrap;
    }
    @media (max-width: 1600px) {
        .booking {
            gap: 0.25em;
        }
    }
    .booking-input.date, .booking-input.select {
        width: 100%;
        max-width: 135px;
        display: flex;
        align-items: center;
        column-gap: 0.5em;
    }
    .booking-input input[type='text'], .booking-input input[type='date'], .booking-input select, .booking-input button {
        width: 100%;
        cursor: pointer;
        border-radius: 3px;
    }
    .booking-input input[type='text'], .booking-input input[type='date'], .booking-input select {
        max-width: 105px;
        color: #525252;
        font-size: 0.9rem;
        font-weight: 400;
        padding: 0.5em;
        background-color: #fff;
        border: 1px solid c4c4c4;
        box-shadow: inset 1px 1px 3px c4c4c4;
    }
    @media (max-width: 1600px) {
        .booking-input input[type='text'], .booking-input input[type='date'], .booking-input select {
            max-width: 95px;
        }
    }
    .booking-input input[type='text']::placeholder, .booking-input input[type='date']::placeholder {
        color: #525252;
    }
    .booking-input input[type='text']:hover, .booking-input input[type='date']:hover, .booking-input select:hover {
        border-color: #c9c9c9;
    }
    .booking-input input[type='date']:after {
        content: '\f3cf';
        font-family: 'FA-Solid';
    }
    .booking-input select {
        -webkit-appearance: none;
    }
    .booking-input button {
        display: inline-block;
        padding-block: 0.7em;
        padding-inline: 2.5em;
        line-height: 1;
        background-color: #3f9338;
        border: 2px solid #3f9338;
        border-radius: 0.25em;
        color: #fff;
        font-size: 1.1rem;
        font-weight: 700;
        font-style: normal;
        text-align: center;
        text-decoration: none;
        text-transform: uppercase;
        transition: all 0.5s;
    }
    @media (max-width: 1600px) {
        .booking-input button {
            padding-inline: 1.5em;
        }
    }
    .booking-input i {
        color: #525252;
        font-size: 1.35rem;
    }
    .booking-error {
        display: block;
        width: 100%;
    }
    .booking-error-content {
        position: relative;
        padding: 0.65em 3em;
        margin: 0 auto;
        text-align: center;
    }
    .booking-error-content p {
        font-size: 1.2rem;
        line-height: 1.4rem;
        font-weight: 400;
        color: #fff;
    }
    .booking-error {
        width: 100%;
        max-width: 420px;
        margin: 0 auto;
        z-index: -1;
        background-color: red;
        opacity: 0;
        margin-top: 1em;
        transition: all 1s;
    }
    .booking-error.show {
        opacity: 1;
        z-index: 30000;
    }
    .booking-error p {
        color: #fff;
        margin-bottom: 0;
    }
    .booking-error-content p {
        margin: 0;
    }
    .input {
        margin: 0;
        min-width: 150px;
    }

    .flatpickr-month {
        box-sizing:  content-box;
    }

</style>