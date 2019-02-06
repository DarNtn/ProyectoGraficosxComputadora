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

  var camera, scene, renderer, hemiLight, splineCamera, parent, tubeGeometry;
  var torotate = [];
  var totraslate = [];

  var par = {
    R: 255,
    G: 255,
    B: 255
  };

  // ref for lumens: http://www.power-sure.com/lumens.htm
  var bulbLuminousPowers = {
    "3500 lm (300W)": 3500,
    Off: 0
  };

  // ref for solar irradiances: https://en.wikipedia.org/wiki/Lux
  var hemiLuminousIrradiances = {
    "0.0001 lx (Moonless Night)": 0.0001,
    "0.5 lx (Full Moon)": 0.5
  };

  var params = {
    LuzAzul: false,
    LuzAmarilla: false,
    LuzRoja: false,
    LuzBlanca: true,
    Exposicion: 0.6,
    bulbPower: Object.keys(bulbLuminousPowers)[0],
    hemiIrradiance: Object.keys(hemiLuminousIrradiances)[1],
    AnimacionCamara: false,
    VelocidadRotacion: 0.02,
    VelocidadTraslacion: 0.02,
    Activado: false
  };

  var objects = [];
  var raycaster;
  var mouseVector;
  var SELECTED;
  var FIGURASELECCIONADA = null;
  var INTERSECTED;
  var graficoPicking = null;
  var cameraMove;
  var pivote;
  var figuraRotacion = new function() {
    this.VelocidadRotacion = 0.02;
    this.VelocidadTraslacion = 0.02;
  }();
  var preventRotation = false;

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

    parent = new THREE.Object3D();
    scene.add(parent);

    // camera spline - path movement
    splineCamera = new THREE.PerspectiveCamera(
      90,
      window.innerWidth / window.innerHeight,
      0.1,
      1000
    );
    parent.add(splineCamera);

    tubeGeometry = trayectoriaCam();

    // Ejes guía - Sistema de referencia de la escena
    var axes = new THREE.AxesHelper(1);
    axes.position.set(0, 0.001, 0);
    scene.add(axes);

    //FOCOS
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

    //TABLERO
    generarTablero();

    //Configuraciones
    renderer = new THREE.WebGLRenderer();
    renderer.physicallyCorrectLights = true;
    renderer.gammaInput = true;
    renderer.gammaOutput = true;
    renderer.shadowMap.enabled = true;
    renderer.toneMapping = THREE.ReinhardToneMapping;
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(window.innerWidth, window.innerHeight);
    container.appendChild(renderer.domElement);

    //OBJETOS
    esfera = esfera();
    obj = new THREE.Object3D();
    obj.add(esfera);
    pivote.add(obj); 

    piramide = piramide();
    obj = new THREE.Object3D();
    obj.add(piramide);
    pivote.add(obj);

    cubo = cubo();
    obj = new THREE.Object3D();
    obj.add(cubo);
    pivote.add(obj);

    cono = cono();
    obj = new THREE.Object3D();
    obj.add(cono);    
    pivote.add(obj);

    toroide = toroide();
    obj = new THREE.Object3D();
    obj.add(toroide);
    pivote.add(obj);

    tetera = tetera();
    obj = new THREE.Object3D();
    obj.add(tetera)
    pivote.add(obj);

    //scene.add(obj);
    scene.add(pivote);

    objects = [esfera, piramide, cubo, cono, toroide, tetera];

    graficoPicking = esfera;

    cameraMove = new THREE.OrbitControls(camera, renderer.domElement);
    cameraMove.addEventListener("change", render);

    cameraMove.addEventListener("start", function() {
      cancelHideTransorm();
    });

    cameraMove.addEventListener("end", function() {
      delayHideTransform();
    });

    transformControl = new THREE.TransformControls(camera, renderer.domElement);
    transformControl.addEventListener("change", render);
    transformControl.addEventListener("dragging-changed", function(event) {
      cameraMove.enabled = !event.value;
    });
    scene.add(transformControl);

    transformControl.addEventListener("change", function(e) {
      cancelHideTransorm();
    });

    transformControl.addEventListener("mouseDown", function(e) {
      cancelHideTransorm();
    });

    transformControl.addEventListener("mouseUp", function(e) {
      preventRotation = false;
      delayHideTransform();
    });

    transformControl.addEventListener("objectChange", function(e) {
      preventRotation = true;
      cancelHideTransorm();
    });

    var dragcontrols = new THREE.DragControls(
      objects,
      camera,
      renderer.domElement
    ); //
    dragcontrols.enabled = false;
    dragcontrols.addEventListener("hoveron", function(event) {
      cancelHideTransorm();
    });

    dragcontrols.addEventListener("hoveroff", function(event) {
      delayHideTransform();
    });

    addKeyEvents();

    var hiding;

    function delayHideTransform() {
      cancelHideTransorm();
      hideTransform();
    }

    function hideTransform() {
      hiding = setTimeout(function() {
        transformControl.detach(transformControl.object);
      }, 2500);
    }

    function cancelHideTransorm() {
      if (hiding) clearTimeout(hiding);
    }

    window.addEventListener("resize", onWindowResize, false);
    addGui();
  }

  function changeColor() {
    var color = new THREE.Color(
      "rgb(" +
        Math.round(par.R) +
        "," +
        Math.round(par.G) +
        ", " +
        Math.round(par.B) +
        ")"
    );

    if (FIGURASELECCIONADA) {
      FIGURASELECCIONADA.material.color.set(color);
    }
  }

  function render() {
    raycaster.setFromCamera(mouseVector, camera);

    renderer.toneMappingExposure = Math.pow(params.Exposicion, 5.0); // to allow for very bright scenes.

    if (params.LuzAmarilla == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoAmarillo.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoAmarillo.power = bulbLuminousPowers[params.bulbPower];
    }

    if (params.LuzAzul == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoAzul.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoAzul.power = bulbLuminousPowers[params.bulbPower];
    }

    if (params.LuzRoja == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoRojo.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoRojo.power = bulbLuminousPowers[params.bulbPower];
    }

    if (params.LuzBlanca == false) {
      params.bulbPower = Object.keys(bulbLuminousPowers)[1];
      focoBlanco.power = bulbLuminousPowers[params.bulbPower];
    } else {
      params.bulbPower = Object.keys(bulbLuminousPowers)[0];
      focoBlanco.power = bulbLuminousPowers[params.bulbPower];
    }

    // Traslacion de todos los objetos con respecto del objeto complejo
    pivote.position.set(
      tetera.position.x,
      tetera.position.y,
      tetera.position.z
    );

    if (params.Activado) {
      if (!preventRotation) {
        pivote.rotation.y += params.VelocidadTraslacion;
        VelocidadTraslacionGlobal = params.VelocidadTraslacion;
      } else {
        pivote.rotation.y = 0;
      }
    }

    // Rotación de todos los objetos
    objects.forEach(function(fig){
      if (params.Activado){
        fig.rotation.y += params.VelocidadRotacion;
      }
    });

    // Rotacion en propio eje objeto seleccionado
    torotate.forEach(function(fig){
      fig.rotation.y += figuraRotacion.VelocidadRotacion;
    });

    // Traslacion en eje tetera objeto seleccionado
    totraslate.forEach(function(fig){
      fig.parent.rotation.y += figuraRotacion.VelocidadTraslacion;
    });

    // Seguimiento de trayectoria - Camera spline
    var time = Date.now();
    var looptime = 20 * 1000;
    var t = (time % looptime) / looptime;

    var pos = tubeGeometry.parameters.path.getPointAt(t);
    splineCamera.position.copy(pos);
    splineCamera.matrix.lookAt(
      splineCamera.position,
      new THREE.Vector3(0, 0, 0),
      new THREE.Vector3(0, 1, 0)
    );
    splineCamera.rotation.setFromRotationMatrix(
      splineCamera.matrix,
      splineCamera.rotation.order
    );

    hemiLight.intensity = hemiLuminousIrradiances[params.hemiIrradiance];

    renderer.render(
      scene,
      params.AnimacionCamara === true ? splineCamera : camera
    );
  }

  function addEvents(plano) {
    var isMouseDown = false;

    $(document).bind("contextmenu", function(event) {
      if (event.target.nodeName === "DIV") {
        return;
      } else if (event.target.nodeName === "CANVAS") {
        var intersects = raycaster.intersectObjects(objects);
        if (intersects.length > 0) {
          //console.log(intersects[0].object);
          FIGURASELECCIONADA = intersects[0].object;
          //console.log(FIGURASELECCIONADA);
        } else {
          return;
        }
        event.preventDefault();
        $(".custom-menu")
          .finish()
          .toggle(100)
          .css({
            top: event.pageY + "px",
            left: event.pageX + "px"
          });
      }
    });

    $(document).bind("mousedown", function(e) {
      if (!$(e.target).parents(".custom-menu").length > 0) {
        $(".custom-menu").hide(100);
      }
      if (!$(e.target).parents(".custom-submenu").length > 0) {
        $(".custom-submenu").hide(100);
      }
    });

    $(".custom-menu li").click(function(event) {
      var accion = $(this).attr("data-action");
      switch (accion) {
        case "textura":
          $(".custom-submenu")
            .finish()
            .toggle(100)
            .css({
              top: parseInt(event.pageY) - 204 + "px",
              left: event.pageX + "px"
            });
          break;
        case "rotacion":
          if (torotate.includes(FIGURASELECCIONADA)){
            torotate.splice(torotate.indexOf(FIGURASELECCIONADA), 1);
          } else{
            torotate.push(FIGURASELECCIONADA);
          }          
          break;
        case "traslacion":
          if (totraslate.includes(FIGURASELECCIONADA)){
            totraslate.splice(totraslate.indexOf(FIGURASELECCIONADA), 1);
          } else{
            totraslate.push(FIGURASELECCIONADA);
          }          
          break;
        case "eliminar":
          console.log("==== eliminar");
          if (torotate.includes(FIGURASELECCIONADA)) {
            torotate.splice(torotate.indexOf(FIGURASELECCIONADA), 1);
          }
          if (totraslate.includes(FIGURASELECCIONADA)) {
            totraslate.splice(totraslate.indexOf(FIGURASELECCIONADA), 1);
          }
          transformControl.detach(FIGURASELECCIONADA);
          for (var i = 0; i < pivote.children.length; i++) {
             pivote.children[i].remove(FIGURASELECCIONADA);
          }
          break;
        case "trasladar":
          transformControl.attach(FIGURASELECCIONADA);
          transformControl.setMode("translate");
          break;
        case "rotar":
          transformControl.attach(FIGURASELECCIONADA);
          transformControl.setMode("rotate");
          break;
        case "deseleccionar":
          if (torotate.includes(FIGURASELECCIONADA)) {
            torotate.splice(torotate.indexOf(FIGURASELECCIONADA), 1);
          }
          if (totraslate.includes(FIGURASELECCIONADA)) {
            totraslate.splice(totraslate.indexOf(FIGURASELECCIONADA), 1);
          }
          transformControl.detach(FIGURASELECCIONADA);
          FIGURASELECCIONADA = null;
          break;
        case "escalar":
          transformControl.setMode("scale");
          break;
      }
      $(".custom-menu").hide(100);
    });

    $(".custom-submenu li").click(function() {
      var accion = $(this).attr("data-action");
      switch (accion) {
        case "textura-madera":
          setTexture("images/hardwood2_diffuse.jpg", FIGURASELECCIONADA);
          break;
        case "textura-ladrillo":
          setTexture("images/bricks.gif", FIGURASELECCIONADA);
          break;
        case "textura-normal":
          setTexture("images/bricks.gif", FIGURASELECCIONADA, true);
          break;
        case "textura-bloque":
          setTexture("images/brick_bump.jpg", FIGURASELECCIONADA);
          break;
        case "textura-marmol":
          setTexture("images/disturb.jpg", FIGURASELECCIONADA);
          break;
        case "textura-metalico":
          setTexture("images/metal.jpg", FIGURASELECCIONADA);
          break;
      }
      $(".custom-submenu").hide(100);
    });

    function setTexture(url, figure, standard) {
      var loader = new THREE.TextureLoader();
      loader.load(url, function(texture) {
        // do something with the texture
        console.log("setTexture");
        var material_texture = null;
        if (standard) {
          material_texture = new THREE.MeshStandardMaterial({
            side: THREE.DoubleSide,
            color: "#ffffff"
          });
        } else {
          material_texture = new THREE.MeshBasicMaterial({
            map: texture
          });
        }
        figure.material = material_texture;
      });
    }

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
          //transformControl.attach( INTERSECTED );
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
        FIGURASELECCIONADA = SELECTED;
      }
    });

    $(window).mouseup(function(event) {
      event.preventDefault();
      // transformControl.detach(FIGURASELECCIONADA);
      isMouseDown = false;
      /*
      raycaster.setFromCamera(mouseVector, camera);
      var intersects = raycaster.intersectObjects(objects);
      let isGraficoIntersectado = intersects.length > 0;
      if (!isGraficoIntersectado) {        
        //FIGURASELECCIONADA = null;
      }
      */
      cameraMove.enabled = true;
    });
  }

  function addGui() {
    var gui = new dat.GUI({ name: "Menú de opciones", width: 272 });
    function esfera() {
      return object;
    }
    var figuras = gui.addFolder("Crear Figuras");

    var figurasCrear = {
      Pirámide: function() {
        let matPir = new THREE.MeshStandardMaterial({
          side: THREE.DoubleSide,
          color: "#ffffff"
        });
        matPir.name = "piramide";
        object = new THREE.Mesh(
          new THREE.TetrahedronBufferGeometry(0.3, 0),
          matPir
        );
        var random = Math.random() * (4 - 1) + 1;
        var random2 = Math.random() * (3 - 0.2) + 0.2;
        object.position.set(random, random2, random2);
        object.name = "piramide";
        objects.push(object);
        obj = new THREE.Object3D();
        obj.add(object);
        pivote.add(obj);
      },
      Toroide: function() {
        let matToro = new THREE.MeshStandardMaterial({
          side: THREE.DoubleSide,
          color: "#ffffff"
        });
        matToro.name = "toroide";
        object = new THREE.Mesh(
          new THREE.TorusBufferGeometry(0.15, 0.05, 30, 65),
          matToro
        );
        var random = Math.random() * (4 - -1.2) + -1.2;
        var random2 = Math.random() * (3 - 0.2) + 0.2;
        object.position.set(random, random2, random);
        object.name = "toroide";
        objects.push(object);
        obj = new THREE.Object3D();
        obj.add(object);
        pivote.add(obj);
      },
      Cubo: function() {
        let matBox = new THREE.MeshStandardMaterial({
          side: THREE.DoubleSide,
          color: "#ffffff"
        });
        matBox.name = "cubo";
        object = new THREE.Mesh(
          new THREE.BoxBufferGeometry(0.36, 0.36, 0.36, 1, 1, 1),
          matBox
        );
        var random = Math.random() * (3 - -1.4) + -1.4;
        var random2 = Math.random() * (3 - 0.5) + 0.5;
        object.position.set(random, 0.18, random2);
        object.name = "cubo";
        objects.push(object);
        obj = new THREE.Object3D();
        obj.add(object);
        pivote.add(obj);
      },
      Esfera: function() {
        let matEsf = new THREE.MeshStandardMaterial({
          side: THREE.DoubleSide,
          color: "#ffffff"
        });
        matEsf.name = "esfera";
        object = new THREE.Mesh(
          new THREE.SphereBufferGeometry(0.2, 32, 32),
          matEsf
        );
        var random = Math.random() * (3 - 0) + 0;
        var random2 = Math.random() * (3 - 1.4) - 1.4;
        object.position.set(random, 0.2, random2);
        object.name = "esfera";
        objects.push(object);
        obj = new THREE.Object3D();
        obj.add(object);
        pivote.add(obj);
      },
      Cono: function() {
        let matCono = new THREE.MeshStandardMaterial({
          side: THREE.DoubleSide,
          color: "#ffffff"
        });
        matCono.name = "cono";
        object = new THREE.Mesh(
          new THREE.CylinderBufferGeometry(0, 0.2, 0.4, 60),
          matCono
        );
        var random = Math.random() * (3 - 0.5) + 0.5;
        var random2 = Math.random() * (3 - 1.4) - 1.4;
        object.position.set(random, 0.2, random2);
        object.name = "cono";
        objects.push(object);
        obj = new THREE.Object3D();
        obj.add(object);
        pivote.add(obj);
      },
      Tetera: function() {
        let matTetera = new THREE.MeshStandardMaterial({
          side: THREE.DoubleSide,
          color: 0xffffff
        });
        matTetera.name = "tetera";
        var geometriaTetera = new THREE.TeapotBufferGeometry(
          0.3,
          5,
          true,
          true,
          true,
          true,
          true
        );
        var random = Math.random() * (3 - 0) + 0;
        var random2 = Math.random() * (3 - 1.4) - 1.4;
        object = new THREE.Mesh(geometriaTetera, matTetera);
        object.position.set(random, 0.3, random);
        object.name = "tetera";
        objects.push(object);
        obj = new THREE.Object3D();
        obj.add(object);
        pivote.add(obj);
      },
      Casa: function(){
        var casa = new THREE.Object3D();
        let matCasa = new THREE.MeshStandardMaterial({
          side: THREE.DoubleSide,
          color: "#ffffff"
        });
        
        techo = new THREE.Mesh(
          new THREE.CylinderBufferGeometry(0, 0.27, 0.1, 4),
          matCasa
        );
        techo.position.set(0, 0.41, 0);
        techo.rotation.y += 4;
        techo.name = "techo";

        cuerpo = new THREE.Mesh(
          new THREE.BoxBufferGeometry(0.36, 0.36, 0.36, 1, 1, 1),
          matCasa
        );
        cuerpo.position.set(0, 0.18, 0);
        cuerpo.name = "cuerpo";

        garage = new THREE.Mesh(
          new THREE.BoxBufferGeometry(0.20, 0.17, 0.18, 1, 1, 1),
          matCasa
        );
        garage.position.set(0.26, 0.085, 0.09);
        garage.name = "garage";

        cuerpo2 = new THREE.Mesh(
          new THREE.BoxBufferGeometry(0.20, 0.36, 0.18, 1, 1, 1),
          matCasa
        );
        cuerpo2.position.set(0.26, 0.18, -0.09);
        cuerpo2.name = "cuerpo2";

        casa.name = "casa";
        casa.add(cuerpo);
        casa.add(cuerpo2);
        casa.add(garage);
        casa.add(techo);
        casa.position.set(0.4,0.4,0.4);    
        objects.push(cuerpo);
        obj = new THREE.Object3D();
        obj.add(cuerpo);
        pivote.add(obj);
      }
    };
    figuras.add(figurasCrear, "Pirámide");
    figuras.add(figurasCrear, "Toroide");
    figuras.add(figurasCrear, "Cubo");
    figuras.add(figurasCrear, "Esfera");
    figuras.add(figurasCrear, "Cono");
    figuras.add(figurasCrear, "Tetera");
    figuras.add(figurasCrear, "Casa");
    // figuras.add(obj, "Tetera");
    figuras.open();

    gui.add(params, "AnimacionCamara");
    var folder2 = gui.addFolder("Animaciones objeto seleccionado");
    folder2.add(figuraRotacion, "VelocidadRotacion", -0.1, 0.1);
    folder2.add(figuraRotacion, "VelocidadTraslacion", -0.1, 0.1);
    var folder3 = gui.addFolder("Animaciones todos los objetos");
    folder3.add(params, "Activado", 0, 1);
    folder3.add(params, "VelocidadRotacion", -0.1, 0.1);
    folder3.add(params, "VelocidadTraslacion", -0.1, 0.1);
    var folder = gui.addFolder("Color del objeto seleccionado");
    folder
      .add(par, "R", 0, 255)
      .step(1)
      .onChange(changeColor);
    folder
      .add(par, "G", 0, 255)
      .step(1)
      .onChange(changeColor);
    folder
      .add(par, "B", 0, 255)
      .step(1)
      .onChange(changeColor);
    var folder1 = gui.addFolder("Luces");
    folder1.add(params, "LuzBlanca", 0, 1);
    folder1.add(params, "LuzAmarilla", 0, 1);
    folder1.add(params, "LuzAzul", 0, 1);
    folder1.add(params, "LuzRoja", 0, 1);
    folder1.add(params, "Exposicion", 0, 1);
    folder.open();
    folder1.open();
    folder2.open();
    folder3.open();
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
        let planeMaterial = new THREE.MeshStandardMaterial({
          color,
          side: THREE.DoubleSide
        });
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

  // Cambio de operacion mediante teclas
  //
  function addKeyEvents() {
    window.addEventListener("keydown", function(event) {
      switch (event.keyCode) {
        case 84: // T
          transformControl.setMode("translate");
          break;

        case 82: // R
          transformControl.setMode("rotate");
          break;

        case 69: // E
          transformControl.setMode("scale");
          break;

        case 88: // X
          transformControl.showX = !transformControl.showX;
          break;

        case 89: // Y
          transformControl.showY = !transformControl.showY;
          break;

        case 90: // Z
          transformControl.showZ = !transformControl.showZ;
          break;

        case 27: // ESC
          FIGURASELECCIONADA = null;
      }
    });
  }

  //OBJETOS
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
    object.position.set(-1.2, 0.05, -1.2);
    object.name = "toroide";
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
    object.position.set(-1.4, 0.04, 0.5);
    object.name = "cubo";
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
    object.position.set(0, 0.045, 1.4);
    object.name = "esfera";
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
    object.position.set(0.5, 0.06, -1.4);
    object.name = "cono";
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
    object.position.set(1.4, 0.03, 0.2);
    object.name = "piramide";
    return object;
  }

  function tetera() {
    let matTetera = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: 0xffffff
    });
    matTetera.name = "tetera";
    var geometriaTetera = new THREE.TeapotBufferGeometry(
      0.3,
      5,
      true,
      true,
      true,
      true,
      true
    );

    object = new THREE.Mesh(geometriaTetera, matTetera);
    object.position.set(0, 0.15, 0);
    object.name = "tetera";
    return object;
  }

  function casa(){
    var casa = new THREE.Object3D();
    let matCasa = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    
    techo = new THREE.Mesh(
      new THREE.CylinderBufferGeometry(0, 0.27, 0.1, 4),
      matCasa
    );
    techo.position.set(0, 0.41, 0);
    techo.rotation.y += 4;
    techo.name = "techo";

    cuerpo = new THREE.Mesh(
      new THREE.BoxBufferGeometry(0.36, 0.36, 0.36, 1, 1, 1),
      matCasa
    );
    cuerpo.position.set(0, 0.18, 0);
    cuerpo.name = "cuerpo";

    garage = new THREE.Mesh(
      new THREE.BoxBufferGeometry(0.20, 0.17, 0.18, 1, 1, 1),
      matCasa
    );
    garage.position.set(0.26, 0.085, 0.09);
    garage.name = "garage";

    cuerpo2 = new THREE.Mesh(
      new THREE.BoxBufferGeometry(0.20, 0.36, 0.18, 1, 1, 1),
      matCasa
    );
    cuerpo2.position.set(0.26, 0.18, -0.09);
    cuerpo2.name = "cuerpo2";

    casa.name = "casa";
    casa.add(cuerpo);
    casa.add(cuerpo2);
    casa.add(garage);
    casa.add(techo);
    casa.position.set(0.4,0.4,0.4);    
    //scene.add(casa);
    return casa;
  }

  function trayectoriaCam() {
    var spline = new THREE.CatmullRomCurve3([
      new THREE.Vector3(-3, 2, 2),
      new THREE.Vector3(-1, 0, 1),
      new THREE.Vector3(1, 2, 2),
      new THREE.Vector3(3, 1, -2),
      new THREE.Vector3(-2, 2, -1)
    ]);
    spline.curveType = "catmullrom";
    spline.closed = true;

    tubeGeometry = new THREE.TubeBufferGeometry(spline, 150, 0.01, 10, true);
    let mat = new THREE.MeshStandardMaterial({
      side: THREE.DoubleSide,
      color: "#ffffff"
    });
    object = new THREE.Mesh(tubeGeometry, mat);
    parent.add(object);
    // Ocutar trayectoria
    object.visible = false;

    return tubeGeometry;
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
