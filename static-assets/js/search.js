(function () {
    if (!document.getElementById('keyword').value) {
        document.getElementById('eac-container-keyword').className="";
    }
    document.getElementById('keyword').addEventListener('keypress', function() {
        document.getElementById('eac-container-keyword').className="easy-autocomplete-container";
    });
}) ();