# Home Assistant Integrations

Custom Home Assistant integrations.

Author: [MarshyMadness](https://github.com/Marshy-Madness)

Each integration lives in **its own repository**, which is what HACS needs. This repo collects them as git submodules under `integrations/`.

| Integration | Repository | What it does |
|---|---|---|
| Homebox Plus | [ha-homebox-plus](https://github.com/Marshy-Madness/ha-homebox-plus) | Homebox inventory: stock tracking, shopping list, maintenance and warranty calendars, NFC tags, voice/LLM tools |
| Memos | [ha-memos](https://github.com/Marshy-Madness/ha-memos) | Memos notes: stats sensors, task list, notify entity, create memos |
| OliveTin | [ha-olivetin](https://github.com/Marshy-Madness/ha-olivetin) | A button for every OliveTin action |
| Vikunja | [ha-vikunja](https://github.com/Marshy-Madness/ha-vikunja) | Vikunja tasks: a to-do list per project, due/overdue sensors, calendar, actions |
| Wolf (Games on Whales) | [ha-wolf](https://github.com/Marshy-Madness/ha-wolf) | Wolf stream sessions and lobbies: sensors, stop/pause controls |

## Installing an integration

In HACS, go to ⋮ → *Custom repositories* and add the integration's own repository URL from the table above as an **Integration**. Don't add this collection repo itself.

## Working with this repo

```bash
# Clone everything
git clone --recurse-submodules https://github.com/Marshy-Madness/HomeAssistant-Integrations.git

# Get new commits for every integration
git submodule update --remote --merge

# Work on one integration: it's a normal git repo
cd integrations/ha-homebox-plus
git switch main
# ...edit, commit...
git push

# Then record the new version in this collection repo
cd ../..
git add integrations/ha-homebox-plus
git commit -m "Bump ha-homebox-plus"
git push
```

### Adding a new integration

1. Create a repo containing `custom_components/<domain>/`, `hacs.json` and `README.md`, and push it to GitHub.
2. `git submodule add https://github.com/Marshy-Madness/<repo>.git integrations/<repo>`
3. Add a row to the table above, then commit and push.
