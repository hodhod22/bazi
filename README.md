# Bazi

**Bazi** är Kabootars spelkomponent-ramverk — **separat git-repo** från motorruntime (`nova-interpreter`).

| Lager | Repo | Import |
|-------|------|--------|
| Motor | `nova-interpreter` | `import "game/…"` (ECS, scene, render, physics, …) |
| **Bazi** | detta repo | `import "bazi/…"` (Health, vehicle, AI, …) |

Som Unity packages: plocka bara de komponenter spelet behöver.

## Setup

```bash
export KABOOTAR_PATH="/absolute/path/to/bazi/lib"
# Motor-lib måste också hittas (cwd i nova-interpreter, eller lägg till dess lib/)
```

## Användning

```kab
import "game/ecs"
import "bazi/core"                 # Transform, Health, Movement, …
import "bazi/extras/vehicle"       # bara det du vill ha
```

Hela kitet (opt-in):

```kab
import "bazi"
```

## Layout

```
lib/
  bazi.kab                 # aggregator: allt
  bazi/
    core.kab               # essentials
    extras/                # vehicle, inventory, rope, dialog, stealth, turret, puzzle
    ai/                    # patrol, follow, flee, stateMachine
    extras.kab / ai.kab    # aggregators
```

## Skapa / ta bort komponenter

```bash
./tools/new-component.sh extras myDash
# → lib/bazi/extras/myDash.kab + rad i extras.kab

./tools/remove-component.sh extras myDash
```

I spelet räcker det ofta att **inte importera** en komponent. I din fork: radera filen med `remove-component.sh`.

## Exempel

```bash
export KABOOTAR_PATH="$(pwd)/lib"
# Kör från miljö där kabootar + nova-interpreter/lib finns
kabootar run examples/minimal.kab
```
