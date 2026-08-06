# Bazi

**Bazi** är Kabootars spelkomponent-ramverk — **separat git-repo** från motorruntime (`nova-interpreter`).

| Lager | Repo | Import |
|-------|------|--------|
| Motor | `nova-interpreter` | `import "game/…"` (ECS, scene, render, physics, …) |
| **Bazi** | detta repo | `import "bazi/…"` (GO/behaviours, Health, AI, …) |

## Ide: bättre än Unity-modellen

ECS ligger **i botten** (snabb data). Ovanpå: `bazi/go` — GameObject + behaviours som **du** skriver; `tick` kör alla automatiskt.

| Unity | Bazi |
|-------|------|
| GameObject + MonoBehaviour | `spawnGo` + `addBehaviour` / `addBehaviourFn` |
| Update() magi / reflection | Tät `behaviours[]`-lista, O(n), ingen Find |
| GetComponent varje frame | `goGet` / ECS `query` när du behöver |
| Blandad data+logik | Data = komponenter, logik = behaviour |

Importera bara det spelet behöver (Unity-package-stil).

## Setup

```bash
export KABOOTAR_PATH="/absolute/path/to/bazi/lib"
# Motor-lib: kör från nova-interpreter, eller lägg dess lib/ på path
```

## GameObject + Behaviour

```kab
import "bazi/go"
import "bazi/core/transform"

class Spin {
    deg: Number
    fn init() { self.deg = 0.0 }
    fn update(ctx) {
        // Class methods: ctx["get"]/set/done (modul-imports syns inte i class).
        let get = ctx["get"]
        let set = ctx["set"]
        let done = ctx["done"]
        self.deg = self.deg + 90.0 * ctx["dt"]
        let t = get(ctx, "Transform")
        t["yaw"] = self.deg
        ctx = set(ctx, "Transform", t)
        return done(ctx, self)
    }
}

let scene = createScene()
let spawned = spawnGo(scene, "Spinner")
scene = spawned["scene"]
let id = spawned["id"]
scene = addComp(scene, id, "Transform", createTransform(0.0, 0.0, 0.0))
scene = addBehaviour(scene, id, Spin())
scene = tick(scene, dt)   // kör alla behaviours
```

Snabbaste vägen (ingen klass): `addBehaviourFn(scene, id, myUpdateFn)`.

Lifecycle (`addBehaviourSpawn`): `onSpawn` → `update` → `onDestroy` (via `destroyGo`).  
Prefab: `spawnCoreGo(scene, "Player", x, y, z, hp, speed)`.  
Uppslag: `findGo(scene, "Player")`.  
PlayerInput-helper: `goCreatePlayerInput(null)` + wish-driven move i `update` (se `go_playable.kab`).

### Core / combat (rå ECS)

```kab
import "bazi/core"
w = attachCoreBundle(w, id, 0.0, 1.0, 0.0, 100.0, 5.0)
let hit = damageEntity(w, id, 25.0, null)
w = hit["world"]
```

## Layout

```
lib/
  bazi.kab                 # aggregator (tung — preferera leaf-imports)
  bazi/
    go.kab + go/           # Scene, GameObject, behaviours, tick
    core.kab + core/       # Transform, Health, Movement, player, bundle
    extras/                # vehicle, inventory, turret, projectile, …
    ai/                    # patrol, follow, flee, stateMachine, brain
templates/                 # behaviour.kab, guard.kab, …
```

## Skapa / ta bort komponenter

```bash
./tools/new-component.sh extras myDash
./tools/remove-component.sh extras myDash
```

## Exempel

```bash
cd ../nova-interpreter
export KABOOTAR_PATH="$(pwd)/../bazi/lib"
kabootar run ../bazi/examples/go_playable.kab
kabootar run ../bazi/examples/go_behaviours.kab
kabootar run ../bazi/examples/go_player.kab
kabootar run ../bazi/examples/minimal.kab
kabootar run ../bazi/examples/combat_loop.kab
kabootar run ../bazi/examples/guard_ai.kab
kabootar run ../bazi/examples/inventory_ops.kab
kabootar run ../bazi/examples/projectile_smoke.kab
```

## Licens

Bazi är **proprietär** — se [LICENSE](LICENSE).

**Betallicens införs när första fasen (Phase 1) är klar.** Tills dess får du använda Bazi för utvärdering och utveckling utan betalning. Planerade priser därefter (USD / år):

| Användare | Pris / år |
|-----------|-----------|
| Privatperson (Individual) | **$10** |
| Företag (Company) | **$100** |

Priserna kan höjas senare (med förvarning). Äganderätt och “as is”-disclaimer gäller redan nu.
