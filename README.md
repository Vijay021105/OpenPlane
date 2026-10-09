# openPLANE 0.5.0 — runnable Python prototype

openPLANE is a desktop preliminary/conceptual design tool for electric fixed-wing RC aircraft and small UAVs. This repository implements the workflow described in `docs/openPLANE.md`: numerical geometry and component placement, balsa/Depron structural estimates, mass/CG/inertia, low-order aerodynamics, stall and stability screening, electric propulsion matching, performance, mission energy, warnings, optimisation, project files, reports, and an optional OpenVSP/VSPAERO backend.

## Start in 3 commands

### Windows

```bat
py -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
run_openplane.bat
```

Or:

```bat
python run_openplane.py
```

### Linux / macOS

```bash
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
./run_openplane.sh
```

Python 3.10+ is recommended.

The GUI uses **Tkinter** so the repository remains a Python-first, easy-to-run prototype. `numpy` and `matplotlib` are the only pip dependencies. Tkinter is included with normal Windows/macOS Python installers; on some Linux distributions it is a separate system package such as `python3-tk`.

## What works without OpenVSP

The app starts and is useful in analytical mode even when OpenVSP is absent. It supports:

- new-project wizard for purpose/configuration/wing/propulsion arrangement;
- OpenRocket-style project tree + 3-D inspection + numeric property editor;
- **no sliders** and no drag-to-edit geometry or component positions;
- built-in structural materials restricted to **Balsa Wood** and **Depron Sheet**;
- editable motor, propeller, battery, ESC, receiver, flight controller, GPS, payload and servo data;
- editable local SQLite component library seeded from JSON;
- geometry metrics, tail volumes, mass, CG and approximate inertia;
- Level-0 finite-wing aerodynamic estimates and alpha sweep;
- clean/flapped stall-speed and twist-based stall-progression screening;
- neutral point/static margin, coupled CL/Cm trim, analytical stability/control derivatives, 4-state longitudinal/lateral state-space models, eigenvalue-based dynamic modes and perturbation responses;
- servo hinge-torque screening plus derivative-based pitch/roll/yaw authority and stall-safe maneuver-trim limits;
- coupled battery–motor–propeller operating-point estimate;
- motor/ESC/battery/propeller compatibility checks;
- speed sweep, L/D, drag, thrust/power available vs required, climb, endurance and range;
- editable mission segments and mission-energy integration;
- grouped rule-based warnings;
- battery-position grid optimisation, wingspan explorer, actual-geometry tail-volume optimisation, fuselage/wing/tail station optimisation, multi-constraint control-surface optimisation and a coupled airframe optimisation pass;
- `.oplane` save/reopen (ZIP container with `project.json`);
- project JSON export and Markdown/HTML reports;
- 3-D aircraft view with visible motor, propeller, battery, avionics boxes and enabled control surfaces;
- scaled top/side/front three-view drawing inside the GUI;
- PNG/PDF/SVG three-view export;
- CSV aircraft-dimension schedule plus a CAD/fabrication ZIP with separate wing/tail/fuselage PDFs, DXF planforms/control outlines, NACA airfoil DAT files and geometry JSON;
- engineering plots including eigenvalue maps, trim envelope and longitudinal/lateral perturbation responses;
- complete dark mode across Tk panels, analysis text and embedded Matplotlib views;
- hover help for important beginner-facing design inputs.

The analytical models intentionally expose their method and limitations. They are preliminary-design estimates, not flight-safety or certification results.


## Geometry and drawing exports

Two fabrication-oriented exports are available directly from the **File** menu:

- **File → Export Aircraft Dimensions (CSV)…** writes an auditable dimension schedule for the fuselage, main wing, horizontal/vertical tail, canard when enabled, control-surface stations/chords, major component installation coordinates, and calculated CG.
- **File → Export Scaled Three-View (PNG/PDF)…** creates a proportional top/side/front drawing with equal axis scaling inside each view and dimension callouts. SVG is also supported.

The same three-view is available interactively under the **Three-View** analysis tab and through **View → Open Scaled Three-View**.

The 3-D viewer now always shows the enabled **motor, propeller and battery** plus the enabled aileron/flap/elevon/elevator/rudder geometry. Component locations still change only through numeric fields in the Properties panel; there is no drag-to-edit behavior.

## OpenVSP / VSPAERO integration

**OpenVSP is not bundled.** Keep its own distribution/license intact.

The easiest repository-local layout is:

```text
openPLANE_repo/
└── third_party/
    └── openvsp/
        └── OpenVSP/
            ├── ... OpenVSP files ...
            ├── python/
            │   └── ... OpenVSP Python API ...
            ├── vsp.exe / openvsp        (platform dependent)
            └── vspaero.exe / vspaero    (platform dependent)
```

If your downloaded/built OpenVSP tree has a different name, that is fine. The adapter searches common paths under `third_party/openvsp/`.

Alternatively, point directly to the folder containing the OpenVSP Python module:

```bat
set VSP_PYTHONPATH=C:\path\to\OpenVSP\python
python tools\check_openvsp.py
```

Linux/macOS:

```bash
export VSP_PYTHONPATH=/path/to/OpenVSP/python
python3 tools/check_openvsp.py
```

When the checker says `available: True`, restart openPLANE and use:

- **File → Export OpenVSP .vsp3**
- **File → Import OpenVSP .vsp3**
- **Analysis → Run VSPAERO**
- **Tools → Check OpenVSP Configuration**

Read `docs/OPENVSP_SETUP.md` for the detailed setup and troubleshooting guide.

> OpenVSP Python-analysis parameter names have changed across releases. The adapter is defensive and will report a real backend failure rather than displaying a fake zero. If your OpenVSP release needs different analysis-input names, only `openplane/vsp_adapter/adapter.py` should need adjustment.

## Repository layout

```text
openPLANE_repo/
├── run_openplane.py
├── openplane/
│   ├── app.py
│   ├── models.py
│   ├── project_io.py
│   ├── database.py
│   ├── services/
│   ├── gui/
│   ├── vsp_adapter/
│   └── data/
├── docs/
├── schema/
├── tests/
├── tools/
└── third_party/openvsp/
```

The GUI does not contain physics equations. Engineering calculations live in `openplane/services/`.

## Run tests

```bash
python -m unittest discover -s tests -v
```

A headless core smoke test is also available:

```bash
python tools/smoke_test.py
```

## Project file

An `.oplane` file is a normal ZIP archive containing at least:

```text
project.json
airfoils/
polars/
components/
analysis_cache/
reports/
```

This keeps aircraft data human-readable and versionable.

## Important status

This repository is a **working V1 Python prototype**, not the complete production fork of OpenVSP described as the ultimate architecture in the specification. It provides the end-to-end RC/UAV design workflow and a clean OpenVSP adapter boundary. A future C++/Qt fork can reuse the same service contracts and project schemas while replacing the Python GUI and analytical fallback modules.

Before public redistribution, verify current OpenVSP/VSPAERO and third-party data licensing. This repository does not assert or relicense OpenVSP.


## Static Strength (v0.5)

Use **Strength Analysis** in the main menu to define max-G or equivalent-static impact cases, edit the idealized boom/skin structure, run the solver, inspect SFD/BMD/failure maps and view balsa/bamboo reinforcement suggestions. See `docs/STATIC_STRENGTH_V050.md`.
