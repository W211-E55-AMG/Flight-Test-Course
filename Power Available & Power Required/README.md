# POWER AVAILABLE & POWER REQUIRED

This project analyzes the aerodynamic efficiency and performance characteristics of the Cessna 172S (C172S) aircraft. Using data from the Pilot's Operating Handbook (POH) and Simulink models, thrust, drag, velocity relationships, and altitude performance are explored.

## Goals

1. Present **Oswald's efficiency factor (e)** and **flat plate area (f)** for the C172S based on the POH.
2. Construct a **Simulink model for thrust** using the provided engine and propeller data.
3. Construct a **Simulink model to determine thrust and drag vs. velocity** in the same simulation.
4. Plot **true airspeed vs. altitude** for:
   - Full throttle.
   - 75%, 65%, and 55% power lines.

## Process

### 1. Thrust and Drag Intercepts (Top Image)
- The **thrust and drag vs. velocity** graph is generated using the Simulink model.
- **Intercept points** (where thrust equals drag) are identified for each power setting (full throttle, 75%, 65%, 55%). These points represent the equilibrium conditions for steady flight.

### 2. Mapping to Altitude (Bottom Image)
- The intercept points from the thrust-drag graph are used to derive the envelope curve.
- For each **true airspeed (TAS)** at the intercept points, the corresponding **altitude** is determined using performance tables or POH data.
- These TAS-altitude pairs are plotted for full throttle, 75%, 65%, and 55% power lines to form the **envelope curve** (blue line).

### 3. Envelope Curve Insights
- The envelope curve provides operational boundaries for the aircraft based on power settings and altitude limits.
- It highlights the maximum achievable altitude at various power levels and velocities.

## Results

1. **Aerodynamic Parameters**:
   - **Oswald’s Efficiency Factor (e):** [Insert value here].
   - **Flat Plate Area (f):** [Insert value here].

2. **Performance Plots**:
   - Thrust and drag vs. velocity (top image).
   - True airspeed vs. altitude, including full throttle, 75%, 65%, and 55% power lines, and the envelope curve (bottom image).

![Performance Graphs](https://github.com/user-attachments/assets/e5f9c59b-becc-4326-9943-bd9133b18ec4)

## Simulink Models
- **Thrust Model**: Simulates thrust based on engine and propeller data.
- **Thrust and Drag Model**: Determines thrust and drag vs. velocity.
- Screenshots of the major Simulink systems:
  - [Include thrust model screenshot]
  - [Include thrust-drag simulation screenshot]

## Deliverables

1. Calculation of **Oswald’s efficiency (e)** and **flat plate area (f)**.
2. Simulink models for thrust and thrust-drag simulations.
3. Performance plots:
   - Thrust and drag vs. velocity.
   - True airspeed vs. altitude for full throttle, 75%, 65%, and 55% power settings.
