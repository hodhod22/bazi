# Bazi checkout setup

Paid licensing starts only after a public **Phase 1 complete** announcement.
Until then, leave buy buttons disabled on `site/index.html`.

## Recommended: Lemon Squeezy

1. Create a store and two products:
   - **Bazi Individual** — $10 / year (subscription)
   - **Bazi Company** — $100 / year (subscription)
2. Copy each product’s **Buy** / checkout URL.
3. Either:
   - set them in `site/index.html` on the two `#buy-*` anchors and remove `aria-disabled`, or
   - inject before the page script:

```html
<script>
  window.BAZI_CHECKOUT = {
    individual: "https://YOUR_STORE.lemonsqueezy.com/checkout/buy/XXXXXXXX",
    company: "https://YOUR_STORE.lemonsqueezy.com/checkout/buy/YYYYYYYY"
  };
</script>
```

4. After payment, send licensees a receipt email (“Licensed to …”) and optionally
   a private release tag or license key. GitHub source stays visible; the license
   is the compliance layer.

## Alternative: Stripe Payment Links

Same flow with Stripe Payment Links or Checkout Sessions; put the two URLs in
`BAZI_CHECKOUT` as above.

## Go-live checklist

- [ ] Arena / playable demos green (`examples/go_arena.kab`, `go_window.kab`)
- [ ] Public announcement: “Phase 1 complete — paid licensing starts”
- [ ] Update LICENSE Phase 1 notice (remove “not in force” when ready)
- [ ] Wire live checkout URLs
- [ ] Host `site/index.html` (GitHub Pages, Cloudflare Pages, or custom domain)

## Host locally

```bash
cd site
python -m http.server 8080
# open http://127.0.0.1:8080/
```
