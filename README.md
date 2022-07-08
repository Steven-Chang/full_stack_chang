# README

## Required Environment / Minimum Setup

- Rails Rails 6.0.0.rc1 (Lots of changes e.g. Webpack instead of pipeline!)

## Credentials / Master Key

```
# Editing
EDITOR=vim rails credentials:edit
# Usage
Rails.application.credentials.aws[:access_key_id]
```

## Binance
Look into this margin trading code if you're still interested
```
# Credential.third.client::Margin::Order.status!(symbol: 'BTCUSDT', orderId: Order.open.first.reference, isIsolated: true
```

## THEME/LAYOUT

- Remark Layout
- https://preview.themeforest.net/item/remark-responsive-bootstrap-4-admin-template/full_screen_preview/11989202?_ga=2.88385496.2146267444.1566298034-944805106.1561035609
- It comes with 6 layouts. After trialling all of them, I have decided that the Topbar layout is my favorite.

## APIS
- https://binance-docs.github.io/apidocs/spot/en/#public-api-definitions