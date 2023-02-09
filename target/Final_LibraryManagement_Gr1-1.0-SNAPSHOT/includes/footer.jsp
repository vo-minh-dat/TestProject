<section class="footer">
    <div class="backtop">
        <span>Back to Top</span>
    </div>
    
    <div class="line"></div>
    <div class="copy">
        <span>&copy; Designed by Group01_SE1605</span>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script>
    const slides = document.getElementsByClassName("slide");


    const backtop = document.querySelector('.backtop');
    backtop.addEventListener("click", () => {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    });




</script>

