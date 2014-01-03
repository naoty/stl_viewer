$ ->
  root = @

  WIDTH = 500
  HEIGHT = 500

  initializeRenderer = ->
    renderer = new THREE.WebGLRenderer(antialias: true)
    renderer.setSize(WIDTH, HEIGHT)
    renderer.setClearColor(0xFFFFFF, 1)

    viewer = renderer.domElement
    $(viewer).on "drop", onDrop
    $(viewer).on "dragover", onDragOver
    $("h1").after(viewer)

    return renderer

  onDrop = (event) ->
    event.preventDefault()
    file = event.originalEvent.dataTransfer.files[0]
    if !file.name.match(/.*\.stl$/i)
      alert("ERROR: unsupported file type")
      return
    root.fileReader.onload = onRead
    root.fileReader.readAsText(file)

  onDragOver = (event) ->
    event.preventDefault()

  onRead = (event) ->
    root.scene.remove(root.mesh)
    stlLoader = new THREE.STLLoader()
    geometry = stlLoader.parse(root.fileReader.result)
    material = new THREE.MeshBasicMaterial(color: 0x00FF00)
    root.mesh = new THREE.Mesh(geometry, material)
    root.scene.add(root.mesh)
    renderScene()

  initializeMesh = ->
    geometry = new THREE.CubeGeometry(1, 1, 1)
    material = new THREE.MeshBasicMaterial(color: 0x00FF00)
    mesh = new THREE.Mesh(geometry, material)
    root.scene.add(mesh)
    return mesh

  initializeCamera = ->
    camera = new THREE.PerspectiveCamera(45, WIDTH / HEIGHT, 1, 100)
    camera.position.set(0, 5, 10)
    camera.lookAt(root.scene.position)
    root.scene.add(camera)
    return camera

  renderScene = ->
    requestAnimationFrame(renderScene)
    root.mesh.rotation.y += 0.01
    root.renderer.render(root.scene, root.camera)

  initializeEvents = ->
    $(document).keyup (event) ->
      console.log(event.which)
      # Press '-' to zoom out
      if [61, 187].indexOf(event.which) != -1
        root.camera.position.y *= 0.9
        root.camera.position.z *= 0.9
      # Press '+' to zoom in
      if [173, 189].indexOf(event.which) != -1
        root.camera.position.y *= 1.1
        root.camera.position.z *= 1.1

  root.fileReader = new FileReader()
  root.renderer = initializeRenderer()
  root.scene = new THREE.Scene()
  root.mesh = initializeMesh()
  root.camera = initializeCamera()
  renderScene()
  initializeEvents()
