# Hekili

## [v8.3.0-04-22.04](https://github.com/Hekili/hekili/tree/v8.3.0-04-22.04) (2020-05-14)
[Full Changelog](https://github.com/Hekili/hekili/compare/v8.3.0-04-22.03...v8.3.0-04-22.04)

- APL Updates:  Blood, Survival, Subtlety.  
    Don't auto-snapshot when opening the config UI.  
- Fire Mage:  Update default potion.  
- Update talents on PLAYER\_TALENT\_UPDATE.  
- Requeue specialization update if no spec data is available.  
- Don't setup spec information when it's not yet available.  
- Tweak Razor Coral to avoid errors.  
- Support variable NPC IDs for pets (esp. Warlocks w/ glyphs).  
    Support mounted/is\_mounted for ruling out summons.  ability.nomounted will block an ability if you are mounted.  
    Add ability.icd to prevent recasting an ability that you'd just cast (icd = internal cooldown).  
- Hunters, Frost Mage:  Don't recommend summoning pets while mounted.  
- Unholy:  Don't recommend Outbreak when you don't have a target if there's already an Outbreak running somewhere.  
    Don't recommend Raise Dead when mounted (wait to see after you dismount).  
    Don't festercycle without Festermight.  
- Identify Warlock pets more accurately.  
    Don't recommend Soul Strike without a living Felguard.  
- Handle talent changes and spec changes more quickly and gracefully.  
- Do less work when swapping talents (vs. swapping specs).  
    Automatically snapshot the priority if a recommendation couldn't be made.  
    Tweak Bartender4 keybind detection.  
    Track some performance information in combat.  
    Don't run scripts that we know have errors.  
    Test Razor Coral changes.  
- DKs:  Align Rune handling between specs.  
- Fix a rounding error that could prevent DK rune regeneration forecast.  
    NOTE:  This fix can impact other specializations and needs more testing.  
