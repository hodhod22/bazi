# Bazi - Getting Started Guide

Bazi is a Unity-like game engine built on the Kabootar programming language, designed for high-quality 2D and 3D game production with modern ECS architecture.

## Installation

```kab
import "bazi"
```

## Core Concepts

### GameObjects and Components

Bazi uses an Entity-Component-System (ECS) architecture similar to Unity:

```kab
import "bazi/go/scene"
import "bazi/go/component"

// Create a scene
let scene = createScene()

// Spawn a GameObject
let spawned = spawnGo(scene, "Player")
scene = spawned["scene"]
let playerId = spawned["id"]

// Add components
scene = addComp(scene, playerId, "Transform", createTransform(0.0, 0.0, 0.0))
scene = addComp(scene, playerId, "Rigidbody", createRigidbody(1.0, 0.0, 0.05, true))
```

### Prefabs

Create reusable game objects with the prefab system:

```kab
import "bazi/prefabSystem"

// Create a prefab
let prefab = createPrefab("Enemy")
prefab = setPrefabRoot(prefab, gameObject)
prefab = addPrefabComponent(prefab, createRigidbody(1.0, 0.0, 0.05, true))

// Instantiate the prefab
let instance = instantiatePrefab(scene, prefab, { "x": 10.0, "y": 0.0, "z": 0.0 }, { "x": 0.0, "y": 0.0, "z": 0.0 }, null)
```

### Scene Management

Load and save scenes with hierarchy:

```kab
import "bazi/sceneHierarchy"
import "bazi/sceneSaveLoad"

// Create hierarchy
let hierarchy = createSceneHierarchy()
hierarchy = addRootNode(hierarchy, playerId, "Player")

// Save scene
let sceneData = saveScene(scene, hierarchy, "MainScene")

// Load scene
let loaded = loadScene(sceneData, scene, hierarchy)
```

## Components

### Transform

Position, rotation, and scale:

```kab
import "bazi/core/transform"

let transform = createTransform(0.0, 0.0, 0.0)
transform = setTransformPos(transform, 10.0, 5.0, 0.0)
```

### Rigidbody

Physics simulation:

```kab
import "bazi/components/rigidbody"

let rb = createRigidbody(1.0, 0.0, 0.05, true)
rb = setRigidbodyVelocity(rb, 5.0, 0.0, 0.0)
rb = addRigidbodyForce(rb, { "x": 0.0, "y": 100.0, "z": 0.0 }, "force")
```

### Mesh Renderer

Visual rendering:

```kab
import "bazi/components/meshRenderer"

let renderer = createMeshRenderer("models/player.mesh", "materials/player.mat")
renderer = setMeshRendererEnabled(renderer, true)
```

### Audio Source

Sound playback:

```kab
import "bazi/components/audioSource"

let audio = createAudioSource("sounds/jump.wav")
audio = setAudioSourceVolume(audio, 0.8)
audio = setAudioSourceSpatialBlend(audio, 1.0)
```

## Input System

Unified input for keyboard, mouse, gamepad, and touch:

```kab
import "bazi/input/inputSystem"

let input = createInputSystem()

// Create action map
let actionMap = createActionMap("Player")
actionMap = createAction(actionMap, "Jump", { "type": "key", "key": "Space" })
actionMap = createAction(actionMap, "Move", { "type": "axis", "source": "gamepad", "axis": "leftStick" })
input = addActionMap(input, actionMap)

// Check input
if isActionPressed(input, "Player", "Jump") {
    // Jump
}

let moveAxis = getActionValue(input, "Player", "Move")
```

## UI System

Create user interfaces with Canvas and UI elements:

```kab
import "bazi/ui/canvas"
import "bazi/ui/elements"

let canvas = createCanvas()
canvas = setCanvasRenderMode(canvas, "screenSpaceOverlay")

let button = createButton()
button = setButtonOnClick(button, onButtonClick)
canvas = addUIElement(canvas, button)

let text = createText("Hello World", 24, { "r": 1.0, "g": 1.0, "b": 1.0, "a": 1.0 })
canvas = addUIElement(canvas, text)
```

## Physics Integration

Physics simulation with nova-interpreter:

```kab
import "bazi/physics/integration"

let physicsWorld = createPhysicsWorld()
physicsWorld = setPhysicsGravity(physicsWorld, 0.0, -9.81, 0.0)

// Step physics
let result = stepPhysics(scene, physicsWorld, dt)
scene = result["scene"]
physicsWorld = result["physicsWorld"]

// Check collisions
let collisions = checkCollisions(scene, physicsWorld)
```

## Asset Management

Load and manage game assets:

```kab
import "bazi/assets"

let assetManager = createAssetManager()

// Load texture
let texture = loadTexture(assetManager, "PlayerTexture", "textures/player.png", "rgba")

// Create mesh
let mesh = createMeshFromData(assetManager, "PlayerMesh", vertices, normals, uvs, triangles)

// Create material
let material = createMaterial(assetManager, "PlayerMaterial", "shaders/pbr.wgsl")
material = setMaterialProperty(material, "metallic", 0.5)
material = setMaterialTexture(material, "albedo", "PlayerTexture")
```

## Building and Publishing

Build for different platforms:

```kab
import "bazi/build/buildSystem"

let config = createBuildConfig()
config = setBuildPlatform(config, "web")
config = addBuildScene(config, "scenes/main.bazi")
config = setBuildOutputPath(config, "./build")

let report = buildProject(config, sceneData)
```

## Next Steps

- Explore the component system in `bazi/components/`
- Learn about the prefab system in `bazi/prefabSystem.kab`
- Check out UI elements in `bazi/ui/`
- Read physics integration in `bazi/physics/integration.kab`

## Advantages Over Unity

- **Modern ECS Architecture**: Better performance and data-oriented design
- **Kabootar Language**: More expressive and type-safe than C#
- **Integrated Game Engine**: nova-interpreter provides advanced rendering (PBR, post-processing)
- **Flexible Build System**: Easy deployment to web, desktop, and mobile
- **Built-in Profiling**: Advanced debugging and performance tools
