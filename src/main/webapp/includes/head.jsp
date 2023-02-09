<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer"
      />



<style>
    * {
        margin: 0;
        font-family: sans-serif;
        padding: 0;
        text-decoration: none;
        box-sizing: border-box;
        list-style: none;
    }

    body {
        /* overflow-x: hidden; */
        width: 100%;
        background-color: white;
        box-sizing: border-box;

        height: 100vh;
        margin:0;
        display:flex;
        flex-direction:column;
    }

    main {
        flex:1;
    }

    .navbar {
        line-height: normal;
        padding: 0 0;
    }
    .stop-scroll {
        overflow: hidden;
    }

    .first {
        width: 100%;
        height: 70px;
        background-color: #131A22;
        display: flex;
        align-items: center;
        flex-direction: column;
    }

    .first img {
        width: 130px;
        margin-left: 10px;
        margin-right: 10px;
        padding: 5px 10px;
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .first {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }

    .flex {
        display: flex;
        justify-content: center;
    }

    .flex span,
    i {
        color: white;
    }

    .logo {
        flex: 0.18;
        margin-right: 10px;
        justify-content: space-between;
    }

    .map {
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .map i {
        margin-top: 17px;
        padding-left: 5px;
        font-size: 17px;
    }

    .map div {
        padding: 5px 5px;
        display: flex;
        cursor: pointer;
        flex-direction: column;
    }

    .map div span:first-child {
        font-weight: 400;
        font-size: 13px;
    }

    .map div span {
        font-weight: bold;
    }

    .right {
        justify-content: space-between;
        flex: 0.29;
        margin-right: 10px;
        align-items: center;
    }

    .input {
        width: 100%;
        background-color: white;
        flex: 0.53;
        border-radius: 5px;
        display: flex;
        margin: 0 10px;
        align-items: center;
        overflow: hidden;
        justify-content: space-between;
        min-width: 200px;
    }

    .input input {
        outline: none;
        width: 80%;
        font-size: 16px;
        padding: 10px 2px;
        border: none;
    }

    .input .fa-search {
        color: rgb(51, 51, 51);
        padding: 10px 15px;
        font-size: 20px;
        background-color: #588970;
        border-radius: 0 5px 5px 0;
    }

    .input div {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        border-right: 1px solid gray;
        background-color: rgb(236, 234, 234);
        padding: 6px 0;
    }

    .input div span {
        border-radius: 5px 0 0 5px;
        color: rgb(51, 51, 51);
        padding: 6px 5px;
        padding-left: 10px;
        font-size: 13px;
        cursor: pointer;
    }

    .input .fa-caret-down {
        color: rgb(51, 51, 51);
        cursor: pointer;
        padding: 5px;
    }

    .lang i {
        padding: 0;
        margin: 0;
        color: gray;
    }

    .lang {
        padding: 5px;
        display: flex;
        justify-content: center;
        align-items: flex-end;
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .right img {
        width: 30px;
        height: 30px;
        padding: 4px;
        margin: 0;
        padding-top: 10px;
        cursor: pointer;
    }

    .sign {
        display: flex;
        flex-direction: column;
        padding: 3px 6px;
        cursor: pointer;
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .sign span:first-child {
        font-weight: 400;
        font-size: 13px;
    }

    .sign span {
        display: inline-block;
        width: 100%;
        font-weight: bold;
    }

    .flex .ac span {
        font-size: 15px;
        margin-right: 5px;
        font-weight: bold;
    }

    .fa-list-ul {
        font-size: 30px;
    }

    .ca {
        font-size: 14px;
        font-weight: bold;
    }

    .cart {
        align-items: flex-end;
        position: relative;
        padding: 5px 10px;
        cursor: pointer;
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .cart p {
        position: absolute;
        font-weight: bolder;
        color: white;
        top: 5px;
        left: 23px;
    }

    .cart:hover {
        border: 1px solid white;
        border-radius: 2px;
    }

    .logo img:hover {
        border: 1px solid white;
        border-radius: 2px;
    }

    .map:hover {
        border: 1px solid white;
        border-radius: 2px;
    }

    .lang:hover {
        border: 1px solid white;
        border-radius: 2px;
    }

    .sign:hover {
        border: 1px solid white;
        border-radius: 2px;
    }

    .input .fa-search:hover {
    }

    .input div:hover {
        background-color: rgb(204, 202, 202);
        color: black;
    }

    .second {
        width: 100%;
        height: 42px;
        background-color: #232f3e;
        display: flex;
        align-items: center;
        color: white;
        overflow: hidden;
    }

    .second ul {
        align-items: center;
        list-style: none;
        display: flex;
        justify-content: flex-start;
    }

    .second span {
        font-size: 15px;
    }

    .second-1 div i {
        font-size: 20px;
        cursor: pointer;
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .second li {
        padding: 5px 10px;
        font-size: 15px;
        margin: 7px 0;
        cursor: pointer;
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .second-1 {
        flex: 0.06;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .second-1 div {
        display: flex;
        align-items: center;
        padding-left: 5px;
    }

    .second-2 {
        display: flex;
        flex: 0.74;
        justify-content: flex-start;
    }

    .second-3 {
        flex: 0.2;
        display: flex;
        justify-content: flex-end;
        margin-right: 20px;
        overflow: hidden;
    }

    .second-1 div span {
        padding: 5px;
        cursor: pointer;
    }

    .second-3 span {
        padding: 5px 10px;
        cursor: pointer;
        border: 1px solid transparent;
        border-radius: 3px;
    }

    .second-1 div:hover {
        border: 1px solid white;
    }

    .second-2 li:hover {
        border: 1px solid white;
    }

    .second-3 span:hover {
        border: 1px solid white;
    }

    .sec-1 {
        position: relative;
        width: 100%;
        height: 1190px;
        box-sizing: border-box;
    }

    .slide img {
        width: 100vw;
        height: 100%;
    }

    .container {
        position: relative;
        /* overflow-x: hidden; */
        width: 100%;
        height: auto;
    }

    .button div {
        height: 100%;
        width: 80px;
    }

    .button {
        position: absolute;
        height: 230px;
        width: 100%;
    }

    .next {
        position: absolute;
        right: 0;
    }

    .next i {
        position: absolute;
        top: 35%;
        right: 25%;
        color: transparent;
        font-size: 50px;
        cursor: pointer;
    }

    .prev {
        position: absolute;
        left: 0;
    }

    .prev i {
        position: absolute;
        top: 35%;
        left: 25%;
        color: transparent;
        font-size: 50px;
        cursor: pointer;
    }

    @keyframes carousel {
        0% {
            left: 0px;
        }
        20% {
            left: 0px;
        }
        24% {
            left: -1360px;
        }
        42% {
            left: -1360px;
        }
        46% {
            left: calc(-1360*2px);
        }
        62% {
            left: calc(-1360*2px);
        }
        66% {
            left: calc(-1360*3px);
        }
        82% {
            left: calc(-1360*3px);
        }
        86% {
            left: calc(-1360*4px);
        }
        100% {
            left: calc(-1360*4px);
        }
    }

    .slider {
        /* overflow: hidden; */
        width: 100%;
        overflow: hidden;
        position: relative;
        height: 560px;
    }

    .image-box {
        display: flex;
        position: absolute;
        animation: carousel 15s alternate infinite;
    }

    .container-1 {
        position: absolute;
        z-index: 1;
        top: 230px;
        left: 0;
        width: 100%;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        background: linear-gradient( to bottom, transparent, #eaeded 30%);
    }

    .container-1 .para {
        background-color: rgb(238, 234, 234);
        width: 100%;
        text-align: center;
    }

    .container-1 div:first-child p {
        font-size: 14px;
        padding: 12px 0;
    }

    .product-comp {
        width: 100%;
        height: 100%;
        display: flex;
        box-sizing: border-box;
        margin: 20px 0;
        justify-content: space-around;
    }

    .product-comp .box {
        width: 315px;
        height: 400px;
        background-color: white;
    }

    .box h3 {
        margin-top: 20px;
        margin-left: 20px;
        font-size: 20px;
        margin-bottom: 10px;
        color: rgb(43, 42, 42);
    }

    .box a {
        font-size: 13px;
        margin-left: 20px;
        display: block;
        padding-top: 30px;
    }

    .box-a {
        overflow: hidden;
        background-color: white;
    }

    .box div img {
        width: 167px;
        height: 120px;
        cursor: pointer;
        margin-left: -20px;
        margin-right: 0px;
    }

    .box-a div {
        display: inline-block;
    }

    .box-a div span {
        display: block;
        font-size: 13px;
        margin-left: 20px;
    }

    .box-b {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: space-between;
    }

    .box-b .best {
        background-color: white;
        height: 130px;
        width: 315px;
    }

    .best h3 {
        font-size: 21px;
        margin: 20px;
        margin-bottom: 15px;
    }

    .best button {
        border-radius: 7px;
        box-shadow: 1px 2px 5px rgb(211, 207, 207);
        color: rgb(41, 41, 41);
        background-color: #ffd814;
        width: 280px;
        margin-left: 20px;
        height: 30px;
        border: none;
    }

    .box.box-c img {
        margin: 0px 20px;
        width: 275px;
        cursor: pointer;
        height: 280px;
    }


    /* .sec-2{
        width:100%;
        margin-left: 25px;
        margin-right: 25px;
        background-color: white;
        height: 290px;
    }
    .slide-sec{
        width: 100%;
        padding: 20px;
    }
    .product-slide{
        display: flex;
        width: 100%;
        overflow-x: scroll;
        margin-top: 5px ;
    }
    .product-slide li{
        margin-right: 10px;
        list-style: none;
        margin-bottom: 12px;
    } */

    .sec-2 {
        width: 100%;
        height: 315px;
        padding: 25px;
        padding-top: 0;
        padding-bottom: 25px;
    }

    .slide-sec h3 {
        font-size: 20px;
        padding-bottom: 5px;
    }

    .slide-sec {
        width: 100%;
        height: 100%;
        padding: 20px 20px 10px 20px;
        overflow-x: hidden;
        background-color: white;
        position: relative;
    }

    .product-slide {
        display: flex;
        margin-top: 5px;
        overflow-x: scroll;
        scroll-behavior: smooth;
    }

    .product-slide::-webkit-scrollbar {
        background-color: transparent;
        height: 7px;
        cursor: pointer;
    }

    .product-slide::-webkit-scrollbar-thumb {
        border-radius: 10px;
        cursor: pointer;
    }

    .product-slide::-webkit-scrollbar-thumb:hover {
        background: #9e9c9c;
        border-radius: 10px;
    }

    .product-slide li {
        list-style: none;
        margin-right: 10px;
        margin-bottom: 15px;
        cursor: pointer;
    }

    .l-btn,
    .r-btn {
        background-color: rgba(255, 255, 255, 1);
        height: 90px;
        width: 50px;
        text-align: center;
        cursor: pointer;
        top: 35%;
        position: absolute;
        border: 3px solid transparent;
    }

    .l-btn {
        border-radius: 0 5px 5px 0;
        left: 20px;
    }

    .r-btn {
        border-radius: 5px 0 0 5px;
        right: 20px;
    }

    .l-btn:hover {
        border: 3px solid rgb(2, 150, 150);
    }

    .r-btn:hover {
        border: 3px solid rgb(2, 150, 150);
    }

    .r-btn i,
    .l-btn i {
        color: rgb(54, 54, 54);
        position: absolute;
        font-size: 30px;
        top: 35%;
        left: 13%;
        right: 13%;
    }

    .r-btn i:hover {
        transition: all 0.2s;
        color: black;
    }

    .l-btn i:hover {
        transition: all 0.2s;
        color: black;
    }

    .box-d div img {
        width: 147px;
        height: 110px;
        margin-left: 5px;
        margin-right: 0px;
    }

    .box-d div span {
        margin-bottom: 22px;
    }

    .box-d a {
        padding-top: 10px;
    }

    .footer {
        width: 100%;
        cursor: pointer;
        transition: all 0.2s;
        background: #EAEDED;

    }

    .backtop {
        text-align: center;
        height: 50px;
        background-color: #37475a;
        padding: 16px;
    }

    .backtop span {
        color: white;
        font-weight: bold;
    }

    .backtop:hover {
        background-color: #4d627c;
    }

    .detail {
        background-color: #232f3e;
        height: 350px;
    }

    .table {
        margin: 0 150px;
        height: 100%;
        display: flex;
        justify-content: space-around;
        padding-top: 50px;
    }

    .table div {
        width: 230px;
    }

    .t-head {
        font-size: 16px;
        font-weight: bold;
        color: white;
        margin-bottom: 5px;
    }

    .table li {
        color: rgb(223, 221, 221);
        padding-top: 10px;
        font-weight: lighter;
        font-size: 14px;
        list-style: none;
    }

    .copy {
        background-color: #232f3e;
        height: 90px;
        padding: 40px;
        text-align: center;
    }

    .copy span {
        color: white;
        font-size: 14px;
    }

    .line {
        height: 0.5px;
        width: 100%;
        background-color: rgb(172, 172, 172);
    }


    /* .hdn-elmnt{
        position: absolute;
        z-index: 100;
        display:flex;
        display: none;
        /* background-color: rgba(0, 0, 0, 0.719); */


    /* width: 100%;
        height: 100%;
    }
    .hdn-elmnt.active{
       display: block;
    } */

    .black {
        position: absolute;
        width: 0%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.726);
    }

    .black.active {
        width: 100%;
        z-index: 99;
    }

    .black.active-1 {
        width: 100%;
        top: 70px;
        z-index: 99;
    }

    .sidebar {
        background-color: white;
        width: 380px;
        transform: translateX(-390px);
        transition: all 0.5s;
        height: 100%;
        position: absolute;
        z-index: 101;
        overflow-y: scroll;
        box-shadow: 2px 2px 30px black;
    }

    .sidebar.active {
        transform: translateX(0);
    }

    .fa-xmark {
        color: white;
        top: 20px;
        display: none;
        cursor: pointer;
        font-size: 30px;
        left: 400px;
        position: absolute;
        z-index: 101;
    }

    .fa-xmark.active {
        display: block;
    }

    .hdn-head {
        background-color: #232f3e;
        height: 60px;
        width: 100%;
        color: white;
        text-align: center;
    }

    .hdn-head h2 {
        line-height: 60px;
    }

    .hdn-content h3 {
        padding: 20px 25px;
        color: rgb(39, 39, 39);
    }

    .hdn-content ul div {
        cursor: pointer;
        transition: all 0.2s;
        font-size: 14px;
        color: rgb(70, 70, 70);
        display: flex;
        padding: 15px 25px;
        justify-content: space-between;
    }

    .fa-angle-right {
        color: rgb(27, 27, 27);
    }

    .hdn-content ul div:hover {
        background-color: rgb(230, 227, 227);
    }

    .hdn-content ul {
        padding-bottom: 9px;
    }

    .triangle {
        position: absolute;
        z-index: 101;
        right: 188px;
        top: 42px;
        background-color: transparent;
        width: 0px;
        height: 0px;
        display: none;
        transition: all 2s;
        border: 12px solid blue;
        border-color: transparent transparent white transparent;
    }

    .triangle.active {
        display: block;
    }

    .hdn-sign {
        position: absolute;
        z-index: 101;
        display: none;
        transition: all 2s;
        width: 500px;
        height: 350px;
        top: 65px;
        right: 80px;
        background-color: white;
        border-radius: 5px;
    }

    .hdn-sign.active {
        display: flex;
        flex-direction: column;

    }

    .hdn-auth {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        font-size: 12px;
    }

    .hdn-table {
        display: flex;
        justify-content: space-around;
        padding: 20px 0;
    }

    .hdn-auth > a {
        display: block;
        background: #489856;
        color: white;
        border: none;

        border-radius: 2px;
        width: 100%;
        height: 30px;
        border: 1px solid;
        margin-top: 10px;
        margin-bottom: 5px;
        border-color: black;
        width: 40%;
    }
    .hdn-auth button {
        background: #489856;
        color: white;
        width: 100%;
        height: 100%;
        border: none;

    }


    .hdn-table h3 {
        font-size: 16px;
        padding: 10px 0;
    }

    .hdn-table li {
        color: rgb(85, 84, 84);
        font-size: 13px;
        padding: 5px 0px;
        cursor: pointer;
    }

    .hdn-table li:hover {
        color: rgb(252, 115, 65);
        text-decoration: underline;
    }

    .hdn-line {
        width: 0.5px;
        color: black;
        background-color: rgb(190, 190, 190);
        height: 220px;
    }
</style>

