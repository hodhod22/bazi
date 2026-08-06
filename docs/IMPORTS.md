# Import hygiene (avoid compile hangs)

Kabootar can hang or take minutes when one script pulls too many modules
(classes + physics + AI + window APIs together). Prefer **leaf imports**.

## Safe (default for games)

```kab
import "bazi/go/scene"
import "bazi/go/component"
import "bazi/go/behaviour"
import "bazi/go/tick"
import "bazi/go/prefab"
import "bazi/go/playerStep"
import "bazi/core/health"
import "bazi/core/transform"
```

Add AI only when needed:

```kab
import "bazi/ai/follow"          // light chase
import "bazi/go/systems"         // GuardBrain query systems (heavier)
```

Window demos: keep leaf imports (see `examples/go_window.kab`).

## Avoid in gameplay scripts

| Import | Why |
|--------|-----|
| `import "bazi"` | Pulls core + go + extras + ai |
| `import "bazi/go"` + `bazi/go/systems` + `platform_use` together | Often hangs |
| Full `bazi/extras` aggregator | Prefer `bazi/extras/turret` etc. |

Aggregators (`bazi.kab`, `bazi/go.kab`) exist for discovery and docs —
not as the default for shipped games.

## Smoke order

Run examples from `nova-interpreter` with `KABOOTAR_PATH` pointing at `bazi/lib`:

1. `examples/go_arena.kab` — win/lose (core bundle + damage; keep ASCII comments)
2. `examples/go_playable.kab` — GO leaf imports + systems
3. `examples/go_window.kab` — raf + input (leaf only)
