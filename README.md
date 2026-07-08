<div align="center">

<!-- Header with left text and right logo -->
<div style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
  <div style="text-align: left;">
    <strong style="font-size: 1.2em;">The Media Guardian.</strong><br>
    <strong style="font-size: 1em;">Mantra:</strong> Design once, deploy everywhere, learn instantly.<br>
    <strong style="font-size: 1em;">Tagline:</strong> The masterclass in 4D asset management.
  </div>
  <div>
    <img src="https://www.protee.org/images/Semippan/Semippan.png" alt="Sēmippān Logo" width="120" style="border-radius: 12px;">
  </div>
</div>

<!-- Title and badges -->
# Sēmippān – The Media Guardian

[![4D HDI](https://img.shields.io/badge/4D-HDI-blue)](#)
[![4D SRC](https://img.shields.io/badge/4D-SRC-blue)](#)
[![License: Free](https://img.shields.io/badge/License-Free-brightgreen.svg)](#license)
[![Platform: macOS & Windows](https://img.shields.io/badge/Platform-macOS%20%7C%20Windows-lightgrey)](#)
[![4D v21](https://img.shields.io/badge/4D-v21%2B-brightgreen)](#)

</div>

---

## Overview

**Sēmippān** (சேமிப்பான் – *"The one who saves, conserves, the protector"*) is an advanced **How-Do-I (HDI)** and a sophisticated, real-world product from the **ogTools suite**. It is a powerful asset management system deeply integrated into the daily workflow at Protée, demonstrating the full, complex potential of `zen_Nucleus` in a serious production environment.

More than a tool, Sēmippān is a comprehensive guide for implementing professional, centralized UI asset management in 4D. It solves the chaos of managing duplicate icons and media across countless projects by providing a unified repository and a precision engine for four-state UI elements.

---

## Why Sēmippān?

Tired of managing duplicate icons across countless projects? Sēmippān is your ultimate solution for centralized UI asset management.

- **Create & Test with Unprecedented Speed:** Design generic button sets for all your products and specific buttons for individual databases. Prepare different projects and test your designs in a snap.
- **A Unified Repository for All Your Media:** Store all picts, icons, and images in one single, organized place. Create and manage "4-state" button banks (normal, hover, pressed, disabled) in native 4D format.
- **One-Click Global Updates:** Update all your 4D databases with new assets in a single click, ensuring absolute consistency across all your products.
- **Out of the Box, Ready to Use:** Pre-loaded with Google's Material Design icons and fully integrated with `woc_Colours` for perfect palette consistency.

**Sēmippān doesn't just store your images; it orchestrates your entire design ecosystem, from creation to deployment.**

---

## Key Features

### The DCOXolver System: Precision Engine for Four-State UI Elements

Sēmippān standardizes UI behavior with **DCOXolver**, the intelligent color solver that algorithmically calculates perfect **D**efault, **C**lick, **O**ver, and Disabled (**X**) states for any UI element.

This system, powered by the advanced color management of `woc_Colours`, provides granular control through dedicated widgets, allowing you to define:

- A **Master Color**: The foundational color value.
- **State-Specific Colors**: Four independent colors for each DCOX state.
- **Bypass Colors**: Exception values that override the standard rules.
- **Mathematical Operations**: Precisely calculate derived colors using addition and subtraction of values from indexed color spaces, ensuring perfect harmony and contrast across all states.

The entire architecture of TEMPLATES, SETS, and MEDIA is built upon this robust, mathematically precise DCOX foundation.

### A Showcase of Elegant UI Management

Sēmippān demonstrates how `zen_Nucleus` gracefully handles complex UI exceptions and behaviors in a non-blocking, elegant manner. See firsthand how to build interfaces that remain responsive and intuitive, no matter the complexity of the underlying operations.

### Learn by Example

- **See Best Practices in Action:** Explore a real-world, production-ready system for managing complex media libraries and multi-state buttons.
- **Full Source Code Included:** The complete source code is provided. Tear it apart, see how it works, and adapt its powerful logic for your own projects.

**Don't just manage your assets—master the architecture behind them.**

---

## Architecture Overview

Sēmippān's power is built on a robust and modular database architecture, seamlessly managed by `zen_Nucleus` and the ogTools suite.

### Modules

#### 1. Databases Module
Defines the core structure of your product ecosystem.
- **[TYPES]**: A recursive qualifier table, managed by `wor_Recursive`, for hierarchical categorization.
- **[PRODUCTS]**: The master list of all your 4D databases and their respective folder paths.
- **[PATHS]**: Creates a many-to-many relationship between PRODUCTS ↔ PACKS. Defines sub-paths (e.g., `/RESOURCES/`) and external paths for corporate-wide output distribution.

#### 2. Sēmippān Module
The engine of the asset management system.
- **[PACKS]**: A group of BANKS, assigned to one or more PRODUCTS via the PATHS table.
- **[TEMPLATES]**: Stores master DCOXolver configurations. These can be global or linked to BANKS, and used in SETS and MEDIA. Can be individually overloaded by a local DCOXolver definition for precise, granular control.
- **[BANKS]**: The central kernel. A Bank entity is associated with multiple SETS (defining output parameters like icon type, size, and colors) and multiple MEDIA (the assets to be exported).
- **[SETS]**: Defines a complete set of parameters for how to process and export MEDIA for a BANK.
- **[MEDIA]**: Contains specific overloads for SETS variations and a link to the actual picture files in the PICTURES table.

#### 3. Pictures Module
The centralized repository for all visual assets.
- **[PICTURES]**: Stores all pictures to be used for MEDIA, categorizable by types for colors, stroke, and category.
- **[CATEGORIES]**: Provides categorization for the PICTURES table.

#### 4. Vedās Module
The advanced module for corporate-level exports and animations.
- **[KAVYAM]**: Manages animation sequences or complex drawings across a set of PRODUCTS. Essential for sophisticated ogTools suite corporate exports.
- **[KAV_PRO]**: A many-to-many association table linking KAVYAM ↔ PRODUCTS.

This structured yet flexible architecture allows Sēmippān to scale from a single database to managing the consistent branding of an entire corporate suite of products with a single click.

---

## Installation & Dependencies

### Prerequisites
- **4D v21** or higher (for `4DPop` dependency).
- An **ogTools Suite lifetime license** is embedded into Sēmippān.
- The following ogTools components are required (and included in the suite):
  - `wok_Krolific` – Licensing, Simplified
  - `wox_Xlibrary` – The Silent Engine
  - `woc_Colours` – Colours, Reloaded
  - `waz_Wazar` – UI, Unified
  - `wob_Boxes` – The Universal Container
  - `wor_Recursive` – The Infinite, Tamed
  - `wos_SvgWidgets` – Draw your verses
  - `wqr_QuickReport` – A 4D legacy fork
  - `zen_Nucleus` – The Final Verse

### Installation (GitHub)

Clone/download the project from the following Git URL: `protee/semippan.4dbase`. To try it with sample data, download SampleData.zip from the Releases page and unzip its contents into Data/.

> **Note**: For team development, commit the dependency configuration file (`dependencies.json`) to your source control.

---

## Part of the ogTools Suite

Sēmippān is a flagship HDI within the comprehensive **ogToolsSuite**—an integrated development ecosystem for 4D. Other key components include:

| Icon | Component | Description |
|------|-----------|-------------|
| <img src="https://www.protee.org/images/wok_Krolific/wok_Krolific.png" alt="wok_Krolific Logo" width="60" style="border-radius: 12px;"> | **wok_Krolific** | License manager. |
| <img src="https://www.protee.org/images/wox_Xlibrary/wox_Xlibrary.png" alt="wox_Xlibrary Logo" width="60" style="border-radius: 12px;"> | **wox_Xlibrary** | Core utilities for everyday development tasks. |
| <img src="https://www.protee.org/images/wod_DevTools/wod_DevTools.png" alt="wod_DevTools Logo" width="60" style="border-radius: 12px;"> | **wod_DevTools** | Developer tools, instant documentation generation. |
| <img src="https://www.protee.org/images/wom_Make/wom_Make.png" alt="wom_Make Logo" width="60" style="border-radius: 12px;"> | **wom_Make** | Sophisticated builder. |
| <img src="https://www.protee.org/images/woc_Colours/woc_Colours.png" alt="woc_Colours Logo" width="60" style="border-radius: 12px;"> | **woc_Colours** | Advanced, indexed color management engine. |
| <img src="https://www.protee.org/images/waz_Wazar/waz_Wazar.png" alt="waz_Wazar Logo" width="60" style="border-radius: 12px;"> | **waz_Wazar** | Intelligent UI widgets for modern interfaces. |
| <img src="https://www.protee.org/images/wob_Boxes/wob_Boxes.png" alt="wob_Boxes Logo" width="60" style="border-radius: 12px;"> | **wob_Boxes** | Secure, Dropbox-like file repository. |
| <img src="https://www.protee.org/images/wor_Recursive/wor_Recursive.png" alt="wor_Recursive Logo" width="60" style="border-radius: 12px;"> | **wor_Recursive** | Manage hierarchical data with ease. |
| <img src="https://www.protee.org/images/wqr_QuickReport/wqr_QuickReport.png" alt="wqr_QuickReport Logo" width="60" style="border-radius: 12px;"> | **wqr_QuickReport** | A fork of 4D QuickReport with ORDA wrapper. |
| <img src="https://www.protee.org/images/zen_Nucleus/zen_Nucleus.png" alt="zen_Nucleus Logo" width="60" style="border-radius: 12px;"> | **zen_Nucleus** | The complete full ORDA framework, where every component finds its meaning. |

> Together, these components form a powerful framework that allows developers to focus on unique business logic rather than reinventing the wheel.

---

## License

Sēmippān is a **free HDI** and is part of the ogTools suite. No valid license is required for use. An **ogTools Suite lifetime license for Sēmippān** is included with the product. 

---

## Localization

- Sēmippān supports the following languages out‑of‑the‑box: 🇺🇸 English (EN)

- ogToolsSuite supports the following languages out‑of‑the‑box: 🇺🇸 English (EN), 🇫🇷 French (FR), 🇪🇸 Spanish (ES), 🇩🇪 German (DE)

---

## Support & Resources

- **Official Website**: [https://www.protee.org](https://www.protee.org)
- **Product Page**: [https://www.protee.org/index.php/products-hdi/semippan](https://www.protee.org/index.php/products-hdi/semippan)
- **Documentation**: Full documentation and HDI demos are included with your purchase.

For direct inquiries:
- **Email**: [info@protee.org](mailto:info@protee.org)

---

## About the Creator

Sēmippān and the ogToolsSuite are developed by **Protée sarl**, a company with over 30 years of expertise in 4D development. Led by Olivier Grimbert, the team focuses on delivering high‑quality, production‑grade tools that enhance developer productivity and application reliability.

---

<div align="center">
  <sub>Built with ❤️ for the 4D community by Protée sarl. © 2016 - Present</sub>
</div>