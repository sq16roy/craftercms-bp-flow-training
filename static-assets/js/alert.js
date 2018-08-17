(function () {
    let alerts = document.getElementById('alertBoxContainer');

    if (alerts.childElementCount <= 1) {
        console.log('here')
        document.getElementById('alertBoxContainer').style.display = 'none';
    } else {
        let state = false;
        let hideBox = setTimeout(function() { 
            if (!state) {
                $('#alertBoxContainer').fadeOut();
            }
        }, 3000);

        document.getElementById('alertBoxContainer').style.display = 'block';
        alerts.addEventListener("mouseover", () => {
            state = true;
            clearTimeout(hideBox);
        });
        alerts.addEventListener("mouseleave", () => {
            state = false;
            hideBox = setTimeout(function() { 
                if (!state) {
                    $('#alertBoxContainer').fadeOut();
                }
            }, 3000);
        });
    }
    document.getElementById('closeBoxAlert').addEventListener('click', function() {
        $('#alertBoxContainer').fadeOut();
    });
}) ();