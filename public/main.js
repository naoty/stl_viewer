window.onload = function () {
    const WIDTH = 600;
    const HEIGHT = 600;

    /**
     * Create scene, camera, renderer using Three.js
     */
    var scene = new THREE.Scene();
    var camera = new THREE.PerspectiveCamera(75, WIDTH / HEIGHT, 0.1, 1000);
    // camera.position.z = 100;
    camera.position.z = 5;

    var renderer = new THREE.WebGLRenderer();
    renderer.setSize(WIDTH, HEIGHT);

    var viewer = renderer.domElement;
    viewer.addEventListener("drop", onDrop);
    viewer.addEventListener("dragover", onDragOver);
    document.body.insertBefore(viewer, document.getElementById("caption"));

    /**
     * Read uploaded file via File API
     */
    var fileReader = new FileReader();

    function onDrop(event) {
        event.preventDefault();
        var file = event.dataTransfer.files[0];
        if (!file.name.match(/.*\.stl$/i)) {
            alert("ERROR: unsupported file type");
            return;
        }

        fileReader.onload = onRead;
        fileReader.readAsText(file);
    }

    function onDragOver(event) {
        event.preventDefault();
    }

    function onRead(event) {
        var stlLoader = new THREE.STLLoader();
        var geometry = stlLoader.parse(fileReader.result);
        var material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
        var mesh = new THREE.Mesh(geometry, material);
        scene.add(mesh);

        var render = function () {
            requestAnimationFrame(render);
            mesh.rotation.y += 0.01;
            renderer.render(scene, camera);
        };
        render();
    }
};
