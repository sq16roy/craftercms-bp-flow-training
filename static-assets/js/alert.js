(function () {
    let alerts = document.getElementById('alertBoxContainer').childElementCount;
    if (!alerts) {
        document.getElementById('alertBoxContainer').style.display = 'none';
    } else {
        document.getElementById('alertBoxContainer').style.display = 'block';
    }
}) ();