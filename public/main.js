window.onload = function () {
    var viewer = document.getElementById("viewer");
    viewer.addEventListener("drop", onDrop);
    viewer.addEventListener("dragover", onDragOver);

    function onDrop(event) {
        var file = event.dataTransfer.files[0];
        alert("Name: " + file.name + ", Size: " + file.size);
        event.preventDefault();
    }

    function onDragOver(event) {
        event.preventDefault();
    }
};
