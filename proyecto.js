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
  var pivote;
  var figuraRotacion = new function() {
    this.velocidadFigura = 0.02;
  }();

  init();
  animate();
  addEvents();
  function init() {
    var container = document.getElementById("container");
    pivote = new THREE.Object3D();
    
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
    esfera = esfera();
    pivote.add(esfera);        

    piramide = piramide();
    pivote.add(object);

    cubo = cubo();
    pivote.add(cubo);

    cono = cono();
    pivote.add(cono);

    toroide = toroide();
    pivote.add(toroide);

    tetera = tetera();
    scene.add(tetera);
    scene.add(pivote);    

    objects = [esfera, piramide, cubo, cono, toroide, tetera];

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
 
      }
    });

    $(window).mouseup(function(event) {
      event.preventDefault();
      isMouseDown = false;

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
        let planeMaterial = new THREE.MeshStandardMaterial({ color, side: THREE.DoubleSide });
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
    object.position.set(-1.2, 0.2, -1.2);
    scene.add(object);
    return object;
  }

  function cubo() {
    let matBox = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    matBox.name = "cubo";
    object = new THREE.Mesh(
      new THREE.BoxBufferGeometry(0.36, 0.36, 0.36, 1, 1, 1),
      matBox
    );

    object.position.set(-1.4, 0.18, 0.5);
    scene.add(object);
    return object;
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
    object.position.set(0, 0.2, 1.4);
    return object;
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
    object.position.set(0.5, 0.2, -1.4);
    scene.add(object);
    return object;
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
    object.position.set(1.4, 0.2, 0.2);
    return object;
  }

  function tetera() {
    let matTetera = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide, 
      color: 0xFFFFFF      
    });
    matTetera.name = "tetera";
    var geometriaTetera = new THREE.TeapotBufferGeometry( 0.3,
      5,true,true,true,true,true 
    );
    
    object = new THREE.Mesh(
      geometriaTetera,
      matTetera
    );
    object.position.set(0,0.3,0);
    return object;
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

    //pivote.position = tetera.position;
    pivote.rotation.y += 0.02;

    
  }
});
