$(document).ready(function() {
  if (WEBGL.isWebGLAvailable() === false) {
    document.body.appendChild(WEBGL.getWebGLErrorMessage());
  }
  const color = {
    AMARILLO: 0xffff00,
    AZUL: 0x0000ff,
    ROJO: 0xff0000,
    BLANCO: 0xffffff
  };
  var camera, scene, renderer, bulbLight, hemiLight;

  // figuras
  var matEsf, matPir, matToro, matBox, matCono;

  var operaciones = {
    "Trasladar": "translate",
    "Rotar": "rotate",    
    "Escalar": "scale"
  };

  var par = {
    Transformar: Object.keys(operaciones)[0],
    R: 255,
    G: 255,
    B: 255
  };

  // ref for lumens: http://www.power-sure.com/lumens.htm
  var bulbLuminousPowers = {
    "3500 lm (300W)": 3500,
    "Off": 0
  };

  // ref for solar irradiances: https://en.wikipedia.org/wiki/Lux
  var hemiLuminousIrradiances = {
    "0.0001 lx (Moonless Night)": 0.0001,
    "0.5 lx (Full Moon)": 0.5
  };

  var params = {
    Azul: false,
    Amarillo: true,
    Rojo: false,
    Blanca: false,
    exposure: 0.7,
    bulbPower: Object.keys(bulbLuminousPowers)[0],
    hemiIrradiance: Object.keys(hemiLuminousIrradiances)[1]
  };

  var raycaster;
  var mouseVector;
  var intersection = new THREE.Vector3();
  var offset = new THREE.Vector3();
  var SELECTED;
  var FIGURASELECCIONADA = null;
  var plane = new THREE.Plane();
  var INTERSECTED;
  var graficoPicking = null;
  var objects = [];
  var cameraMove;
  var figuraRotacion = new function() {
    this.velocidadFigura = 0.02;
  }();

  init();
  animate();
  addEvents();
  function init() {
    var container = document.getElementById("container");

    // picking
    raycaster = new THREE.Raycaster();
    mouseVector = new THREE.Vector2();

    // camera initial
    camera = new THREE.PerspectiveCamera(
      50,
      window.innerWidth / window.innerHeight,
      0.1,
      100
    );
    camera.position.x = -4;
    camera.position.z = 4;
    camera.position.y = 2;
    scene = new THREE.Scene();

    // Ejes guía - Sistema de referencia de la escena
    var axes = new THREE.AxesHelper( 1 );
    axes.position.set( 0, 0.001, 0 );
    scene.add( axes );

    /*
          FOCOS
        */
    var bulbGeometry = new THREE.SphereBufferGeometry(0.02, 16, 8);

    // Foco Amarillo
    focoAmarillo = generarFoco(color.AMARILLO, bulbGeometry);
    scene.add(focoAmarillo);

    // Foco Azul
    focoAzul = generarFoco(color.AZUL, bulbGeometry);
    scene.add(focoAzul);

    // Foco Rojo
    focoRojo = generarFoco(color.ROJO, bulbGeometry);
    scene.add(focoRojo);

    // blanco
    focoBlanco = generarFoco(color.BLANCO, bulbGeometry);
    focoBlanco.position.set(0.1, 2, 0);
    scene.add(focoBlanco);

    hemiLight = new THREE.HemisphereLight(0xddeeff, 0x0f0e0d, 0.02);
    scene.add(hemiLight);

    /*
          TABLERO
        */

    generarTablero();

    /*
          Configuraciones
        */
    renderer = new THREE.WebGLRenderer();
    renderer.physicallyCorrectLights = true;
    renderer.gammaInput = true;
    renderer.gammaOutput = true;
    renderer.shadowMap.enabled = true;
    renderer.toneMapping = THREE.ReinhardToneMapping;
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(window.innerWidth, window.innerHeight);
    container.appendChild(renderer.domElement);

    /*
          OBJETOS
        */
    [matEsf, esfera] = esfera();
    scene.add(esfera);

    [matPir, piramide] = piramide();
    scene.add(object);

    [matBox, cubo] = cubo();
    scene.add(cubo);

    [matCono, cono] = cono();
    scene.add(cono);

    [matToro, toroide] = toroide();
    scene.add(toroide);

    objects = [esfera, piramide, cubo, cono, toroide];

    graficoPicking = esfera;

    cameraMove = new THREE.OrbitControls(camera, renderer.domElement);
    cameraMove.addEventListener( 'change', render );

    cameraMove.addEventListener( 'start', function() {
      cancelHideTransorm();
    } );

    cameraMove.addEventListener( 'end', function() {
      delayHideTransform();
    } );

    transformControl = new THREE.TransformControls( camera, renderer.domElement );
    transformControl.addEventListener( 'change', render );
    transformControl.addEventListener( 'dragging-changed', function ( event ) {
      cameraMove.enabled = !event.value
    } );
    //transformControl.setMode('rotate');
    scene.add( transformControl );

    // Hiding transform situation is a little in a mess :()
    transformControl.addEventListener( 'change', function( e ) {
      cancelHideTransorm();
    } );

    transformControl.addEventListener( 'mouseDown', function( e ) {
      cancelHideTransorm();
    } );

    transformControl.addEventListener( 'mouseUp', function( e ) {
      delayHideTransform();
    } );

    transformControl.addEventListener( 'objectChange', function( e ) {
      cancelHideTransorm();      
    } );

    var dragcontrols = new THREE.DragControls( objects, camera, renderer.domElement ); //
    dragcontrols.enabled = false;
    dragcontrols.addEventListener( 'hoveron', function ( event ) {      
      cancelHideTransorm();
    } );

    dragcontrols.addEventListener( 'hoveroff', function ( event ) {
      delayHideTransform();
    } );

    var hiding;

    function delayHideTransform() {
      cancelHideTransorm();
      hideTransform();
    }

    function hideTransform() {
      hiding = setTimeout( function() {
        transformControl.detach( transformControl.object );
      }, 2500 )
    }

    function cancelHideTransorm() {
      if ( hiding ) clearTimeout( hiding );
    }


    window.addEventListener("resize", onWindowResize, false);
    addGui();
  }

  function changeColor(){
    var color = new THREE.Color(
      "rgb(" +
        Math.round(par.R) +
        "," +
        Math.round(par.G) +
        ", " +
        Math.round(par.B) +
        ")"
    );

    if (FIGURASELECCIONADA){
      FIGURASELECCIONADA.material.color.set(color);      
    }
  }

  function render() {
    graficoPicking.rotation.y += figuraRotacion.velocidadFigura;
    raycaster.setFromCamera(mouseVector, camera);

    renderer.toneMappingExposure = Math.pow(params.exposure, 5.0); // to allow for very bright scenes.

    if (params.Amarillo == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoAmarillo.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoAmarillo.power = bulbLuminousPowers[params.bulbPower];
    }

    if (params.Azul == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoAzul.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoAzul.power = bulbLuminousPowers[params.bulbPower];
    }

    if (params.Rojo == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoRojo.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoRojo.power = bulbLuminousPowers[params.bulbPower];
    }

    if (params.Blanca == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoBlanco.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoBlanco.power = bulbLuminousPowers[params.bulbPower];
    }

    hemiLight.intensity = hemiLuminousIrradiances[params.hemiIrradiance];

    renderer.render(scene, camera);
  }

  function addEvents(plano) {
    var isMouseDown = false;
    $(window).mousemove(function(event) {
      event.preventDefault();
      mouseVector.x = (event.clientX / window.innerWidth) * 2 - 1;
      mouseVector.y = -(event.clientY / window.innerHeight) * 2 + 1;

      raycaster.setFromCamera(mouseVector, camera);

      var intersects = raycaster.intersectObjects(objects);
      var isIntersect = intersects.length > 0;
      if (isIntersect) {
        graficoPicking = intersects[0].object;

        if (INTERSECTED != graficoPicking && !isMouseDown) {
          if (INTERSECTED) {
            INTERSECTED.material.color.setHex(INTERSECTED.currentHex);
          }
          INTERSECTED = graficoPicking;
          transformControl.attach( INTERSECTED );
          INTERSECTED.currentHex = INTERSECTED.material.color.getHex();
        }
      } else {
        if (INTERSECTED) {
          INTERSECTED.material.color.setHex(INTERSECTED.currentHex);
        }
        INTERSECTED = null;
      }
    });

    $(window).mousedown(function(event) {
      event.preventDefault();
      isMouseDown = true;
      raycaster.setFromCamera(mouseVector, camera);
      var intersects = raycaster.intersectObjects(objects);
      let isGraficoIntersectado = intersects.length > 0;
      if (isGraficoIntersectado) {
        graficoPicking = intersects[0].object;
        SELECTED = graficoPicking;
        FIGURASELECCIONADA = SELECTED
        /*
        cameraMove.enabled = false;        
        if (raycaster.ray.intersectPlane(plane, intersection)) {
          offset.copy(intersection).sub(SELECTED.position);
        }
        */
      }
    });

    $(window).mouseup(function(event) {
      event.preventDefault();
      isMouseDown = false;
      /*
      if (INTERSECTED) {
        SELECTED = null;
        return;
      }*/
      cameraMove.enabled = true;
    });
  }

  function addGui() {
    var gui = new dat.GUI();
    gui.add(figuraRotacion, "velocidadFigura", 0, 0.5);
    gui.add(params, "hemiIrradiance", Object.keys(hemiLuminousIrradiances));
    gui.add(par, "Transformar", Object.keys(operaciones)).onChange(function(value) {transformControl.setMode(value)});
    gui.add(par, "R", 0, 255).step(1).onChange(changeColor);
    gui.add(par, "G", 0, 255).step(1).onChange(changeColor);
    gui.add(par, "B", 0, 255).step(1).onChange(changeColor);
    gui.add(params, "exposure", 0, 1);
    gui.add(params, "Amarillo", 0, 1);
    gui.add(params, "Azul", 0, 1);
    gui.add(params, "Rojo", 0, 1);
    gui.add(params, "Blanca", 0, 1);
    gui.open();
  }

  function generarFoco(color, bulbGeometry) {
    let bulbLight = new THREE.PointLight(color, 1, 100, 2);
    bulbLight.add(
      new THREE.Mesh(
        bulbGeometry,
        new THREE.MeshBasicMaterial({ color: color })
      )
    );
    bulbLight.position.set(-0.5, 2, 0);
    return bulbLight;
  }

  function generarTablero() {
    let zPosition = 1.75;
    let xPosition = 1.75;
    var flag = 0;
    for (let i = 0; i < 8; i++) {
      for (let j = 0; j < 8; j++) {
        let floorGeometry = new THREE.PlaneBufferGeometry(0.5, 0.5);
        let color = generarColor(j, flag);
        let planeMaterial = new THREE.MeshStandardMaterial({ color });
        let floorMesh = new THREE.Mesh(floorGeometry, planeMaterial);
        floorMesh.receiveShadow = true;
        floorMesh.rotation.x = -Math.PI / 2.0;
        floorMesh.position.x = xPosition;
        floorMesh.position.y = 0;
        floorMesh.position.z = zPosition;
        zPosition = zPosition - 0.5;
        scene.add(floorMesh);
      }
      xPosition = xPosition - 0.5;
      zPosition = 1.75;
      flag = flag + 1;
    }
  }

  function generarColor(i, flag) {
    const WHITE_COLOR = "#ffffff";
    const BLACK_COLOR = "#000000";
    const isPar = flag % 2 == 0;
    const isParVertical = i % 2 == 0;
    if (isPar && isParVertical) {
      return BLACK_COLOR;
    }
    if (isPar) {
      return WHITE_COLOR;
    }
    if (isParVertical) {
      return WHITE_COLOR;
    }
    return BLACK_COLOR;
  }

  /*
    Objetos
   */
  function toroide() {
    let matToro = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    matToro.name = "toroide";
    object = new THREE.Mesh(
      new THREE.TorusBufferGeometry(0.15, 0.05, 30, 65),
      matToro
    );
    object.position.set(-0.45, 0.2, 0);
    scene.add(object);
    return [matToro, object];
  }

  function cubo() {
    let matBox = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    matBox.name = "esfera";
    object = new THREE.Mesh(
      new THREE.BoxBufferGeometry(0.36, 0.36, 0.36, 1, 1, 1),
      matBox
    );

    object.position.set(-0.9, 0.18, 0);
    scene.add(object);
    return [matBox, object];
  }

  function esfera() {
    let matEsf = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    matEsf.name = "esfera";
    object = new THREE.Mesh(
      new THREE.SphereBufferGeometry(0.2, 32, 32),
      matEsf
    );
    object.position.set(0, 0.2, 0);
    return [matEsf, object];
  }

  function cono() {
    let matCono = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    matCono.name = "cono";
    object = new THREE.Mesh(
      new THREE.CylinderBufferGeometry(0, 0.2, 0.4, 60),
      matCono
    );
    object.position.set(0.4, 0.2, 0);
    scene.add(object);
    return [matCono, object];
  }

  function piramide() {
    let matPir = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    matPir.name = "piramide";
    object = new THREE.Mesh(
      new THREE.TetrahedronBufferGeometry(0.3, 0),
      matPir
    );
    object.position.set(0.8, 0.2, 0);
    return [matPir, object];
  }

  function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
  }

  function animate() {
    cameraMove.update();
    render();
    requestAnimationFrame(animate);
  }
});
