Frontmatter
Each sheet supports these metadata:

---
title: React.js
layout: 2017/sheet # 'default' | '2017/sheet'

# Optional:
category: React
updated: 2020-06-14
ads: false # Add this to disable ads
weight: -5 # lower number = higher in related posts list
deprecated: true # Don't show in related posts
deprecated_by: /enzyme # Point to latest version
prism_languages: [vim] # Extra syntax highlighting
intro: |
  This is some *Markdown* at the beginning of the article.
tags:
  - WIP
  - Featured

# Special pages:
# (don't set these for cheatsheets)
type: home # home | article | error
og_type: website # opengraph type
---
Prism languages
For supported prism languages:

https://github.com/PrismJS/prism/tree/gh-pages/components
Setting up redirects
This example sets up a redirect from es2015 to es6:

# /es2015.md
---
title: ES2015
category: Hidden
redirect_to: /es6
---
Localizations
See _data/content.yml for chrome strings.

Forking
So you want to fork this repo? Sure, here's what you need to know to whitelabel this:

It's all GitHub pages, so the branch has to be gh-pages.
All other GitHub pages gotchas apply (CNAME, etc).
Edit everything in _data/ - this holds all 'config' for the site: ad IDs, strings, etc.
Edit _config.yml as well, lots of things may not apply to you.
CloudFlare purging
The site devhints.io is backed by CloudFlare. Updates will take 2 days to propagate to the website by default. To make sure recent changes will propagate, use this helper script. It will give instructions on how manual selective cache purging can be done.

./_support/cf-purge.sh
SEO description
There are multiple ways to set meta description.

Keywords (and intro)
Set keywords (and optionally intro). This is the easiest and the preferred way for now.

React cheatsheet - devhints.io
------------------------------
https://devhints.io/react ▼
React.Component · render() · componentDidMount() · props/state · React is a
JavaScript library for building web...
Description (and intro)
Set description (and optionally intro)

React cheatsheet - devhints.io
------------------------------
https://devhints.io/react ▼
One-page reference to React and its API. React is a JavaScript library for
building web user interfaces...

