# openPLANE Changelog

## 0.5.0 — Static Strength & Structural Analysis

- Added idealized boom/skin thin-walled structural model for wing, tail and fuselage/tailboom.
- Added single/multi-cell shear flow and Bredt-Batho torsion compatibility.
- Added Euler-Bernoulli sparse static beam matrix solver using SciPy.
- Added max-G aerodynamic static loads plus equivalent-static hard-landing/severe-impact cases.
- Added SFD/BMD/torsion/deflection, yielding, boom buckling, skin shear and shear-buckling checks.
- Added tailboom vulnerability mapping and balsa/bamboo reinforcement recommendations.
- Added Strength Analysis menu, load-case editor, structural-idealisation editor and visual Strength tab.
- Added optional pyNastran BDF export and detailed theory/reference documentation.
- Added v0.5 structural regression tests.


## 0.4.0 — physics/control/CAD upgrade
- Replaced heuristic dynamic-mode frequencies with analytical finite-wing/tail stability derivatives and 4-state longitudinal/lateral state-space eigenanalysis.
- Added CL/Cm coupled trim, trim-vs-speed envelope and RK4 perturbation responses.
- Added pitch/roll/yaw control-authority analysis with stall-safe maneuver-trim limiting and servo hinge-load margin.
- Rebuilt tail-volume optimiser around actual tail span/chords/arm; rebuilt fuselage optimiser around fuselage length and wing/tail stations.
- Rebuilt control-surface optimiser around control derivatives, roll/yaw targets, maneuver trim, stall margin and servo torque.
- Added sequential coupled airframe optimiser.
- Added CAD/fabrication package export: separate wing/tail/fuselage PDFs, scaled aircraft three-view, dimensions CSV, DXF planforms/control outlines, NACA DAT sections and geometry JSON.
- Added eigenvalue, perturbation and trim-envelope plots.
- Added hover explanations for key design variables.
- Expanded dark mode across Tk widgets, text panes and embedded plots/views.


## 0.2.0

- Added persistent 3-D rendering of motor, propeller and battery placement.
- Added 3-D rendering of enabled ailerons, flaps, elevons, elevator and rudder.
- Added scaled top/side/front three-view drawing in the GUI.
- Added PNG/PDF/SVG three-view export.
- Added CSV aircraft-dimension export for fuselage, wing, tails, control surfaces, component installation locations and CG.
- Exposed motor and battery physical dimensions in the Properties editor.


## 0.1.1

- Fixed Windows/Tkinter startup failure caused by unsupported `pack(..., pad=...)` options.
- Replaced those options with explicit `padx`/`pady` in the 3-D overlay and plot controls.
- Re-ran core tests and GUI startup smoke test after the fix.

## 0.1.0

- Initial runnable Python prototype.
